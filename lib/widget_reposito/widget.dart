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

/*Conteine animation*/
    new Container(
                          padding: EdgeInsets.only(top: 25),
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(40)),
                              color: Color(0xfff1f1f1)),
                          child: Column(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(bottom: 25),
                                height: 3,
                                width: 65,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Color(0xffd9dbdb)),
                              )
                            ],
                          ),
                        ),

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
