import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavBar extends StatelessWidget {
  final Widget icon;
  final String caminhoIconSvg;
  final Function press;
  final AlignmentGeometry alignment;
  final Color color;
  final Color colorfonte;
  final double margin;
  final String descricao;
  const BottomNavBar({
    Key key,
    this.icon,
    this.caminhoIconSvg,
    this.press,
    this.alignment,
    this.color,
    this.margin,
    this.descricao,
    this.colorfonte
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SafeArea(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: [
                        Align(
                          alignment: alignment == null
                              ? Alignment.bottomLeft
                              : alignment,
                          child: Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: margin == null ? 0.0 : margin),
                              alignment: Alignment.center,
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                // border: Border.all(color: Colors.white),
                                color: color == null
                                    ? Colors.transparent.withOpacity(0.1)
                                    : color,
                                shape: BoxShape.circle,
                              ),
                              child: icon != null
                                  ? icon
                                  : SvgPicture.asset(caminhoIconSvg)),
                        ),
                        if ( descricao != null)
                          Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              child: Text(
                                descricao,
                                style: TextStyle(color: colorfonte != null ? colorfonte :  Colors.white),
                              )),
                      ],
                    ),
                  ]))),
    );
  }
}
