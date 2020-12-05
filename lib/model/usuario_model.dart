import 'package:mobx/mobx.dart';
part 'usuario_model.g.dart';

class UsuarioModel = _UsuarioModelBase with _$UsuarioModel;

abstract class _UsuarioModelBase with Store {
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
}
