import 'package:emanuellemepoupe/controller/util.dart';
import 'package:intl/intl.dart';
//import 'package:mePoupe/controller/util.dart';
import 'package:mobx/mobx.dart';

part 'parcela_model.g.dart';

class ParcelaModel = _ParcelaModelBase with _$ParcelaModel;

abstract class _ParcelaModelBase with Store {
  @observable
  int parcelaId;
  @action
  alteraParcelaId(int value) => parcelaId = value;

  @observable
  String parcelaIdGlobal;
  @action
  alteraParcelaIdGlobal(String value) => parcelaIdGlobal = value;

  @observable
  int parcelaNumero;
  @action
  alteraParcelaNumero(int value) => parcelaNumero = value;

   @observable
  int parcelaQuatParc = 0;
  @action
  alteraQuantParcelas(int value) => parcelaQuatParc = value;

  @observable
  String parcelaValor;
  @action
  alteraParcelaValor(String value) => parcelaValor = value;

  @observable
  String parcelaData;
  @action
  alteraParcelaData(String value) => parcelaData = value;

  @observable
  bool parcelaStatusPag;
  @action
  alteraPacelaStatus(bool value) => parcelaStatusPag = value;

  @observable
  bool parcelaIntegrado = false;
  @action
  alteraParcelaIntegrado(bool value) => parcelaIntegrado = value;

  _ParcelaModelBase();
  Util util;

  // ignore: unused_element
  _ParcelaModelBase.fromMap(Map map, bool eHInsertFarebase) {
    parcelaId = map["parcelaId"];
    parcelaIdGlobal = map["parcelaIdGlobal"];
    parcelaNumero = map["parcelaNumero"];
    parcelaQuatParc = map["parcelaQuatParc"];
    parcelaData = map["parcelaData"];
    if (eHInsertFarebase) {
      parcelaValor = (map["parcelaValor"]);
    } else {
      parcelaValor =
          formatMoedaDoubleParaString(map["parcelaValor"].toString());
    }
    if (eHInsertFarebase) {
      parcelaIntegrado = map["parcelaIntegrado"];
      parcelaStatusPag = map["parcelaStatusPag"];
    } else {
      parcelaIntegrado = map["parcelaIntegrado"] == 0 ? false : true;
      parcelaStatusPag = map["parcelaStatusPag"] == 0 ? false : true;
    }
  }

  Map toMap() {
    Map<String, dynamic> map = {
      "parcelaId": parcelaId,
      "parcelaIdGlobal": parcelaIdGlobal,
      "parcelaNumero": parcelaNumero,
      "parcelaQuatParc" : parcelaQuatParc,
      "parcelaValor": parcelaValor,
      "parcelaData": parcelaData,
      "parcelaStatusPag": parcelaStatusPag,
      "parcelaIntegrado": parcelaIntegrado
    };

    if (parcelaId != null) {
      map["parcelaId"] = parcelaId;
    }
    return map;
  }

  @override
  String toString() {
    return "Despesa[ parcelaId: $parcelaId,"
        "parcelaIdGlobal: $parcelaIdGlobal,"
        "parcelaNumero: $parcelaNumero,"
        "parcelaQuatParc: $parcelaQuatParc,"
        "parcelaValor: $parcelaValor,"
        "parcelaData: $parcelaData,"
        "parcelaStatusPag: $parcelaStatusPag,"
        "parcelaIntegrado: $parcelaIntegrado,"
        "]";
  }

  String formatMoedaDoubleParaString(String moedaBD) {
    double valorDouble = double.parse(moedaBD);
    final formatador = NumberFormat("#,##0.00", "pt_BR");
    final valorString = formatador.format(valorDouble).toString();
    return valorString;
  }
}
