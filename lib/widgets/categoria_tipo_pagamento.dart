import 'package:emanuellemepoupe/constants/constants_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../config_midia_query.dart';

class CategoriesTipoPag extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {
        "icon": "assets/icons/Flash Icon.svg",
        "text": "DINHEIRO",
        "color": kcBackgroundColor
      },
      {
        "icon": "assets/icons/Bill Icon.svg",
        "text": "TRANSFERÊNCIA",
        "color": kBlueLightColor
      },
      {
        "icon": "assets/icons/Game Icon.svg",
        "text": "CARTÃO",
        "color": kShadowColor
      }
    ];
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(0),
          vertical: getProportionateScreenWidth(280)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          categories.length,
          (index) => CategoryCardScroll(
            icon: categories[index]["icon"],
            text: categories[index]["text"],
            color: categories[index]["color"],
            press: () {},
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
    @required this.color,
  }) : super(key: key);

  final String icon, text;
  final GestureTapCallback press;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: getProportionateScreenWidth(1),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(10)),
              height: getProportionateScreenWidth(55),
              width: getProportionateScreenWidth(50),
              decoration: BoxDecoration(
                color: Color(color.value),
                borderRadius: BorderRadius.circular(0),
              ),
              child: SvgPicture.asset(icon),
            ),
            Container(
                padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                height: getProportionateScreenWidth(55),
                width: getProportionateScreenWidth(200),
                decoration: BoxDecoration(
                  color: Color(color.value),
                  borderRadius: BorderRadius.circular(0),
                ),
                child: ListView(
                  children: [
                    ExpansionPanelList(
                      expansionCallback: (int index, bool isExpanded) {},
                      children: [
                        ExpansionPanel(
                          headerBuilder:
                              (BuildContext context, bool isExpanded) {
                            return ListTile(
                              title: Text('Item 1'),
                            );
                          },
                          body: ListTile(
                            title: Text('Item 1 child'),
                            subtitle: Text('Details goes here'),
                          ),
                          isExpanded: true,
                        ),
                  
                      ],
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
