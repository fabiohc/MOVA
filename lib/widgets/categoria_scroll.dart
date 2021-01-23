import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../config_midia_query.dart';

class Categories extends StatelessWidget {
  final Function press;
  const Categories({
    Key key,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {"icon": "assets/icons/Flash Icon.svg", "text": "Flash Deal"},
      {"icon": "assets/icons/Bill Icon.svg", "text": "Bill"},
      {"icon": "assets/icons/Game Icon.svg", "text": "Game"},
      {"icon": "assets/icons/Gift Icon.svg", "text": "Daily Gift"},
      {"icon": "assets/icons/Discover.svg", "text": "More"},
    ];

    return Padding(
      padding: EdgeInsets.all(getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          categories.length,
          (index) => CategoryCardScroll(
            icon: categories[index]["icon"],
            text: categories[index]["text"],
            press:press,
          ),
        ),
      ),
    );
  }
}

class CategoryCardScroll extends StatelessWidget {
  const CategoryCardScroll({
    Key key,
    @required this.icon,
    @required this.text,
    @required this.press,
  }) : super(key: key);

  final String icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: getProportionateScreenWidth(45),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(10)),
              height: getProportionateScreenWidth(45),
              width: getProportionateScreenWidth(50),
              decoration: BoxDecoration(
                color: Color(Colors.transparent.value),
                borderRadius: BorderRadius.circular(20),
              ),
              child: SvgPicture.asset(icon),
            ),
            SizedBox(height: 5),
            //  Text(text, textAlign: TextAlign.center)
          ],
        ),
      ),
    );
  }
}
