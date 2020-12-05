import 'package:flutter/material.dart';
import 'package:emanuellemepoupe/constants/constants_color.dart';
import 'package:emanuellemepoupe/controller/despesa_controller.dart';
import 'package:emanuellemepoupe/pages/cadastroDespesa.dart';
import 'package:emanuellemepoupe/widgets/categoryCard.dart';

class MenuDespesa extends StatefulWidget {
  @override
  _MenuDespesaState createState() => _MenuDespesaState();
}

class _MenuDespesaState extends State<MenuDespesa> {
  final despesaController = DespesaController();
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
                              childAspectRatio: .70,
                              crossAxisSpacing: 40,
                              mainAxisSpacing: 20,
                              children: <Widget>[
                                CategoryCard(
                                  title: "Aluguel",
                                  svgSrc: "aluguel.png",
                                  press: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CadastroDespesa(
                                                  descriaoServico:
                                                      despesaController
                                                          .despesaModel
                                                          .alteraDespServico(
                                                              "Aluguel"),
                                                )));
                                  },
                                ),
                                CategoryCard(
                                  title: "Condominio",
                                  svgSrc: "condominio.png",
                                  press: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CadastroDespesa(
                                                  descriaoServico:
                                                      despesaController
                                                          .despesaModel
                                                          .alteraDespServico(
                                                              "Condominio"),
                                                )));
                                  },
                                ),
                                CategoryCard(
                                    title: "Energia",
                                    press: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CadastroDespesa(
                                                    descriaoServico:
                                                        despesaController
                                                            .despesaModel
                                                            .alteraDespServico(
                                                                "Energia"),
                                                  )));
                                    },
                                    svgSrc: "energia.png"),
                                CategoryCard(
                                    title: "Outros",
                                    press: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CadastroDespesa(
                                                    descriaoServico:
                                                        despesaController
                                                            .despesaModel
                                                            .alteraDespServico(
                                                                "Outros"),
                                                  )));
                                    },
                                    svgSrc: "boleto.png"),
                              ]),
                        ))
                      ]))),
        
        ],
      ),
     /* bottomNavigationBar:   BottomNavigationBar(
        fixedColor: Color(0XFFF92B7F),
        items: [
            BottomNavigationBarItem(
                title: Text("Início"), icon: Icon(Icons.home)
                ),
                  BottomNavigationBarItem(
                title: Text("Início"), icon: Icon(Icons.home))
          ]),*/
    );
  }
}
