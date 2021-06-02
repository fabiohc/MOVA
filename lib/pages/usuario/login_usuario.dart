import 'package:emanuellemepoupe/controller/login_controller.dart';
import 'package:emanuellemepoupe/helperBD/create_helperdb.dart';
import 'package:emanuellemepoupe/pages/rotas.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:emanuellemepoupe/pages/usuario/cadastro_usuario.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flushbar/flushbar.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

bool carregamentoCompleto = false;
dynamic login;

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userLogado = logincontroller.verifiqueUsuarioLogado();
      if (userLogado == true) {
        carregamentoCompleto = false;
        Navigator.of(context).popAndPushNamed(RotasNavegacao.HOME);
      }
    });
    super.initState();
  }

  final logincontroller = LoginController();
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
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 80),
                  child: Align(
                    alignment: Alignment.center,
                    child: SvgPicture.asset("assets/icons/mova.svg",
                        color: Colors.white, height: 40, width: 40),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 32),
                      child: Text(
                        "Login",
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(fontSize: 40, color: Color(0xff0BBFD6)),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            bottom: 8), //Define espaço entre itens
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,

                          onChanged: (value) {
                            logincontroller.usuarioModel.alteraEmail(value);
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
                          autofocus: false, //Define foco inicial no e-mail
                          style: TextStyle(fontSize: 20), //Tamanho dafonte
                          decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(32, 16, 32, 16),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "E-mail",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      12))), //Define borda circular
                        )),
                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      onChanged: (value) {
                        logincontroller.usuarioModel.alteraSenha(value);
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (String value) {
                        return value == null ||
                                value.isEmpty ||
                                value.length <= 5
                            ? "Imforme a senha com mais 5 caracteres!"
                            : null;
                      },
                      style: TextStyle(fontSize: 20),
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
                      child: Observer(builder: (_) {
                        return RaisedButton(
                            child: carregamentoCompleto
                                ? CircularProgressIndicator()
                                : Text(
                                    "Entrar",
                                    style: TextStyle(color: Colors.white),
                                  ),
                            color: Color(0xff0BBFD6),
                            padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                            shape: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)),
                            onPressed: logincontroller.isValid
                                ? () async {
                                    setState(() {
                                      carregamentoCompleto = true;
                                    });
                                    login =
                                        await logincontroller.loginUsuario();
                                    if (login == true) {
                                      carregamentoCompleto = false;
                                      logincontroller.salvePreferencias(login);
                                      CreateHelper().inicializaDadosFirebase();

                                      Navigator.of(context)
                                          .popAndPushNamed(RotasNavegacao.HOME);
                                    } else {
                                      setState(() {
                                        carregamentoCompleto = false;
                                        flushbarAlerta();
                                      });
                                    }
                                  }
                                : null);
                      }),
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
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Flushbar flushbarAlerta() {
    return Flushbar<bool>(
      title: "Algo deu errado!",
      message:
          "Verifique se usuário e senha estão corretos \n ou se este usuário está cadastrado.",
      margin: EdgeInsets.all(10),
      borderRadius: 8,
      animationDuration: Duration(seconds: 1),
      duration: Duration(seconds: 3),
      isDismissible: true,
      icon: Icon(
        Icons.info_outline,
        color: Colors.white,
      ),
      mainButton: Row(
        children: [
          Text(
            "",
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
        ],
      ),
      backgroundGradient:
          LinearGradient(colors: [Colors.red, Colors.redAccent]),
    )..show(context);
  }
}
