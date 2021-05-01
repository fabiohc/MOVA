import 'package:flutter/material.dart';

class FloatingButtonAnimado extends StatefulWidget {
  @override
  _FloatingButtonAnimadoState createState() => _FloatingButtonAnimadoState();
}

class _FloatingButtonAnimadoState extends State<FloatingButtonAnimado>
    with SingleTickerProviderStateMixin {
  bool isOpened = false;
  AnimationController _animationController;
  Animation<Color> _animateColor;
  Curve _curve = Curves.easeOut;

  @override
  initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addListener(() {
            setState(() {});
          });
    _animateColor = ColorTween(
      begin: Colors.blue,
      end: Colors.red,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.00,
        1.00,
        curve: _curve,
      ),
    ));
    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate() async {
    if (!isOpened) {
      _animationController.forward();
     //  Navigator.of(context).pushNamed(RotasNavegacao.LISTA_PESSOAS);


    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }

  Widget toggle() {
    return FloatingActionButton(
      backgroundColor: _animateColor.value,
      onPressed: animate,
      child: !isOpened == true ? Icon(Icons.search) : Icon(Icons.clear),
      tooltip: "Pesquisar",
    );
  }

  @override
  Widget build(BuildContext context) {
    return toggle();
  }
}
