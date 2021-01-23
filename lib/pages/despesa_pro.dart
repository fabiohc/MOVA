import 'package:brasil_fields/brasil_fields.dart';
import 'package:emanuellemepoupe/constants/constants_color.dart';
import 'package:emanuellemepoupe/controller/despesa_controller.dart';
import 'package:emanuellemepoupe/controller/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_svg/flutter_svg.dart';

class Despesapro extends StatefulWidget {
  @override
  _DespesaproState createState() => _DespesaproState();
}

class _DespesaproState extends State<Despesapro>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  String data = DateTime.now().toString();
  final despesaController = DespesaController();
  Util _util = Util();

  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
        body: Container(
      color: kTextColor,
      height: size.height,
      child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Stack(children: <Widget>[
            Container(
                height: size.height * .40,
                decoration: BoxDecoration(color: kBlueColor)),
            Container(
              margin: EdgeInsets.symmetric(vertical: size.height * .10),
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        child: Text(
                          "Qual o valor?",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(children: <Widget>[
                    Text(
                      "R\$ ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                      width: size.width * .5,
                      child: TextFormField(
                        autofocus: true,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(9),
                          FilteringTextInputFormatter.digitsOnly,
                          RealInputFormatter(centavos: true)
                        ],
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(4.0),
                          border: InputBorder.none,
                          labelStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 35.0,
                        ),
                      ),
                    ),
                  ]),
                  SizedBox(height: 20),
                  Container(
                    child: Row(
                      children: [
                        SizedBox(
                          height: 30,
                          width: size.width * .4,
                          child: TextFormField(
                            initialValue:
                                _util.formatData(DateTime.now().toString()),
                            autofocus: false,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              DataInputFormatter()
                            ],
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                        IconButton(
                            icon: Icon(Icons.calendar_today),
                            color: Colors.white,
                            onPressed: () async {
                              await showDatePicker(
                                context: context,
                                initialDate: new DateTime.now(),
                                firstDate: new DateTime(2000),
                                lastDate: new DateTime(2100),
                              );
                            }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: size.height * .36),
              height: size.height,
              child: ListView(
                physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  new Container(
                    decoration: new BoxDecoration(color: kTextColor),
                    child: new TabBar(
                      controller: _controller,
                      tabs: [
                        new Tab(
                          icon: const Icon(Icons.home),
                          text: 'Address',
                        ),
                        new Tab(
                          icon: const Icon(Icons.my_location),
                          text: 'Location',
                        ),
                      ],
                    ),
                  ),
                  new Container(
                    decoration: BoxDecoration(),
                    height: size.height * .60,
                    width: size.width,
                    child: new TabBarView(
                      controller: _controller,
                      children: <Widget>[
                        new ListView(
                          children: [
                            Container(
                              width: size.width,
                              height: size.height * .10,
                              color: kBlueColor,
                              child: ListTile(
                                leading: SvgPicture.asset(
                                    "assets/icons/Flash Icon.svg"),
                                title: Text('DINHEIRO'),
                                tileColor: kcBackgroundColor,
                              ),
                            ),
                            Container(
                              width: size.width,
                              height: size.height * .10,
                              child: ListTile(
                                leading: SvgPicture.asset(
                                    "assets/icons/Flash Icon.svg"),
                                title: Text('TRANSFERÊNCIA'),
                                tileColor: kShadowColor,
                              ),
                            ),
                            Container(
                              width: size.width,
                              height: size.height * .10,
                              color: kBlueColor,
                              child: ListTile(
                                leading: SvgPicture.asset(
                                    "assets/icons/Flash Icon.svg"),
                                title: Text('CARTÃO DÉBITO'),
                                tileColor: kBlueLightColor,
                              ),
                            ),
                            Container(
                              color: kBackgroundColor,
                              child: ExpansionTile(
                                backgroundColor: kTextColor,
                                leading: SvgPicture.asset(
                                    "assets/icons/Flash Icon.svg"),
                                title: new Text(
                                  "CARTÃO CRÉDITO",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                  ),
                                ),
                                children: [
                                  Container(
                                    color: kTextColor,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                child: Text(
                                                  "Qual o número de parcelas?",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15.0,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 20),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              FloatingActionButton(
                                                mini: true,
                                                child: Icon(
                                                    Icons.exposure_neg_1_sharp,
                                                    color: Colors.black87),
                                                backgroundColor: Colors.white,
                                                onPressed: () {
                                                  despesaController
                                                      .decrementeNumeroParcela();
                                                },
                                              ),
                                              Container(
                                                child: ValueListenableBuilder(
                                                    valueListenable:
                                                        despesaController
                                                            .numeroParcela,
                                                    builder: (context, value,
                                                        child) {
                                                      return Text(
                                                        '$value',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 30.0,
                                                        ),
                                                      );
                                                    }),
                                              ),
                                              new FloatingActionButton(
                                                mini: true,
                                                child: Icon(
                                                    Icons.exposure_plus_1_sharp,
                                                    color: Colors.black87),
                                                backgroundColor: Colors.white,
                                                onPressed: () {
                                                  despesaController
                                                      .incrementeNumeroParcela();
                                                },
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        new Card(
                            child: new Container(
                          color: kBackgroundColor,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      child: Text(
                                        "Qual o número de parcelas?",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    FloatingActionButton(
                                      mini: true,
                                      child: Icon(Icons.exposure_neg_1_sharp,
                                          color: Colors.black87),
                                      backgroundColor: Colors.white,
                                      onPressed: () {
                                        despesaController
                                            .decrementeNumeroParcela();
                                      },
                                    ),
                                    Container(
                                      child: ValueListenableBuilder(
                                          valueListenable:
                                              despesaController.numeroParcela,
                                          builder: (context, value, child) {
                                            return Text('$value');
                                          }),
                                    ),
                                    new FloatingActionButton(
                                      mini: true,
                                      child: Icon(Icons.exposure_plus_1_sharp,
                                          color: Colors.black87),
                                      backgroundColor: Colors.white,
                                      onPressed: () {
                                        despesaController
                                            .incrementeNumeroParcela();
                                      },
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ])),
    ));
  }
}
