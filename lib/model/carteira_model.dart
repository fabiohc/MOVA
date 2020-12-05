//import 'package:mePoupe/controller/util.dart';
import 'package:mobx/mobx.dart';
part 'carteira_model.g.dart';

class CarteiraModel = _CarteiraModelBase with _$CarteiraModel;

abstract class _CarteiraModelBase with Store {
  @observable
  String data;
  @action
  alteraData(String value) => data = value;

  @observable
  double valor;
  @action
  alteraValor(double value) => valor = value;

  @observable
  int parcela;
  @action
  alteraParcela(int value) => parcela = value;

  @observable
  int parcelaQuatParc = 0;
  @action
  alteraQuantParcelas(int value) => parcelaQuatParc = value;

  @observable
  String tipo;
  @action
  alteraTipo(String value) => tipo = value;

  @observable
  bool status;
  @action
  alteraStatus(bool value) => status = value;

  _CarteiraModelBase();
//var util = Util();

  // ignore: unused_element
  _CarteiraModelBase.fromMap(Map map) {
    data = map["data"];
    valor = double.parse(map["valor"].toString());
    parcela = map["numParcela"];
    parcelaQuatParc = map["parcelaQuatParc"];
    tipo = map["tipo"];
    status = map["status"] == 0 ? false : true;
  }

  Map toMap() {
    Map<String, dynamic> map = {
      "data": data,
      "parcela": parcela,
      "parcelaQuatParc": parcelaQuatParc,
      //  "valor": util.converteStringToDouble(valor.toString()),
      "tipo": tipo,
      "status": status
    };

    if (data != null) {
      map["data"] = data;
    }
    return map;
  }

  @override
  String toString() {
    return "Carteira[ data: $data,"
        "parcela: $parcela,"
        "parcelaQuatParc: $parcelaQuatParc,"
        "valor : $valor,"
        "tipo: $tipo,"
        "status: $status"
        "]";
  }
}
