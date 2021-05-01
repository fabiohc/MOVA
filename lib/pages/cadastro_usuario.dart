import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:emanuellemepoupe/controller/cadastro_controller.dart';
import 'package:emanuellemepoupe/pages/rotas.dart';
import 'package:emanuellemepoupe/controller/login_controller.dart';

import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class Cadastro extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final logincontroller = LoginController();

  Widget build(BuildContext context) {
    final cadastroController = CadastroController();
    var size = MediaQuery.of(context).size;
    _textField({String hintText, onChanged, String Function() errorText}) {
      return TextField(
        keyboardType: TextInputType.text,
        style: TextStyle(fontSize: 20), //Tamanho dafonte
        onChanged: onChanged,
        decoration: InputDecoration(
            errorText: errorText == null ? null : errorText(),
            contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
            filled: true,
            fillColor: Colors.white,
            hintText: hintText,
            border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(12))), //Define borda circular
      );
    }

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.white),
          elevation: 0.0,
          brightness: Brightness.dark,
        ),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.centerLeft,
            colors: [Color(0xff1F2B44), Color(0xff3A4A64)],
          )),
          padding: EdgeInsets.only(top: 0, left: 16, right: 16),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 80),
                    child: Align(
                      alignment: Alignment.center,
                      child: SvgPicture.asset("assets/icons/mova.svg",
                          color: Colors.white, height: 40, width: 40),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 32),
                    child: Text(
                      "Crie sua conta",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 40, color: Color(0xff0BBFD6)),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Padding(
                        padding: EdgeInsets.only(
                            bottom: 8), //Define espaço entre itens
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          onChanged: (value) {
                            cadastroController.usuarioModel.alteraNome(value);
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (String value) {
                            return value == null ||
                                    value.isEmpty ||
                                    value.length <= 1
                                ? 'Informe o nome!'
                                : null;
                          },
                          autofocus: true, //Define foco inicial no e-mail
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(fontSize: 20), //Tamanho dafonte
                          decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(32, 16, 32, 16),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "Nome",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      12))), //Define borda circular
                        )),
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          bottom: 8), //Define espaço entre itens
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        onChanged: (value) {
                          cadastroController.usuarioModel.alteraEmail(value);
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (String value) {
                          return value == null ||
                                  value.isEmpty ||
                                  !value.contains('@') ||
                                  !value.contains('.') ||
                                  value.length <= 3
                              ? 'Insira uma e-mail valido!'
                              : null;
                        },
                        autofocus: true, //Define foco inicial no e-mail
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(fontSize: 20), //Tamanho dafonte
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "E-mail",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    12))), //Define borda circular
                      )),
                  Padding(
                      padding: EdgeInsets.only(
                          bottom: 8), //Define espaço entre itens
                      child: TextFormField(
                        onChanged: (value) {
                          cadastroController.usuarioModel.alteraSenha(value);
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (String value) {
                          return value.length <= 5
                              ? "Imforme a senha com mais 5 caracteres!"
                              : null;
                        },
                        autofocus: true, //Define foco inicial no e-mail
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        style: TextStyle(fontSize: 20), //Tamanho dafonte
                        decoration: InputDecoration(
                            // errorText: logincontroller.valideEmail(),
                            contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "Senha",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    12))), //Define borda circular
                      )),
                  Padding(
                      padding: EdgeInsets.only(top: 16, bottom: 10),
                      child: Observer(
                        builder: (_) => RaisedButton(
                            child: Text(
                              "Cadastrar",
                              style: TextStyle(color: Colors.white),
                            ),
                            color: Color(0xff0BBFD6),
                            padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                            shape: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)),
                            onPressed: cadastroController.isValid
                                ? () async {
                                    var user = await cadastroController
                                        .cadastreUsuario();
                                    if (user == true) {
                                      logincontroller.salvePreferencias(user);
                                    print("Preferencias " + user.toString());
                                      Navigator.of(context)
                                          .popAndPushNamed(RotasNavegacao.HOME);
                                    }
                                  }
                                : null),
                      )),
                ],
              ),
            ),
          ),
        ));
  }
}
