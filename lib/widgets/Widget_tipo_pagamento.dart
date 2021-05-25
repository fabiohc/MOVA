import 'package:emanuellemepoupe/controller/despesa_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ignore: must_be_immutable
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

    return Container(
      width: size.width,
      height: size.height * .0999,
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
    );
  }
}
