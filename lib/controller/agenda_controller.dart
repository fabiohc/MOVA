import 'package:emanuellemepoupe/controller/util.dart';
import 'package:emanuellemepoupe/helperBD/agenda_helperdb.dart';
import 'package:emanuellemepoupe/repository/agenda_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_neat_and_clean_calendar/flutter_neat_and_clean_calendar.dart';
import 'package:emanuellemepoupe/constants/constants_color.dart';
import 'package:emanuellemepoupe/model/agenda_model.dart';
part 'agenda_controller.g.dart';

class AgendaController = _AgendaControllerBase with _$AgendaController;

abstract class _AgendaControllerBase with Store {
  @observable
  var agendaModel = AgendaModel();

  final agendahelper = new AgendaHelper();

  final agendaRepository = new AgendaRepository();

  final util = Util();

  var tituloEvento = ValueNotifier<String>('');

  var horaInicio = ValueNotifier<String>('');

  var horaFim = ValueNotifier<String>('');

  final switchDiatodo = ValueNotifier<bool>(false);

  final switchConcluido = ValueNotifier<bool>(false);

  mudahoraInicio(String value) {
    horaInicio.value = value;
  }

  mudahoraFim(String value) {
    horaFim.value = value;
  }

  mudaswitchDiatodo(bool value) {
    switchDiatodo.value = value;
  }

  mudaswitchConcluido(bool value) {
    switchConcluido.value = value;
  }

  insereEvento() async {
    agendaModel.alteraAgenIdGlobal(((util.obtenhaIdGlobal("agen"))));

    final dataHoraInicio =
        formateDataAgenda(agendaModel.agenDataInicio, horaInicio.value);
    final dataHoraFim =
        formateDataAgenda(agendaModel.agenDataInicio, horaFim.value);

    agendaModel
        .alteraAgenDataInicio(agendaModel.agenDataInicio.replaceAll("/", "-"));
    agendaModel.alteraAgenHoraInico(dataHoraInicio);
    agendaModel.alteraAgenHoraFim(dataHoraFim);

    await agendahelper.insert(agendaModel);

    await agendaRepository.insertFirestore(agendaModel);
  }

  obtenhaEventosAgenda() async {
    NeatCleanCalendarEvent compromisso;
    Map<DateTime, List<NeatCleanCalendarEvent>> events = {};
    try {
      List<AgendaModel> comp = await agendahelper.selectAll();

      var chaveData = comp.map((e) => (e.agenDataInicio)).toSet().toList();

      chaveData.forEach((data) {
        List<NeatCleanCalendarEvent> listaCompromissos = [];
        Map<DateTime, List<NeatCleanCalendarEvent>> _events = {};
        var listaPorData =
            comp.where((x) => x.agenDataInicio.contains(data)).toList();

        listaPorData.forEach((element) {
          DateTime dataInicio =
              new DateFormat("dd-MM-yyyy HH:mm").parse(element.agenHoraInico);
          DateTime dataFim =
              new DateFormat("dd-MM-yyyy HH:mm").parse(element.agenHoraFim);

          var inicio = DateTime(dataInicio.year, dataInicio.month,
              dataInicio.day, dataInicio.hour, dataInicio.minute);
          var fim = DateTime(dataFim.year, dataFim.month, dataFim.day,
              dataFim.hour, dataFim.minute);

          compromisso = (NeatCleanCalendarEvent(element.agenTitulo,
              startTime: inicio,
              endTime: fim,
              description: element.agenDescricao == null
                  ? "Descrição não adicionada"
                  : element.agenDescricao,
              isAllDay: element.agenDiaTodo,
              isDone: element.agenEventoAtivo,
              location: " ",
              color: kOrangeAccentColor));

          listaCompromissos.add(compromisso);
        });

        DateTime dataformatada = new DateFormat("dd-MM-yyyy").parse(data);
        _events = {
          DateTime(dataformatada.year, dataformatada.month, dataformatada.day):
              listaCompromissos
        };

        events.addAll(_events);
      });

      return events;
    } catch (e) {
      print("Error: " + e.message + "Erro no ao buscar eventos da agenda");
    }
  }

  formateDataAgenda(String data, String horaMinuto) {
    try {
      DateFormat dateFormat = DateFormat("dd-MM-yyyy HH:mm:ss");
      data = data + " " + horaMinuto;
      if (data.contains("/")) data = data.replaceAll("/", "-");

      DateTime dataformatada = new DateFormat("dd-MM-yyyy HH:mm").parse(data);

      String dataHora = dateFormat.format(DateTime(
          dataformatada.year,
          dataformatada.month,
          dataformatada.day,
          dataformatada.hour,
          dataformatada.minute));

      return dataHora;
    } catch (e) {
      return "Erro ao obter data do compromisso";
    }
  }

  @observable
  deleteRegistroFirestore(List<AgendaModel> despesaAddFirestore) async {
    despesaAddFirestore.forEach((eventoFirebase) {
      agendahelper.delete(eventoFirebase.agenIdGlobal);

      if (eventoFirebase.agendaModelSnapShot != null) {
        eventoFirebase.agendaModelSnapShot.forEach((parcela) {
          agendahelper.delete(parcela.parcelaIdGlobal);
        });
      }
    });
  }

  atualizeEventoFirebase(List<AgendaModel> despesaAddFirestore) async {
    despesaAddFirestore.forEach((eventoFirebase) {
      agendahelper.update(eventoFirebase);

      if (eventoFirebase.agendaModelSnapShot != null) {
        eventoFirebase.agendaModelSnapShot.forEach((evento) {
          agendahelper.update(evento);
        });
      }
    });
  }

  @observable
  insiraNovoEventoFirebase(List<AgendaModel> eventoAddFirestore) async {
    final List<AgendaModel> listaEventosLocal = await agendahelper.selectAll();
    List<AgendaModel> listaNovosRegistros = [];

    if (listaEventosLocal.length == 0) {
      listaNovosRegistros = eventoAddFirestore;
    } else {
      eventoAddFirestore.forEach((novoRegistro) {
        var existeRegistro = listaEventosLocal
            .any((x) => x.agenIdGlobal.contains(novoRegistro.agenIdGlobal));

        if (existeRegistro == false) {
          listaNovosRegistros.add(novoRegistro);
        }
      });
    }

    if (listaNovosRegistros != null && listaNovosRegistros.length > 0) {
      listaNovosRegistros.forEach((eventoFirebase) {
        agendahelper.insert(eventoFirebase);

        if (eventoFirebase.agendaModelSnapShot != null) {
          eventoFirebase.agendaModelSnapShot.forEach((evento) {
            var eventoAdd = AgendaModel.fromMap(evento);
            agendahelper.insert(eventoAdd);
          });
        }
      });
    }
    listaNovosRegistros.clear();
    eventoAddFirestore.clear();
  }
}
