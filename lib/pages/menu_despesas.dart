import 'package:emanuellemepoupe/pages/cadastro_despesa_receita.dart';
import 'package:flutter/material.dart';
import 'package:emanuellemepoupe/constants/constants_color.dart';
import 'package:emanuellemepoupe/controller/despesa_controller.dart';
import 'package:emanuellemepoupe/widgets/categoryCard.dart';
import 'package:emanuellemepoupe/widgets/navegacao.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:emanuellemepoupe/pages/rotas.dart';

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

      body: Stack(
        children: [
          Container(
           
            height: size.height * .35,
            decoration: BoxDecoration(
              color: Color(0xFFF630000),
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
            descricao: "MENU DESPESAS",
          ),
          SafeArea(
              child: Padding(
                  padding:
                       EdgeInsets.symmetric(horizontal: 30, vertical:size.height * 0.11),
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
                                  title: "Aluguel",
                                  svgSrc: "aluguel.png",
                                  press: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CadastroDespesaReceita(
                                                  acao: 'pagar',
                                                  descricaoServico:
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
                                                CadastroDespesaReceita(
                                                  acao: 'pagar',
                                                  descricaoServico:
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
                                                  CadastroDespesaReceita(
                                                    acao: 'pagar',
                                                    descricaoServico:
                                                        despesaController
                                                            .despesaModel
                                                            .alteraDespServico(
                                                                "Energia"),
                                                  )));
                                    },
                                    svgSrc: "energia.png"),
                                CategoryCard(
                                    title: "Fornecedor",
                                    press: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CadastroDespesaReceita(
                                                    acao: 'pagar',
                                                    descricaoServico:
                                                        despesaController
                                                            .despesaModel
                                                            .alteraDespServico(
                                                                "Fornecedor"),
                                                  )));
                                    },
                                    svgSrc: "material.png"),
                                CategoryCard(
                                    title: "Transporte",
                                    press: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CadastroDespesaReceita(
                                                    acao: 'pagar',
                                                    descricaoServico:
                                                        despesaController
                                                            .despesaModel
                                                            .alteraDespServico(
                                                                "Transporte"),
                                                  )));
                                    },
                                    svgSrc: "transporte.png"),
                                CategoryCard(
                                    title: "Outros",
                                    press: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CadastroDespesaReceita(
                                                    acao: 'pagar',
                                                    descricaoServico:
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
