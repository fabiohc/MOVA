import 'package:emanuellemepoupe/model/usuario_model.dart';
import 'package:emanuellemepoupe/repository/cadastro_repository.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'cadastro_controller.g.dart';

class CadastroController = _CadastroControllerBase with _$CadastroController;

abstract class _CadastroControllerBase with Store {
  var servico = CadastreUser();

  @observable
  var usuarioModel = UsuarioModel();

  var nome = ValueNotifier<String>('');
  var email = ValueNotifier<String>('');
  var senha = ValueNotifier<String>('');

  mudanome(String value) {
    nome.value = value;
  }

  mudaemail(String value) {
    email.value = value;
  }

  mudasenha(String value) {
    senha.value = value;
  }

  @computed
  bool get isValid {
    return valideEmail() == null &&
        valideNome() == null &&
        valideSenha() == null;
  }

  String valideNome() {
    if (usuarioModel.nome == null ||
        usuarioModel.nome.isEmpty ||
        usuarioModel.nome.length <= 1) return "Invalido";

    return null;
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

  dynamic cadastreUsuario() {
    usuarioModel.nome;
    usuarioModel.email;
    usuarioModel.senha;

    var _retorno = servico.casdastreUsuario(usuarioModel);
    salvePreferencias(_retorno);
    return _retorno;
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

    //  removaPreferencias() {}

/*
Envia email
  Firebase.Auth.FirebaseUser user = auth.CurrentUser;
if (user != null) {
  user.SendEmailVerificationAsync().ContinueWith(task => {
    if (task.IsCanceled) {
      Debug.LogError("SendEmailVerificationAsync was canceled.");
      return;
    }
    if (task.IsFaulted) {
      Debug.LogError("SendEmailVerificationAsync encountered an error: " + task.Exception);
      return;
    }

    Debug.Log("Email sent successfully.");
  });
}*/

    }
  }
}
