import 'package:emanuellemepoupe/constants/constants_color.dart';
import 'package:emanuellemepoupe/controller/carteira_controller.dart';
import 'package:emanuellemepoupe/model/despesa_model.dart';
import 'package:emanuellemepoupe/model/parcela_model.dart';
import 'package:emanuellemepoupe/model/receita_model.dart';
import 'package:emanuellemepoupe/repository/despesa_repository.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
part 'parcela_controller.g.dart';

class ParcelaController = _ParcelaControllerBase with _$ParcelaController;

abstract class _ParcelaControllerBase with Store {
  var repositoryHelper = DespesaRepository();

  List<Map<String, dynamic>> verificaStatusPagamento(ParcelaModel parcela) {
    if (parcela.parcelaStatusPag == true)
      return [
        {"icon": "assets/icons/pago_check.svg", "color": kGreenAccentColor},
      ];

    DateFormat inputFormat = DateFormat("dd/MM/yyyy");
    DateTime parcelaData = inputFormat.parse(parcela.parcelaData);
    if (parcelaData == DateTime.now())
      return [
        {"icon": "assets/icons/menos.svg", "color": kGreenAccentColor},
      ];

    if (parcelaData.isBefore(DateTime.now()))
      return [
        {"icon": "assets/icons/Nao pago X.svg", "color": kRedAccentColor},
      ];

    return [
      {"icon": "assets/icons/arrow_right.svg", "color": kGreenAccentColor},
    ];
  }

  atualizeStatusPagamentoParcela(dynamic objetoReceitaDespesa) async {
   
    var parcela = _ObtenhaParcelaParaUpdate(objetoReceitaDespesa);

    await parcelaHelper.update(parcela);
    repositoryHelper.updateParcelaFirestore(parcela);
  }

  // ignore: non_constant_identifier_names
  ParcelaModel _ObtenhaParcelaParaUpdate(dynamic objetoReceitaDespesa) {
    var parcelaUpdate;

    if (objetoReceitaDespesa is DespesaModel) {
      var despesa = objetoReceitaDespesa;

      parcelaUpdate = objetoReceitaDespesa.parcelaModel
          .where((x) =>
              x.parcelaIdGlobal == despesa.despIdGlobal &&
              x.parcelaData == despesa.despData)
          .single;

      parcelaUpdate.parcelaValor = util
          .converteStringToDouble(objetoReceitaDespesa.despValor)
          .toString();
      parcelaUpdate.parcelaStatusPag = objetoReceitaDespesa.despesaStatusPag;
    }

    if (objetoReceitaDespesa is ReceitaModel) {
      var receita = objetoReceitaDespesa;

      parcelaUpdate = objetoReceitaDespesa.parcelaModel
          .where((x) =>
              x.parcelaIdGlobal == receita.recIdGlobal &&
              x.parcelaData == receita.recData)
          .single;

      parcelaUpdate.parcelaValor =
          util.converteStringToDouble(objetoReceitaDespesa.recValor).toString();
      parcelaUpdate.parcelaStatusPag = objetoReceitaDespesa.recStatusPag;
    }

    return parcelaUpdate;
  }
}
