import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:emanuellemepoupe/pages/cadastro_usuario.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  child: Image.asset(
                    "images/logo.png",
                    width: 200,
                    height: 150,
                  ),
                ),
                Padding(
                    padding:
                        EdgeInsets.only(bottom: 8), //Define espaço entre itens
                    child: TextField(
                      /*  onChanged: (value) {
                        _bloc.input.add(value);
                      },*/
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
                TextField(
                  onChanged: (value) {},
                  keyboardType: TextInputType.text,
                  style: TextStyle(fontSize: 20), //Tamanho dafonte
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Senha",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              12))), //Define borda circular
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 10),
                  child: RaisedButton(
                      child: Text(
                        "Entrar",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Color(0xff0BBFD6),
                      padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      onPressed: () {}),
                ),
                Center(
                  child: GestureDetector(
                      child: Text(
                        "Não tem conta? Cadastre-se.",
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Cadastro()));
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
