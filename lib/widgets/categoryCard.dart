import 'package:flutter/material.dart';
import 'package:emanuellemepoupe/constants/constants_color.dart';
import 'package:flutter_svg/svg.dart';

class CategoryCard extends StatelessWidget {
  final String svgSrc;
  final String title;
  final Function press;
  final Color color;
  const CategoryCard({
    Key key,
    this.svgSrc,
    this.title,
    this.press,
     this.color = Colors.black
  }) : super(key: key);

  Widget getImage(String path) {
    if (path.contains("png")) {
      return Image.asset("images/$path");
    } else
      return SvgPicture.asset(
        "assets/icons/$path",
        color: color ,
        width: 40,
        height: 40,
      );
  }

  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(13),
      child: Container(
        // padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(13),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 17),
              blurRadius: 17,
              spreadRadius: -23,
              color: kActiveIconColor,
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: press,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: <Widget>[
                  Spacer(),
                  getImage(
                    svgSrc,
                  ),
                  Spacer(),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        // ignore: deprecated_member_use
                        .title
                        .copyWith(fontSize: 12),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
