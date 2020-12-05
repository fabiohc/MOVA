import 'package:brasil_fields/formatter/real_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:emanuellemepoupe/controller/despesa_controller.dart';
import 'package:emanuellemepoupe/controller/util.dart';
import 'package:flutter/material.dart';
import 'package:emanuellemepoupe/pages/rotas.dart';
import 'package:flushbar/flushbar.dart';

class CadastroDespesa extends StatefulWidget {
  @override
  _CadastroDespesaState createState() => _CadastroDespesaState();

  final String descriaoServico;
  CadastroDespesa({this.descriaoServico});
}

class _CadastroDespesaState extends State<CadastroDespesa> {
  final despesaController = DespesaController();
  Util _util = Util();

  bool viewVisible = false;
  bool apresentaNumeroParcelas = false;
  double opacityLevelDinheiro = 1.0;
  double opacityLevelTransferencia = 1.0;
  double opacityLevelCartao = 1.0;
  double opacityLevelCredito = 1.0;
  double opacityLevelDebito = 1.0;
  DateTime _dateTime = DateTime.now();
  final _valideValor = GlobalKey<FormState>();
  final _valideNumeroParcela = GlobalKey<FormState>();

  Widget getImage(String path) {
    return Image.asset("images/$path.png");
  }

  Widget buildRaisedButtonDebitoCredito() {
    return Container(
      width: 210,
      alignment: Alignment.center,
      child: Row(
        children: [
          AnimatedOpacity(
              opacity: opacityLevelDebito,
              duration: Duration(microseconds: 5),
              child: RaisedButton(
                child: Text("Débito"),
                color: Colors.blueGrey,
                shape:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                textColor: Colors.white,
                padding: EdgeInsets.fromLTRB(28.0, 10.0, 28.0, 10.0),
                onPressed: () {
                  despesaController.despesaModel.alteraDespTipoCartao("Débito");
                  despesaController.despesaModel
                      .alteraDespMostrarParcelas(false);
                  buildvisibilidadeQtdParcelas();
                  setState(() => opacityLevelDebito = 1.0);
                  setState(() => opacityLevelCredito = 0.3);
                },
              )),
          SizedBox(
            width: 15,
          ),
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            AnimatedOpacity(
                opacity: opacityLevelCredito,
                duration: Duration(microseconds: 5),
                child: RaisedButton(
                  child: Text("Crédito"),
                  color: Colors.blueGrey,
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  textColor: Colors.white,
                  padding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
                  onPressed: () {
                    setState(() => opacityLevelCredito = 1.0);
                    setState(() => opacityLevelDebito = 0.3);
                    despesaController.despesaModel
                        .alteraDespTipoCartao("Crédito");
                    despesaController.despesaModel
                        .alteraDespMostrarParcelas(true);
                    buildvisibilidadeQtdParcelas();
                  },
                )),
          ])
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pagar"),
        backgroundColor: Color(0XFFF92B7F),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              Navigator.pushReplacementNamed(
                  context, RotasNavegacao.LISTA_DESPESAS);
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(
          left: 15,
          right: 15,
        ),
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.3, 1.0],
          colors: [
            Color(0XFFF92B7F),
            Color(0xFFE6E6E6),
          ],
        )),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(
                padding: EdgeInsets.only(left: 30, right: 30),
                height: 450,
                width: 330,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.3, 1.0],
                    colors: [
                      Color(0xFFFFFFFF),
                      Color(0xFFFFFFFF),
                    ],
                  ),
                  border: Border.all(
                    width: 4.0,
                    color: const Color(0xFFFFFFFF),
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Container(
                  child: Form(
                      key: _valideValor,
                      child: Column(
                        children: <Widget>[
                          new Text(
                            despesaController.despesaModel
                                .alteraDespServico("${widget.descriaoServico}"),
                            style: new TextStyle(
                                color: Colors.pinkAccent, fontSize: 20.0),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            autofocus: false,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              RealInputFormatter(centavos: true)
                            ],
                            onChanged: (_valorServico) {
                              despesaController.despesaModel
                                  .alteraDespValor(_valorServico);
                            },
                            decoration: InputDecoration(
                              icon: Icon(Icons.attach_money),
                              labelText: "Valor do pagameno",
                              labelStyle: TextStyle(
                                color: Colors.black38,
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                              ),
                            ),
                            validator: (String _valorServico) {
                              if (_valorServico.isEmpty) {
                                return "Insira uma valor para o pagamento";
                              }
                              return null;
                            },
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                child: new Icon(
                                  Icons.calendar_today,
                                  size: 20.0,
                                  color: Colors.purple,
                                ),
                              ),
                              Observer(builder: (_) {
                                return FlatButton(
                                  child: new Row(
                                    children: <Widget>[
                                      new Text(
                                          despesaController
                                                      .despesaModel.despData ==
                                                  null
                                              ? despesaController
                                                      .despesaModel.despData =
                                                  _util.formatData(
                                                      DateTime.now().toString())
                                              : despesaController
                                                  .despesaModel.despData,
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.blueGrey[600]),
                                          textAlign: TextAlign.start)
                                    ],
                                  ),
                                  onPressed: () async {
                                    final dtpkr = await showDatePicker(
                                      context: context,
                                      initialDate: new DateTime.now(),
                                      firstDate: new DateTime(2000),
                                      lastDate: new DateTime(2100),
                                    );
                                    if (dtpkr != null && dtpkr != _dateTime) {
                                      despesaController.despesaModel
                                          .alteraDespData(_util
                                              .formatData(dtpkr.toString()));
                                    }
                                  },
                                );
                              }),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextFormField(                            
                            decoration: InputDecoration(                              
                              focusedBorder: OutlineInputBorder(
                                 borderSide: const BorderSide(color: Colors.purple, width: 1.5),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                              ),                              
                              icon: Icon(Icons.short_text),
                              labelText: "obs.:",                            
                            ),
                             onChanged: (value) {
                              despesaController.despesaModel
                                  .alteraDespdespObservacao(value);
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          buildMenu(),
                          SizedBox(
                            height: 10,
                          ),
                          buildvisibilidadeRaisedButtonDebitoCredito(),
                          buildvisibilidadeQtdParcelas(),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      )),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(
                height: 45,
                width: 300,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.3, 1],
                    colors: [
                      Color(0xFF90A4AE),
                      Color(0xFF90A4AE),
                    ],
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: SizedBox.expand(
                  child: FlatButton(
                    child: Text(
                      "Salvar",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    onPressed: () {
                      if (_valideValor.currentState.validate()) {
                        despesaController.insiraNovaDespesa();
                        Flushbar(
                          title: "Pronto!",
                          message: "Registro salvo com sucesso",
                          margin: EdgeInsets.all(10),
                          borderRadius: 8,
                          backgroundGradient: LinearGradient(
                              colors: [Colors.blue, Colors.teal]),
                          //duration: Duration(seconds: 3),
                          mainButton: FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.pushReplacementNamed(
                                  context, RotasNavegacao.LISTA_DESPESAS);
                            },
                            child: Text(
                              "OK",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        )..show(context);
                      }
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildMenu() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Observer(builder: (_) {
        return GestureDetector(
            onTap: () {
              despesaController.despesaModel
                  .alteraDespFormaPagamento("Dinheiro");
              despesaController.despesaModel.alteraDespNumeroParcelas(0);
              despesaController.despesaModel.alteraDespMostrarBotao(false);
              despesaController.despesaModel.alteraDespMostrarParcelas(false);
              buildvisibilidadeRaisedButtonDebitoCredito();
              setState(() => opacityLevelCartao = 0.3);
              setState(() => opacityLevelTransferencia = 0.3);
              setState(() => opacityLevelDinheiro = 1.0);
            },
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                "Dinheiro",
                style: new TextStyle(color: Colors.blueGrey, fontSize: 15.0),
              ),
              AnimatedOpacity(
                  opacity: opacityLevelDinheiro,
                  duration: Duration(microseconds: 5),
                  child: getImage("dinheiro48px")),
            ]));
      }),
      Observer(builder: (_) {
        return GestureDetector(
            onTap: () {
              despesaController.despesaModel
                  .alteraDespFormaPagamento("Transferido");
              despesaController.despesaModel.alteraDespNumeroParcelas(0);
              despesaController.despesaModel.alteraDespMostrarBotao(false);
              despesaController.despesaModel.alteraDespMostrarParcelas(false);
              buildvisibilidadeRaisedButtonDebitoCredito();
              setState(() => opacityLevelTransferencia = 1.0);
              setState(() => opacityLevelCartao = 0.3);
              setState(() => opacityLevelDinheiro = 0.3);
            },
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                "Transferir",
                style: new TextStyle(color: Colors.blueGrey, fontSize: 15.0),
              ),
              AnimatedOpacity(
                  opacity: opacityLevelTransferencia,
                  duration: Duration(microseconds: 5),
                  child: getImage("transferencia48px")),
            ]));
      }),
      Observer(builder: (_) {
        return GestureDetector(
            onTap: () {
              despesaController.despesaModel.alteraDespFormaPagamento("Cartão");
              despesaController.despesaModel.alteraDespMostrarBotao(true);
              buildvisibilidadeRaisedButtonDebitoCredito();
              setState(() => opacityLevelTransferencia = 0.3);
              setState(() => opacityLevelCartao = 1.0);
              setState(() => opacityLevelDinheiro = 0.3);
            },
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                "Cartão",
                style: new TextStyle(color: Colors.blueGrey, fontSize: 15.0),
              ),
              AnimatedOpacity(
                  opacity: opacityLevelCartao,
                  duration: Duration(microseconds: 5),
                  child: getImage("cartao48px")),
            ]));
      })
    ]);
  }

  Widget buildvisibilidadeQtdParcelas() {
    return Column(
      children: [
        Observer(builder: (_) {
          return Visibility(
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            visible: despesaController.despesaModel.despMostrarParcelas,
            child: Container(
              child: buildTextFormFieldQtdParcelas(),
            ),
          );
        }),
      ],
    );
  }

  Widget buildTextFormFieldQtdParcelas() {
    return Observer(builder: (_) {
      return TextFormField(
        key: _valideNumeroParcela,
        autofocus: false,
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          RealInputFormatter(centavos: true)
        ],
        onChanged: (value) {
          despesaController.despesaModel
              .alteraDespNumeroParcelas(int.parse(value));
        },
        decoration: InputDecoration(
          icon: Icon(Icons.format_list_numbered),
          labelText: "Qtd parcelas",
          labelStyle: TextStyle(
            color: Colors.black38,
            fontWeight: FontWeight.w400,
            fontSize: 15,
          ),
        ),
        /*validator: (value) {
          if (value.isEmpty) {
            return "Insira número de parcelas";
          }
          return null;
        },*/
        style: TextStyle(
          fontSize: 15,
        ),
      );
    });
  }

  Widget buildvisibilidadeRaisedButtonDebitoCredito() {
    return Column(
      children: <Widget>[
        Observer(builder: (_) {
          return Visibility(
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            visible: despesaController.despesaModel.despMostrarBotao,
            child: Container(
              child: buildRaisedButtonDebitoCredito(),
            ),
          );
        }),
      ],
    );
  }
}