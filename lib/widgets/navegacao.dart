import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavBar extends StatelessWidget {
  final Widget icon;
  final String caminhoIconSvg;
  final Function press;
  final AlignmentGeometry alignment;
  final Color color;
  final double margin;
  const BottomNavBar(
      {Key key,
      this.icon,
      this.caminhoIconSvg,
      this.press,
      this.alignment,
      this.color,
      this.margin})
      : super(
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
                    Align(
                      alignment:
                          alignment == null ? Alignment.bottomLeft : alignment,
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: margin == null ? 0.0 : margin),
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
                    )
                  ]))),
    );
  }
}
