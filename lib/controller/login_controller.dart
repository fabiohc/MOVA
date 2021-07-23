import 'package:emanuellemepoupe/model/usuario_model.dart';
import 'package:emanuellemepoupe/repository/login.repository.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'login_controller.g.dart';

class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  final servico = LoginUser();
  final usuarioModel = UsuarioModel();

  @computed
  bool get isValid {
    return valideEmail() == null && valideSenha() == null;
  }

  String valideEmail() {
    if (usuarioModel.email == null ||
        usuarioModel.email.isEmpty ||
        !usuarioModel.email.contains("@") ||
        !usuarioModel.email.contains('.') ||
        usuarioModel.email.length <= 3) {
      return "Invalido";
    }
    return null;
  }

  String valideSenha() {
    if (usuarioModel.senha == null ||
        usuarioModel.senha.isEmpty ||
        usuarioModel.senha.length <= 5) {
      return "Invalido";
    }
    return null;
  }

  verifiqueUsuarioLogado() {
    usuarioModel.nome;
    usuarioModel.email;
    usuarioModel.senha;
    var _retorno = servico.consulteUsuarioLogado();

    salvePreferencias(_retorno);
    return _retorno;
  }

  loginUsuario() async {
    try {
      return servico.login(usuarioModel);
    } catch (ex) {
      print(ex.toString());
    }
  }

  deslogarUsuario() {
    servico.deslogarUsuario();
  }

  getPreferencias() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get("login");
  }

  salvePreferencias(dynamic _retorno) async {
    if (_retorno is bool) {
      if (_retorno == true) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool("login", _retorno);
      } else {
        if (_retorno == false) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setBool("login", _retorno);
        }
      }
    }
  }

  removaPreferencias() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("login");
  }
}
