import 'package:mobx/mobx.dart';
part 'usuario_model.g.dart';

class UsuarioModel = _UsuarioModelBase with _$UsuarioModel;

abstract class _UsuarioModelBase with Store {
 @observable
  int id;
  @action
  alteraId(int value) => id = value;

  @observable
  String nome;
  @action
  alteraNome(String value) => nome = value;

  @observable
  String email;
  @action
  alteraEmail(String value) => email = value;

  @observable
  String senha;
  @action
  alteraSenha(String value) => senha = value;

  _UsuarioModelBase();

  // ignore: unused_element
  _UsuarioModelBase.fromMap(Map map) {
    nome = map["nome"];
    email = map["email"];
    senha = map["senha"];
  }

  Map toMap() {
    Map<String, dynamic> map = {"nome": nome, "email": email, "senha": senha};

    return map;
  }

  @override
  String toString() {
    return " Usuario[ "
        "nome: $nome,"
        "email: $email,"
        "senha: $senha"
        "]";
  }
}
