import 'package:emanuellemepoupe/pages/cadastro_despesa_receita.dart';
import 'package:flutter/material.dart';
import 'package:emanuellemepoupe/constants/constants_color.dart';
import 'package:emanuellemepoupe/pages/cadastroReceita.dart';
import 'package:emanuellemepoupe/widgets/categoryCard.dart';
import 'cadastroReceita.dart';

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
      //appBar: appBar,
      body: Stack(
        children: [
          Container(
            // Here the height of the container is 45% of our total height
            height: size.height * .35,
            decoration: BoxDecoration(
              color: kTextColor,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              image: DecorationImage(
                alignment: Alignment.center,
                image: AssetImage("images/emanuelle.png"),
              ),
            ),
          ),
          SafeArea(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
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
                              crossAxisCount: 2,
                              childAspectRatio: .70,
                              crossAxisSpacing: 40,
                              mainAxisSpacing: 20,
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
                                    title: "Desing sobrancelhas",
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
