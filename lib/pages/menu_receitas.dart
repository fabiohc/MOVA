import 'package:emanuellemepoupe/pages/cadastro_despesa_receita.dart';
import 'package:flutter/material.dart';
import 'package:emanuellemepoupe/widgets/categoryCard.dart';
import 'package:emanuellemepoupe/widgets/navegacao.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:emanuellemepoupe/pages/rotas.dart';

class MenuReceitas extends StatefulWidget {
  @override
  _MenuReceitasState createState() => _MenuReceitasState();
}

class _MenuReceitasState extends State<MenuReceitas> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    Widget getImage(String path) {
      return Image.asset("images/$path");
    }

    // ignore: unused_element
    Widget buildMenu(String pathImgRight, String descRight, String pathImgLeft,
        String descLeft) {
      return Padding(
        padding: EdgeInsets.only(top: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CadastroDespesaReceita(
                              acao: 'receber',
                              descricaoServico: descRight,
                            )));
              },
              child: getImage(pathImgRight),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CadastroDespesaReceita(
                              acao: 'receber',
                              descricaoServico: descRight,
                            )));
              },
              child: getImage(pathImgLeft),
            )
          ],
        ),
      );
    }

    return Scaffold(
      
      body: Stack(
        children: [
          Container(
            height: size.height * .35,
            decoration: BoxDecoration(
              color: Color(0xFFF4a47a3),
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
          BottomNavBar(
            icon: SvgPicture.asset(
              "assets/icons/Voltar ICon.svg",
              color: Colors.white,
            ),
            margin: 10,
            alignment: Alignment.bottomLeft,
            // color: Colors.white.withOpacity(2),
            press: () {
              Navigator.of(context).popAndPushNamed(RotasNavegacao.HOME);
            },
            descricao: "MENU RECEITAS",
          ),
          SafeArea(
              child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 30, vertical: size.height * 0.1),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 65),
                        ),
                        Expanded(
                            child: Container(
                          child: GridView.count(
                              crossAxisCount: 3,
                              childAspectRatio: .78,
                              crossAxisSpacing: 15,
                              mainAxisSpacing: 30,
                              children: <Widget>[
                                CategoryCard(
                                  title: "Cílios",
                                  svgSrc: "cilios.png",
                                  press: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CadastroDespesaReceita(
                                                  acao: 'receber',
                                                  descricaoServico: "Cílios"),
                                        ));
                                  },
                                ),
                                CategoryCard(
                                  title: "Micro fio a fio",
                                  svgSrc: "sobrancelhas.png",
                                  press: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CadastroDespesaReceita(
                                                  acao: 'receber',
                                                  descricaoServico:
                                                      "Micro fio a fio"),
                                        ));
                                  },
                                ),
                                CategoryCard(
                                    title: "Limpeza de pele",
                                    press: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                CadastroDespesaReceita(
                                                    acao: 'receber',
                                                    descricaoServico:
                                                        "Limpeza de pele"),
                                          ));
                                    },
                                    svgSrc: "limpezapele.png"),
                                CategoryCard(
                                    title: "Sobrancelhas",
                                    press: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                CadastroDespesaReceita(
                                                    acao: 'receber',
                                                    descricaoServico:
                                                        "Desing sobrancelhas"),
                                          ));
                                    },
                                    svgSrc: "desing.png"),
                                CategoryCard(
                                    title: "BBGlow",
                                    press: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                CadastroDespesaReceita(
                                                    acao: 'receber',
                                                    descricaoServico: "BBGlow"),
                                          ));
                                    },
                                    svgSrc: "bbglow.png"),
                                CategoryCard(
                                    title: "Peeling",
                                    press: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                CadastroDespesaReceita(
                                                    acao: 'receber',
                                                    descricaoServico:
                                                        "Peeling"),
                                          ));
                                    },
                                    svgSrc: "bblips.png"),
                              ]),
                        ))
                      ])))
        ],
      ),
    );
  }
}
