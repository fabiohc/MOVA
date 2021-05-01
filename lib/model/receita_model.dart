import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:emanuellemepoupe/controller/util.dart';
import 'package:emanuellemepoupe/model/parcela_model.dart';
import 'package:emanuellemepoupe/model/pessoa_model.dart';
part 'receita_model.g.dart';

class ReceitaModel = _ReceitaModelBase with _$ReceitaModel;

abstract class _ReceitaModelBase with Store {
  @observable
  int recId;
  @action
  alteraRecId(int value) => recId = value;

  @observable
  String recIdGlobal;
  @action
  alteraRecIdFGlobal(String value) => recIdGlobal = value;

  @observable
  String recServico;
  @action
  alteraRecServico(String value) => recServico = value;

  @observable
  String recValor;
  @action
  alteraRecValor(String value) => recValor = value;

  @observable
  String recData;
  @action
  alteraRecData(String value) => recData = value;

  @observable
  String recFormaPagamento;
  @action
  alteraRecFormaPagamento(String value) => recFormaPagamento = value;

  @observable
  String recTipoCartao;
  @action
  alteraRecTipoCartao(String value) => recTipoCartao = value;

  @observable
  String recObservacao;
  @action
  alteraRecObservacao(String value) => recObservacao = value;

  @observable
  int recNumeroParcelas = 0;
  @action
  alteraRecNumeroParcelas(int value) => recNumeroParcelas = value;

  @observable
  bool recStatusPag = false;
  @action
  alteraReceitStatusPag(bool value) => recStatusPag = value;

  @observable
  bool recIntegrado = false;
  @action
  alteraRecIntegrado(bool value) => recIntegrado = value;

  @observable
  List<ParcelaModel> parcelaModel;
  @action
  alteraRecListaParcelas(List<ParcelaModel> value) => parcelaModel = value;

  @observable
  PessoaModel pessoaModel;
  @action
  alteraRecPessoaModel(PessoaModel value) => pessoaModel = value;

  @observable
  List parcelaModelSnapShot;
  @action
  alteraRecListaParcelasSnapShot(List value) => parcelaModelSnapShot = value;

  @observable
  String recPessoaIdVinculado;
  @action
  alteraRecPessoaIdVinculado(String value) => recPessoaIdVinculado = value;

  _ReceitaModelBase();
  Util util = Util();

  // ignore: unused_element
  _ReceitaModelBase.fromMap(Map map, bool eHInsertFarebase) {
    recIdGlobal = map["recIdGlobal"];
    recServico = map["recServico"];
    recValor = formatMoedaDoubleParaString(map["recValor"].toString());
    recData = map["recData"];
    recFormaPagamento = map["recFormaPagamento"];
    recTipoCartao = map["recTipoCartao"];
    recNumeroParcelas = map["recNumeroParcelas"];
    recObservacao = map["recObservacao"];
    if (eHInsertFarebase) {
      recStatusPag = map["recStatusPag"];
      recIntegrado = map["recIntegrado"];
    } else {
      recStatusPag = map["recStatusPag"] == 0 ? false : true;
      recIntegrado = map["recIntegrado"] == 0 ? false : true;
    }
    parcelaModelSnapShot = map["parcelaModel"];
    pessoaModel = map["pessoaModel"];
   recPessoaIdVinculado = map["recPessoaIdVinculado"];
  }

  String formatMoedaDoubleParaString(String moedaBD) {
    double valorDouble = double.parse(moedaBD);
    var formatador = NumberFormat("#,##0.00", "pt_BR");
    var a = formatador.format(valorDouble).toString();
    return a;
  }

  Map toMap() {
    Map<String, dynamic> map = {
      "recIdGlobal": recIdGlobal,
      "recServico": recServico,
      "recValor": converteStringToDouble(recValor),
      "recData": recData,
      "recFormaPagamento": recFormaPagamento,
      "recTipoCartao": recTipoCartao,
      "recObservacao": recObservacao,
      "recNumeroParcelas": recNumeroParcelas,
      "recStatusPag": recStatusPag,
      "recIntegrado": recIntegrado,
      "recPessoaIdVinculado": recPessoaIdVinculado
    };

    if (recId != null) {
      map["recId"] = recId;
    }
    return map;
  }

  Map toMapFirebase() {
    Map<String, dynamic> map = {
      "recIdGlobal": recIdGlobal,
      "recServico": recServico,
      "recValor": util.converteStringToDouble(recValor),
      "recData": recData,
      "recFormaPagamento": recFormaPagamento,
      "recTipoCartao": recTipoCartao,
      "recNumeroParcelas": recNumeroParcelas,
      "recObservacao": recObservacao,
      "recStatusPag": recStatusPag,
      //"parcelaModel": parcelaModel,
      "recIntegrado": recIntegrado,
      "recPessoaIdVinculado": recPessoaIdVinculado
    };

    if (recId != null) {
      map["recId"] = recId;
    }
    return map;
  }

  @override
  String toString() {
    return "Receita[ recId: $recId,"
        "recIdGlobal: $recIdGlobal,"
        "recServico : $recServico,"
        "recValor: $recValor,"
        "recData: $recData,"
        "recFormaPagamento: $recFormaPagamento,"
        "recTipoCartao: $recTipoCartao,"
        "recNumeroParcelas: $recNumeroParcelas,"
        "recStatusPag: $recStatusPag,"
        "recIntegrado: $recIntegrado,"
        "recPessoaIdVinculado: $recPessoaIdVinculado"
        "]";
  }

  double converteStringToDouble(String valor) {
    valor = valor.replaceAll('.', '').replaceAll(',', '.');
    var c = double.parse(valor);
    return c;
  }
}
