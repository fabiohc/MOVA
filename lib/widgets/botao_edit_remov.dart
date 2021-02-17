import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BotaoEditarRemover extends StatelessWidget {
  final Function onPressedEditar;
  final Function onPressedExcluir;

  const BotaoEditarRemover(
      {Key key, this.onPressedEditar, this.onPressedExcluir})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
        width: size.width * .27,
        color: Colors.transparent,
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Row(
            children: [
              IconButton(
                icon: (SvgPicture.asset(
                  "assets/icons/editar.svg",
                  color: Colors.deepOrange,
                )),
                tooltip: "Editar",
                onPressed: onPressedEditar,
              ),
              IconButton(
                icon: (SvgPicture.asset("assets/icons/Trash.svg")),
                tooltip: "Remover",
                onPressed: onPressedExcluir,
              ),
            ],
          ),
        ));
  }
}
