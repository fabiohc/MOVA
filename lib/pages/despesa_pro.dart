import 'package:brasil_fields/brasil_fields.dart';
import 'package:emanuellemepoupe/constants/constants_color.dart';
import 'package:emanuellemepoupe/controller/despesa_controller.dart';
import 'package:emanuellemepoupe/controller/pessoa_controller.dart';
import 'package:emanuellemepoupe/controller/util.dart';
import 'package:emanuellemepoupe/model/pessoa_model.dart';
import 'package:emanuellemepoupe/pages/lista_pessoa.dart';
import 'package:emanuellemepoupe/pages/rotas.dart';
import 'package:emanuellemepoupe/widgets/Widget_tipo_pagamento.dart';
import 'package:emanuellemepoupe/widgets/navegacao.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Despesapro extends StatefulWidget {
  @override
  _DespesaproState createState() => _DespesaproState();
}

class _DespesaproState extends State<Despesapro>
    with SingleTickerProviderStateMixin {
  final GlobalKey expansionTileKey = GlobalKey();
  TabController _controller;
  String data = DateTime.now().toString();
  final despesaController = DespesaController();
  final pessoaController = PessoaController();
  var pessoaSelecionada = PessoaModel();
  var pessoaModel = PessoaModel();
  Util _util = Util();

  @override
  void initState() {
    super.initState();

    _controller = new TabController(length: 3, vsync: this);
  }

  void _scrollToSelectedContent({GlobalKey expansionTileKey}) {
    final keyContext = expansionTileKey.currentContext;
    if (keyContext != null) {
      Future.delayed(Duration(milliseconds: 200)).then((value) {
        Scrollable.ensureVisible(keyContext,
            duration: Duration(milliseconds: 200));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (pessoaSelecionada != null)
      pessoaController.pessoaModel = pessoaSelecionada;

    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
          child: Container(
        color: kTextColor,
        height: 570,
        child: SingleChildScrollView(
           physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Stack(children: <Widget>[
                 Container(
                  height: size.height * .40,
                  decoration: BoxDecoration(color: kBlueColor)),
              BottomNavBar(
                //  caminhoIconSvg: "assets/icons/Voltar ICon.svg",
                icon: SvgPicture.asset(
                  "assets/icons/Voltar ICon.svg",
                  color: Colors.white,
                ),
                margin: 10,
                alignment: Alignment.bottomLeft,
                // color: Colors.white.withOpacity(2),
                press: () {
                  Navigator.of(context).pushNamed(RotasNavegacao.HOME);
                },
              ),
              BottomNavBar(
                //  caminhoIconSvg: "assets/icons/Voltar ICon.svg",
                icon: SvgPicture.asset(
                  "assets/icons/historico.svg",
                  color: Colors.white,
                  height: 20,
                  semanticsLabel: "Historico",
                ),
                margin: 10,
                alignment: Alignment.bottomRight,
                // color: Colors.white.withOpacity(2),
                press: () {
                  Navigator.of(context)
                      .pushNamed(RotasNavegacao.LISTA_DESPESAS);
                },
              ),
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
                          child: ValueListenableBuilder(
                            valueListenable: pessoaController.pessoa,
                            builder: (context, value, child) {
                              return TextFormField(
                                autofocus: false,
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: true),
                                initialValue:
                                    despesaController.despesaModel.despValor,
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
                                onChanged: (value) {
                                  despesaController.despesaModel
                                      .alteraDespValor(value);
                                },
                              );
                            },
                          )),
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
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
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
                height: size.height * .59,
                child: ListView(
                  physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    new Container(
                      decoration: new BoxDecoration(color: kTextColor),
                      child: new TabBar(
                        controller: _controller,
                        tabs: [
                          new Tab(
                            icon: SvgPicture.asset("assets/icons/pagamento.svg",
                                color: Colors.grey,
                                height: 30,
                                semanticsLabel: 'Pagamentos'),
                            // text: 'Pagamento',
                          ),
                          new Tab(
                            icon: SvgPicture.asset("assets/icons/User Icon.svg",
                                color: Colors.grey,
                                height: 28,
                                semanticsLabel: 'Clientes'),
                            // text: 'Cliente',
                          ),
                          new Tab(
                            icon: SvgPicture.asset("assets/icons/descricao.svg",
                                color: Colors.grey,
                                height: 30,
                                semanticsLabel: 'Observação'),
                            //   text: 'Descrição',
                          ),
                        ],
                      ),
                    ),
                    new Container(
                      height: size.height * .411,
                      width: size.width,
                      child: new TabBarView(
                        controller: _controller,
                        children: <Widget>[
                          new ListView(
                            children: [
                              WidgetTipoPagamento(
                                height: 0.17,
                                descricao: 'DINHEIRO',
                                caminhoIconSvg: "assets/icons/dinheiro.svg",
                                color: kcBackgroundColor,
                              ),
                              WidgetTipoPagamento(
                                height: 0.17,
                                descricao: 'TRANSFERÊNCIA',
                                caminhoIconSvg:
                                    "assets/icons/transferencia.svg",
                                color: kShadowColor,
                              ),
                              WidgetTipoPagamento(
                                height: 0.17,
                                descricao: 'CARTÃO DÉBITO',
                                caminhoIconSvg: "assets/icons/debito.svg",
                                color: kBlueLightColor,
                              ),
                              Container(
                                color: kBackgroundColor,
                                child: ExpansionTile(
                                  key: expansionTileKey,
                                  onExpansionChanged: (value) {
                                    if (value) {
                                      _scrollToSelectedContent(
                                          expansionTileKey: expansionTileKey);
                                    }
                                  },
                                  backgroundColor: kTextColor,
                                  leading: Container(
                                    width: size.width * .23,
                                    child: Row(
                                      children: [
                                        Radio(
                                            value: null,
                                            groupValue: null,
                                            onChanged: null),
                                        Spacer(),
                                        SvgPicture.asset(
                                          "assets/icons/credito.svg",
                                          height: 25,
                                        ),
                                      ],
                                    ),
                                  ),
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
                                        padding: const EdgeInsets.all(15.0),
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
                                                      Icons
                                                          .exposure_neg_1_sharp,
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
                                                FloatingActionButton(
                                                  mini: true,
                                                  child: Icon(
                                                      Icons
                                                          .exposure_plus_1_sharp,
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
                          new Container(
                              padding: EdgeInsets.only(top: 3),
                              decoration:
                                  BoxDecoration(color: Color(0xfff1f1f1)),
                              child: Stack(
                                children: [
                                  Observer(builder: (_) {
                                    return Column(
                                      children: <Widget>[
                                        ListTile(
                                          dense: true,
                                          contentPadding:
                                              EdgeInsets.fromLTRB(17, 0, 0, 0),
                                          leading: Container(
                                              width: 60.0,
                                              height: 60.0,
                                              color: Colors.transparent,
                                              child: CircleAvatar(
                                                child: SvgPicture.asset(
                                                    "assets/icons/Image foto.svg"),
                                                backgroundColor: Colors.white,
                                              )),
                                          title: Text(
                                            pessoaController.pessoaModel
                                                        .pessoaNome !=
                                                    null
                                                ? "${pessoaController.pessoaModel.pessoaNome}"
                                                : "Nome:",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15.0,
                                            ),
                                          ),
                                          trailing: const Icon(
                                            Icons.more_vert,
                                            size: 16.0,
                                          ),
                                        ),
                                        ListTile(
                                            dense: true,
                                            contentPadding: EdgeInsets.fromLTRB(
                                                40, 0, 0, 0),
                                            leading: SvgPicture.asset(
                                              "assets/icons/Phone.svg",
                                              color: Colors.grey,
                                              width: 22,
                                              height: 22,
                                            ),
                                            title: Text(
                                              pessoaController.pessoaModel
                                                          .pessoaTelefone !=
                                                      null
                                                  ? "${pessoaController.pessoaModel.pessoaTelefone}"
                                                  : "Telefone: ",
                                              style: TextStyle(
                                                //color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.0,
                                              ),
                                            )),
                                        ListTile(
                                          dense: true,
                                          contentPadding:
                                              EdgeInsets.fromLTRB(40, 0, 0, 0),
                                          leading: SvgPicture.asset(
                                            "assets/icons/Mail.svg",
                                            color: Colors.grey,
                                            width: 15,
                                            height: 15,
                                          ),
                                          title: Text(
                                            pessoaController.pessoaModel
                                                        .pessoaEmail !=
                                                    null
                                                ? "${pessoaController.pessoaModel.pessoaEmail}"
                                                : "E-mail: ",
                                            style: TextStyle(
                                              //color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15.0,
                                            ),
                                          ),
                                        ),
                                        ListTile(
                                          dense: true,
                                          contentPadding:
                                              EdgeInsets.fromLTRB(40, 0, 0, 0),
                                          leading: SvgPicture.asset(
                                            "assets/icons/doc.svg",
                                            color: Colors.grey,
                                            width: 22,
                                            height: 22,
                                          ),
                                          title: Text(
                                            pessoaController.pessoaModel
                                                        .pessoaCpf !=
                                                    null
                                                ? "${pessoaController.pessoaModel.pessoaCpf}"
                                                : "CPF: ",
                                            style: TextStyle(
                                              //color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15.0,
                                            ),
                                          ),
                                        ),
                                        ListTile(
                                            dense: true,
                                            isThreeLine: false,
                                            contentPadding: EdgeInsets.fromLTRB(
                                                40, 0, 0, 0),
                                            leading: SvgPicture.asset(
                                              "assets/icons/bolo aniversario.svg",
                                              color: Colors.grey,
                                              width: 22,
                                              height: 22,
                                            ),
                                            title: Observer(builder: (_) {
                                              return Text(
                                                pessoaController.pessoaModel
                                                            .pessoaDataNascimento !=
                                                        null
                                                    ? "${pessoaController.pessoaModel.pessoaDataNascimento}"
                                                    : "Aniversário: ",
                                                style: TextStyle(
                                                  //color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15.0,
                                                ),
                                              );
                                            }),
                                            trailing: FloatingActionButton(
                                              backgroundColor: Colors.blue,
                                              onPressed: () async {
                                                PessoaModel information =
                                                    await Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            fullscreenDialog:
                                                                true,
                                                            builder: (context) =>
                                                                ListaPessoa()));

                                                setState(() {
                                                  pessoaSelecionada =
                                                      information;
                                                });
                                              },
                                              child: Icon(Icons.search),
                                              tooltip: "Pesquisar",
                                            )),
                                      ],
                                    );
                                  }),
                                ],
                              )),
                          new Container(
                            padding: EdgeInsets.only(top: 25),
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(color: Color(0xfff1f1f1)),
                            child: Column(
                              children: <Widget>[
                                ListTile(
                                    leading: Text("Descrição:"),
                                    title: TextFormField(
                                      maxLines: 9,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                      initialValue: despesaController
                                          .despesaModel.despObservacao,
                                      style: TextStyle(
                                        //color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0,
                                      ),
                                      onChanged: (value) {
                                        despesaController.despesaModel
                                            .alteraDespdespObservacao(value);
                                      },
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: size.height * .84),
                    width: size.width,
                    height: size.height * 0.1,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent),
                      color: Colors.transparent.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: FlatButton(
                      child: Text(
                        "Salvar",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20,
                            backgroundColor: Colors.transparent),
                        textAlign: TextAlign.center,
                      ),
                      onPressed: () {},
                    ),
                  ))
            ])),
      )),
    );
  }
}
