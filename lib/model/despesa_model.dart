//import 'package:mePoupe/controller/util.dart';
import 'package:emanuellemepoupe/controller/carteira_controller.dart';
import 'package:emanuellemepoupe/model/parcela_model.dart';
import 'package:emanuellemepoupe/model/pessoa_model.dart';
import 'package:mobx/mobx.dart';
part 'despesa_model.g.dart';

class DespesaModel = _DespelaModelBase with _$DespesaModel;

abstract class _DespelaModelBase with Store {
  @observable
  int despId;
  @action
  alteraDespId(int value) => despId = value;

  @observable
  String despIdGlobal;
  @action
  alteraDespIdGlobal(String value) => despIdGlobal = value;

  @observable
  String despServico;
  @action
  alteraDespServico(String value) => despServico = value;

  @observable
  String despValor;
  @action
  alteraDespValor(String value) => despValor = value;

  @observable
  String despData;
  @action
  alteraDespData(String value) => despData = value;

  @observable
  String despFormaPagamento;
  @action
  alteraDespFormaPagamento(String value) => despFormaPagamento = value;

  @observable
  String despTipoCartao;
  @action
  alteraDespTipoCartao(String value) => despTipoCartao = value;

  @observable
  String despObservacao;
  @action
  alteraDespObservacao(String value) => despObservacao = value;

  @observable
  int despNumeroParcelas = 0;
  @action
  alteraDespNumeroParcelas(int value) => despNumeroParcelas = value;

  @observable
  bool despesaStatusPag = false;
  @action
  alteraDespesaStatusPag(bool value) => despesaStatusPag = value;

  @observable
  bool despIntegrado = false;
  @action
  alteraDespIntegrado(bool value) => despIntegrado = value;

  @observable
  List<ParcelaModel> parcelaModel;
  @action
  alteraDespListaParcelas(List<ParcelaModel> value) => parcelaModel = value;

  @observable
  List parcelaModelSnapShot;
  @action
  alteraDespListaParcelasSnapShot(List value) => parcelaModelSnapShot = value;

  @observable
  PessoaModel pessoaModel;
  @action
  alteraDespPessoaModel(PessoaModel value) => pessoaModel = value;

  @observable
  String despPessoaIdVinculado;
  @action
  alteradespPessoaIdVinculado(String value) => despPessoaIdVinculado = value;

  _DespelaModelBase();
  // var util = Util();

  // ignore: unused_element
  _DespelaModelBase.fromMap(Map map, bool eHInsertFarebase) {
    despIdGlobal = map["despIdGlobal"];
    despServico = map["despServico"];
    despValor = util.formatMoedaDoubleParaString(map["despValor"].toString());
    despData = map["despData"];
    despFormaPagamento = map["despFormaPagamento"];
    despTipoCartao = map["despTipoCartao"];
    despNumeroParcelas = map["despNumeroParcelas"];
    despObservacao = map["despObservacao"];
    if (eHInsertFarebase) {
      despesaStatusPag = map["despesaStatusPag"];
      despIntegrado = map["despIntegrado"];
    } else {
      despesaStatusPag = map["despesaStatusPag"] == 0 ? false : true;
      despIntegrado = map["despIntegrado"] == 0 ? false : true;
    }
    parcelaModelSnapShot = map["parcelaModel"];
    pessoaModel = map["pessoaModel"];
    despPessoaIdVinculado = map["despPessoaIdVinculado"];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      "despIdGlobal": despIdGlobal,
      "despServico": despServico,
      "despValor": util.converteStringToDouble(despValor.toString()),
      "despData": despData,
      "despFormaPagamento": despFormaPagamento,
      "despTipoCartao": despTipoCartao,
      "despNumeroParcelas": despNumeroParcelas,
      "despObservacao": despObservacao,
      "despesaStatusPag": despesaStatusPag,
      "despIntegrado": despIntegrado,
      "despPessoaIdVinculado": despPessoaIdVinculado
    };

    if (despId != null) {
      map["despId"] = despId;
    }
    return map;
  }

  Map toMapFirebase() {
    Map<String, dynamic> map = {
      "despIdGlobal": despIdGlobal,
      "despServico": despServico,
      "despValor": util.converteStringToDouble(despValor),
      "despData": despData,
      "despFormaPagamento": despFormaPagamento,
      "despTipoCartao": despTipoCartao,
      "despNumeroParcelas": despNumeroParcelas,
      "despObservacao": despObservacao,
      //"parcelaModel": parcelaModel,
      //"pessoaModel": pessoaModel,
      "despesaStatusPag": despesaStatusPag,
      "despIntegrado": despIntegrado,
      "despPessoaIdVinculado": despPessoaIdVinculado
    };

    if (despId != null) {
      map["despId"] = despId;
    }
    return map;
  }

  @override
  String toString() {
    return "Despesa[ despId: $despId,"
        "despIdGlobal: $despIdGlobal,"
        "despServico : $despServico,"
        "despValor: $despValor,"
        "despData: $despData,"
        "despFormaPagamento: $despFormaPagamento,"
        "despTipoCartao: $despTipoCartao,"
        "despNumeroParcelas: $despNumeroParcelas,"
        "despObservacao: $despObservacao,"
        "despesaStatusPag: $despesaStatusPag"
        "despIntegrado: $despIntegrado"
        "despPessoaIdVinculado: $despPessoaIdVinculado"
        "]";
  }
}
