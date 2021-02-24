import 'package:emanuellemepoupe/constants/constants_color.dart';
import 'package:emanuellemepoupe/controller/despesa_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ExpansionTileCuston extends StatelessWidget {
  //final GlobalKey expansionTileKey = GlobalKey();
  final despesaController = DespesaController();

  final Widget radio;

  ExpansionTileCuston({this.radio});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      color: kBackgroundColor,
      child: ExpansionTile(
        /*   key: expansionTileKey,
        onExpansionChanged: (value) {
          if (value) {
            _scrollToSelectedContent(expansionTileKey: expansionTileKey);
          }
        },*/
        backgroundColor: kBackgroundColor,
        leading: Container(
          width: size.width * .22,
          child: Row(
            children: [
              radio,
              Spacer(),
              SvgPicture.asset(
                "assets/icons/credito.svg",
                height: 25,
              ),
            ],
          ),
        ),
        title: new Text(
          "CARTÃO CRÉDITO",
          style: TextStyle(
            color: Colors.white,
            fontSize: 15.0,
          ),
        ),
        children: [
          Container(
            color: kTextColor,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        child: Text(
                          "Qual o número de parcelas?",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FloatingActionButton(
                        mini: true,
                        child: Icon(Icons.exposure_neg_1_sharp,
                            color: Colors.black87),
                        backgroundColor: Colors.white,
                        onPressed: () {
                          despesaController.decrementeNumeroParcela();
                        },
                      ),
                      Container(
                        child: ValueListenableBuilder(
                            valueListenable: despesaController.numeroParcela,
                            builder: (context, value, child) {
                              return Text(
                                '$value',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30.0,
                                ),
                              );
                            }),
                      ),
                      FloatingActionButton(
                        mini: true,
                        child: Icon(Icons.exposure_plus_1_sharp,
                            color: Colors.black87),
                        backgroundColor: Colors.white,
                        onPressed: () {
                          despesaController.incrementeNumeroParcela();
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  /*
Função para centralizar o ExpansionTileCuston no centro da tela.
 */
  /* void _scrollToSelectedContent({GlobalKey expansionTileKey}) {
    final keyContext = expansionTileKey.currentContext;
    if (keyContext != null) {
      Future.delayed(Duration(milliseconds: 200)).then((value) {
        Scrollable.ensureVisible(keyContext,
            duration: Duration(milliseconds: 200));
      });
    }
  }*/
}
