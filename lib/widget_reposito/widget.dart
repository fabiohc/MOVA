/*numberpicker: ^1.2.0

import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

int _numeroParcelaInicial = 1;
bool viewVisible = false;
bool apresentaNumeroParcelas = false;

Widget buildvisibilidadeNumberPicker() {
    return Column(
      children: <Widget>[
        Visibility(
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          visible: viewVisible,
          child: Container(
            child: numberPicker(),
          ),
        ),
      ],
    );
  }

  Widget numberPicker() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new NumberPicker.horizontal(
            initialValue: _numeroParcelaInicial,
            minValue: 1,
            maxValue: 12,
            onChanged: (newValue) =>
                setState(() => _numeroParcelaInicial = newValue)),
      ],
    );
Widget getImage(String path) {
      return Image.asset("images/$path");
    }


//Menu inferior
     bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.blueAccent,
        items: <Widget>[
          Icon(Icons.add, size: 30),
          Icon(Icons.list, size: 30),
          Icon(Icons.compare_arrows, size: 30),
        ],
        onTap: (index) {
          //Handle button tap
        },
      ),

  }*/
