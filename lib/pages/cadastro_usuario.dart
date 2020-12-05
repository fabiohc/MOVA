import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:emanuellemepoupe/controller/cadastro_controller.dart';

class Cadastro extends StatelessWidget {
  Widget build(BuildContext context) {
    print("teste de tela");
    final cadastroController = CadastroController();

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
      appBar: AppBar(
        title: Text("Cadastro"),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.centerLeft,
          colors: [Color(0xff1F2B44), Color(0xff3A4A64)],
        )),
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 32),
                  child: Text(
                    "Crie sua conta",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 40, color: Color(0xff0BBFD6)),
                  ),
                  /*  child: Image.asset(
                        "images/logo.png",
                        width: 200,
                        height: 150,
                      ),*/
                ),
                Padding(
                    padding:
                        EdgeInsets.only(bottom: 8), //Define espaço entre itens
                    child: Observer(
                        builder: (_) => _textField(
                              hintText: "Nome",
                              onChanged:
                                  cadastroController.usuarioModel.alteraNome,
                              errorText: cadastroController.valideNome,
                            ))),
                Padding(
                    padding:
                        EdgeInsets.only(bottom: 8), //Define espaço entre itens
                    child: Observer(
                        builder: (_) => _textField(
                              hintText: "E-mail",
                              onChanged:
                                  cadastroController.usuarioModel.alteraEmail,
                              errorText: cadastroController.valideEmail,
                            ))),
                Padding(
                    padding:
                        EdgeInsets.only(bottom: 8), //Define espaço entre itens
                    child: Observer(
                        builder: (_) => _textField(
                              hintText: "Senha",
                              onChanged:
                                  cadastroController.usuarioModel.alteraSenha,
                              errorText: cadastroController.valideSenha,
                            ))),
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
                              ? () {
                                  cadastroController.cadastreUsuario();
                                }
                              : null),
                      //onPressed:(){ cadastroController.botao? _nextStep: null;})
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
