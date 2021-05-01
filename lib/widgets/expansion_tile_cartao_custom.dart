import 'package:emanuellemepoupe/constants/constants_color.dart';
import 'package:emanuellemepoupe/controller/despesa_controller.dart';
import 'package:flutter/material.dart';
import 'package:emanuellemepoupe/controller/compartilhado_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ExpansionTileCuston extends StatefulWidget {
  final Widget radio;
  final FloatingActionButton floatingActionButtonDecremente;
  final FloatingActionButton floatingActionButtonIncremente;

  ExpansionTileCuston(
      {this.radio,
      this.floatingActionButtonDecremente,
      this.floatingActionButtonIncremente});

  @override
  _ExpansionTileCustonState createState() => _ExpansionTileCustonState();
}

class _ExpansionTileCustonState extends State<ExpansionTileCuston> {
  final despesaController = DespesaController();

  final compartilhadoController = CompartilhadoController();

  var valor;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      color: kBackgroundColor,
      child: ExpansionTile(
        backgroundColor: kBackgroundColor,
        leading: Container(
          width: size.width * .22,
          child: Row(
            children: [
              widget.radio,
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
                      widget.floatingActionButtonDecremente,
                
                      Container(
                        child: ValueListenableBuilder(
                            valueListenable:
                                compartilhadoController.numeroParcela,
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
                      widget.floatingActionButtonIncremente,
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
}
