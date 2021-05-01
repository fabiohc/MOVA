import 'dart:io';

import 'package:emanuellemepoupe/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:emanuellemepoupe/pages/rotas.dart';
import 'package:emanuellemepoupe/widgets/categoryCard.dart';
import 'package:flutter_svg/svg.dart';
import 'package:emanuellemepoupe/pages/login_usuario.dart';
import '../constants/constants_color.dart';

class MenuInicio extends StatefulWidget {
  @override
  _MenuInicioState createState() => _MenuInicioState();
}

class _MenuInicioState extends State<MenuInicio> {
  final logincontroller = LoginController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor:kTextColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0.0,
        brightness: Brightness.dark,
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: opcoaMenu,
            itemBuilder: (BuildContext context) {
              return {'Sair'}.map((String opacao) {
                return PopupMenuItem<String>(
                  value: opacao,
                  child: Text(opacao),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            height: size.height * .35,
            decoration: BoxDecoration(
              color:Color(0xFF23689b) ,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
          Align(
            alignment: Alignment(0.0, -0.6),
            child: SvgPicture.asset("assets/icons/mova.svg",
                color: Colors.white, height: 40, width: 40),
          ),
          SafeArea(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: size.height * 0.1),
                        ),
                        Expanded(
                            child: Container(
                          child: GridView.count(
                              crossAxisCount: 3,
                              childAspectRatio: .80,
                              crossAxisSpacing: 15,
                              mainAxisSpacing: 30,
                              children: <Widget>[
                                CategoryCard(
                                  title: "Receber",
                                  svgSrc: "Receber.svg",
                                  press: () {
                                    Navigator.of(context).pushNamed(
                                        RotasNavegacao.MENU_RECEITAS);
                                  },
                                ),
                                CategoryCard(
                                  title: "Pagar",
                                  svgSrc: "Pagar.svg",
                                  press: () {
                                    Navigator.of(context).pushNamed(
                                        RotasNavegacao.MENU_DESPESAS);
                                  },
                                ),
                                CategoryCard(
                                  title: "Novo Cliente",
                                  svgSrc: "New_User.svg",
                                  press: () {
                                    Navigator.of(context).pushNamed(
                                        RotasNavegacao.LISTA_PESSOAS);
                                  },
                                ),
                                CategoryCard(
                                  title: "Carteira",
                                  svgSrc: "Carteira.svg",
                                  press: () {
                                    Navigator.of(context)
                                        .pushNamed(RotasNavegacao.CARTEIRA);
                                  },
                                ),
                                CategoryCard(
                                    title: "Agenda",
                                    press: () {
                                      Navigator.of(context)
                                          .pushNamed(RotasNavegacao.AGENDA);
                                    },
                                    svgSrc: "Calendario.svg"),
                                CategoryCard(
                                  title: "Configurar",
                                  press: () {
                                    Navigator.of(context)
                                        .pushNamed(RotasNavegacao.CARTEIRA);
                                  },
                                  svgSrc: "Settings.svg",
                                ),
                              ]),
                        ))
                      ])))
        ],
      ),
    );
  }

  void opcoaMenu(String value) {
    switch (value) {
      case 'Sair':
        logincontroller.deslogarUsuario();
        logincontroller.salvePreferencias(false);
        print("false");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );

        break;
      case 'Configurações':
        break;
    }
  }
}
