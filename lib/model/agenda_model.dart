import 'package:mobx/mobx.dart';
import 'package:emanuellemepoupe/model/pessoa_model.dart';
part 'agenda_model.g.dart';

class AgendaModel = _AgendaModelBase with _$AgendaModel;
 abstract class _AgendaModelBase with Store {
  @observable
  String agenIdGlobal;
  @action
  alteraAgenIdGlobal(String value) => agenIdGlobal = value;

  @observable
  String agenTitulo;
  @action
  alteraAgenTitulo(String value) => agenTitulo = value;

  @observable
  String agenDataInicio;
  @action
  alteraAgenDataInicio(String value) => agenDataInicio = value;

  @observable
  String agenHoraInico;
  @action
  alteraAgenHoraInico(String value) => agenHoraInico = value;

  @observable
  String agenHoraFim;
  @action
  alteraAgenHoraFim(String value) => agenHoraFim = value;

  @observable
  String agenDescricao;
  @action
  alteraAgenDescricao(String value) => agenDescricao = value;

  @observable
  String agenCor;
  @action
  alteraQuantParcelas(String value) => agenCor = value;

  @observable
  bool agenDiaTodo = false;
  @action
  alteraAgenDiaTodo(bool value) => agenDiaTodo = value;

  @observable
  bool agenEventoAtivo = false;
  @action
  alteraAgenEventoAtivo(bool value) => agenEventoAtivo = value;

  @observable
  String agenPessoaIdVinculado;
  @action
  alteraAgenPessoaIdVinculado(String value) => agenPessoaIdVinculado = value;

  @observable
  PessoaModel pessoaModel;
  @action
  alteraAgenPessoaModel(PessoaModel value) => pessoaModel = value;

  @observable
  List agendaModelSnapShot;
  @action
  alteraAgenListaEventosSnapShot(List value) => agendaModelSnapShot = value;

  _AgendaModelBase();

  // ignore: unused_element
  _AgendaModelBase.fromMap(Map map) {
    agenIdGlobal = map["agenIdGlobal"].toString();
    agenTitulo = map["agenTitulo"];
    agenDataInicio = map["agenDataInicio"];
    agenHoraInico = map["agenHoraInico"];
    agenHoraFim = map["agenHoraFim"];
    agenDescricao = map["agenDescricao"];
    agenCor = map["agenCor"];
    agenDiaTodo = map["agenDiaTodo"] == 0 ? false : true;
    agenEventoAtivo = map["agenEventoAtivo"] == 0 ? false : true;
    agenPessoaIdVinculado = map["agenPessoaIdVinculado"];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      "agenIdGlobal": agenIdGlobal,
      "agenTitulo": agenTitulo,
      "agenDataInicio": agenDataInicio,
      "agenHoraInico": agenHoraInico,
      "agenHoraFim": agenHoraFim,
      "agenDescricao": agenDescricao,
      "agenCor": agenCor,
      "agenDiaTodo": agenDiaTodo,
      "agenEventoAtivo": agenEventoAtivo,
      "agenPessoaIdVinculado": agenPessoaIdVinculado
    };

    return map;
  }

  @override
  String toString() {
    return "Agenda[agenTitulo : $agenTitulo,"
        "agenDataInicio: $agenDataInicio,"
        "agenHoraInico: $agenHoraInico,"
        "agenHoraFim: $agenHoraFim,"
        "agenDescricao: $agenDescricao,"
        "agenCor: $agenCor,"
        "agenDiaTodo: $agenDiaTodo,"
        "agenEventoAtivo: $agenEventoAtivo"
        "agenPessoaIdVinculado: $agenPessoaIdVinculado"
        "]";
  }
}
