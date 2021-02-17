import 'package:flutter/material.dart';
import 'package:emanuellemepoupe/pages/rotas.dart';
import 'package:emanuellemepoupe/widgets/categoryCard.dart';
import '../constants/constants_color.dart';

class MenuInicio extends StatefulWidget {
  @override
  _MenuInicioState createState() => _MenuInicioState();
}

class _MenuInicioState extends State<MenuInicio> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
                              childAspectRatio: .80,
                              crossAxisSpacing: 40,
                              mainAxisSpacing: 20,
                              children: <Widget>[
                                CategoryCard(
                                  title: "Receber",
                                  svgSrc: "receita.png",
                                  press: () {
                                    Navigator.of(context).pushNamed(
                                        RotasNavegacao.MENU_RECEITAS);
                                  },
                                ),
                                CategoryCard(
                                  title: "Pagar",
                                  svgSrc: "despesas.png",
                                  press: () {
                                    Navigator.of(context).pushNamed(
                                        RotasNavegacao.MENU_DESPESAS);
                                  },
                                ),
                                CategoryCard(
                                    title: "Agenda",
                                   press: () {
                                    Navigator.of(context).pushNamed(
                                        RotasNavegacao.LISTA_PESSOAS);
                                  },
                                    svgSrc: "agenda.png"),
                                CategoryCard(
                                    title: "Relatórios",
                                    press: () {
                                      Navigator.of(context)
                                          .pushNamed(RotasNavegacao.CARTEIRA);
                                    },
                                    svgSrc: "relatorio.png"),
                                       CategoryCard(
                                    title: "Relatórios",
                                    press: () {
                                      Navigator.of(context)
                                          .pushNamed(RotasNavegacao.CARTEIRA);
                                    },
                                    svgSrc: "relatorio.png"),
                                       CategoryCard(
                                    title: "Relatórios",
                                    press: () {
                                      Navigator.of(context)
                                          .pushNamed(RotasNavegacao.CARTEIRA);
                                    },
                                    svgSrc: "relatorio.png"),
                              ]),
                        ))
                      ])))
        ],
      ),
    );
  }
}
