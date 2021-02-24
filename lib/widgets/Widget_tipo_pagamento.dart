import 'package:emanuellemepoupe/controller/despesa_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WidgetTipoPagamento extends StatefulWidget {
  double height;
  final String caminhoIconSvg;
  final String descricao;
  final Color color;
  final bool valor;
  final Function onChanged;
  final Widget radio;

  WidgetTipoPagamento(
      {this.height,
      this.caminhoIconSvg,
      this.descricao,
      this.color,
      this.valor,
      this.onChanged,
      this.radio});

  @override
  _WidgetTipoPagamentoState createState() => _WidgetTipoPagamentoState();
}

class _WidgetTipoPagamentoState extends State<WidgetTipoPagamento> {
  var despesaController = DespesaController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return GestureDetector(
        onTap: () {
          setState(() {
            widget.height > 0.13 ? widget.height = 0.13 : widget.height = 0.17;
          });
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 100),
          curve: Curves.easeIn,
          width: size.width * .94,
          height: size.width * widget.height,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12), topRight: Radius.circular(12))),
          child: Container(
            width: size.width,
            height: size.height * .10,
            child: ListTile(
              leading: Container(
                width: size.width * .23,
                child: Row(
                  children: [
                    widget.radio,
                    Spacer(),
                    SvgPicture.asset(
                      widget.caminhoIconSvg,
                      height: 25,
                    )
                  ],
                ),
              ),
              title: Text(widget.descricao),
              tileColor: widget.color,
            ),
          ),
        ));
  }
}
