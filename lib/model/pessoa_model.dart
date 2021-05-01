import 'package:mobx/mobx.dart';
part 'pessoa_model.g.dart';

class PessoaModel = _PessoaModelBase with _$PessoaModel;

abstract class _PessoaModelBase with Store {
  @observable
  int pessoaId;
  @action
  alteraPessoaId(int value) => pessoaId = value;

  @observable
  String pessoaIdGlobal;
  @action
  alteraPessoaIdGlobal(String value) => pessoaIdGlobal = value;

  @observable
  String pessoaNome;
  @action
  alteraNome(String value) => pessoaNome = value;

  @observable
  String pessoaDataNascimento;
  @action
  alteraDataNascimeto(String value) => pessoaDataNascimento = value;

  @observable
  String pessoaEmail;
  @action
  alteraEmail(String value) => pessoaEmail = value;

  @observable
  String pessoaTelefone;
  @action
  alterapessoaTelefone(String value) => pessoaTelefone = value;

  @observable
  String pessoaCpf;
  @action
  alteraCPF(String value) => pessoaCpf = value;

  @observable
  String pessoafotourl;
  @action
  alterapessoafotourl(String value) => pessoafotourl = value;

   @observable
  PessoaModel pessoaModel;
  @action
  alteraPessoaModel(PessoaModel value) => pessoaModel = value;

  @observable
  List pessoaModelSnapShot;
  @action
  alteraDespListaParcelasSnapShot(List value) => pessoaModelSnapShot = value;

  _PessoaModelBase();

  // ignore: unused_element
  _PessoaModelBase.fromMap(Map map, bool eHInsertFarebase) {
    pessoaId = map["pessoaId"];
    pessoaIdGlobal = map["pessoaIdGlobal"];
    pessoaNome = map["pessoaNome"];
    pessoaDataNascimento = map["pessoaDataNascimento"];
    pessoaEmail = map["pessoaEmail"];
    pessoaTelefone = map["pessoaTelefone"];
    pessoaCpf = map["pessoaCpf"];
    pessoafotourl = map["pessoafotourl"];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      "pessoaId": pessoaId,
      "pessoaIdGlobal": pessoaIdGlobal,
      "pessoaNome": pessoaNome,
      "pessoaDataNascimento": pessoaDataNascimento,
      "pessoaEmail": pessoaEmail,
      "pessoaTelefone": pessoaTelefone,
      "pessoaCpf": pessoaCpf,
      "pessoafotourl": pessoafotourl
    };

    if (pessoaId != null) {
      map["pessoaId"] = pessoaId;
    }
    return map;
  }

  Map toMapFirebase() {
    Map<String, dynamic> map = {
      "pessoaIdGlobal": pessoaIdGlobal,
      "pessoaNome": pessoaNome,
      "pessoaDataNascimento": pessoaDataNascimento,
      "pessoaEmail": pessoaEmail,
      "pessoaTelefone": pessoaTelefone,
      "pessoaCpf": pessoaCpf,
      "pessoafotourl": pessoafotourl
    };

    if (pessoaId != null) {
      map["pessoaId"] = pessoaId;
    }
    return map;
  }

  @override
  String toString() {
    return "Receita[ pessoaId: $pessoaId,"
        "pessoaIdGlobal: $pessoaIdGlobal,"
        "pessoaNome : $pessoaNome,"
        "pessoaDataNascimento: $pessoaDataNascimento,"
        "pessoaEmail: $pessoaEmail,"
        "pessoaTelefone: $pessoaTelefone"
        "pessoaCpf: $pessoaCpf"
        "pessoafotourl: $pessoafotourl"
        "]";
  }
}
