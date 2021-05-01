import 'package:brasil_fields/brasil_fields.dart';
import 'package:emanuellemepoupe/constants/constants_color.dart';
import 'package:emanuellemepoupe/controller/despesa_controller.dart';
import 'package:emanuellemepoupe/controller/pessoa_controller.dart';
import 'package:emanuellemepoupe/controller/util.dart';
import 'package:emanuellemepoupe/model/pessoa_model.dart';
import 'package:emanuellemepoupe/pages/lista_pessoa.dart';
import 'package:emanuellemepoupe/pages/rotas.dart';
import 'package:emanuellemepoupe/controller/compartilhado_controller.dart';
import 'package:emanuellemepoupe/widgets/navegacao.dart';
import 'package:emanuellemepoupe/widgets/widget_tipo_pagamento.dart';
import 'package:emanuellemepoupe/controller/receita_controller.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CadastroDespesaReceita extends StatefulWidget {
  final String acao;
  final String descricaoServico;

  CadastroDespesaReceita({this.acao, this.descricaoServico});

  @override
  _CadastroDespesaReceitaState createState() => _CadastroDespesaReceitaState();
}

class _CadastroDespesaReceitaState extends State<CadastroDespesaReceita>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  final despesaController = DespesaController();
  final pessoaController = PessoaController();
  final receitaController = ReceitaController();
  final compartilhadoController = CompartilhadoController();
  var pessoaSelecionada = PessoaModel();
  var pessoaModel = PessoaModel();
  final Util _util = Util();

  bool radioDinheiro = true;
  bool radioDebito = true;
  bool radioctransfer = true;
  bool radioCredito = true;

  DateTime _dateTime = DateTime.now();
  int numeroParcela = 0;

  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    if (pessoaSelecionada != null)
      pessoaController.pessoaModel = pessoaSelecionada;
    var size = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SafeArea(
          child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Stack(children: <Widget>[
                Container(
                    height: size.height * .40,
                    decoration: BoxDecoration(
                        color: widget.acao == "pagar"
                            ? Color(0xFF6b011f)
                            : Color(0xFFF4a47a3))),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: BottomNavBar(
                        icon: SvgPicture.asset(
                          "assets/icons/Voltar ICon.svg",
                          color: Colors.white,
                        ),
                        descricao: widget.acao == "pagar"
                            ? despesaController.despesaModel
                                .alteraDespServico("${widget.descricaoServico}")
                            : receitaController.receitaModel
                                .alteraRecServico("${widget.descricaoServico}"),
                        margin: 10,
                        alignment: Alignment.bottomLeft,
                        press: () {
                          widget.acao == "pagar"
                              ? Navigator.of(context)
                                  .popAndPushNamed(RotasNavegacao.MENU_DESPESAS)
                              : Navigator.of(context).popAndPushNamed(
                                  RotasNavegacao.MENU_RECEITAS);
                        },
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: BottomNavBar(
                          icon: SvgPicture.asset(
                            "assets/icons/historico.svg",
                            color: Colors.white,
                            height: 20,
                            semanticsLabel: "Historico",
                          ),
                          margin: 10,
                          alignment: Alignment.bottomRight,
                          press: () {
                            widget.acao == "pagar"
                                ? Navigator.of(context).popAndPushNamed(
                                    RotasNavegacao.LISTA_DESPESAS)
                                : Navigator.of(context).popAndPushNamed(
                                    RotasNavegacao.LISTA_RECEITAS);
                          },
                        ))
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: size.height * .11),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 25),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            child: Text(
                              "Qual valor deseja ${widget.acao}?",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * .03),
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
                                  textInputAction: TextInputAction.next,
                                  autofocus: false,
                                  keyboardType: TextInputType.numberWithOptions(
                                      decimal: true),
                                  initialValue: widget.acao == "pagar"
                                      ? despesaController.despesaModel.despValor
                                      : receitaController.receitaModel.recValor,
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
                                    widget.acao == "pagar"
                                        ? despesaController.despesaModel
                                            .alteraDespValor(value)
                                        : receitaController.receitaModel
                                            .alteraRecValor(value);
                                  },
                                );
                              },
                            )),
                      ]),
                      SizedBox(height: 15),
                      Container(
                        child: Row(
                          children: [
                            SizedBox(
                                height: 30,
                                width: size.width * .4,
                                child: ValueListenableBuilder(
                                  valueListenable:
                                      compartilhadoController.dataVencimento,
                                  builder: (context, value, child) {
                                    return TextFormField(
                                      controller: new TextEditingController(
                                          text: widget.acao == "pagar"
                                              ? despesaController.despesaModel
                                                  .alteraDespData(
                                                      _util.formatData(
                                                          compartilhadoController
                                                              .dataVencimento
                                                              .value
                                                              .toString()))
                                              : receitaController.receitaModel
                                                  .alteraRecData(
                                                      _util.formatData(
                                                          compartilhadoController
                                                              .dataVencimento
                                                              .value
                                                              .toString()))),
                                      autofocus: false,
                                      keyboardType:
                                          TextInputType.numberWithOptions(
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
                                      onChanged: (value) {
                                        widget.acao == "pagar"
                                            ? despesaController.despesaModel
                                                .alteraDespData(value)
                                            : receitaController.receitaModel
                                                .alteraRecData(value);
                                      },
                                    );
                                  },
                                )),
                            IconButton(
                                icon: Icon(Icons.calendar_today),
                                color: Colors.white,
                                onPressed: () async {
                                  final dtpkr = await showDatePicker(
                                    context: context,
                                    initialDate: new DateTime.now(),
                                    firstDate: new DateTime(2000),
                                    lastDate: new DateTime(2100),
                                  );
                                  if (dtpkr != null && dtpkr != _dateTime) {
                                    compartilhadoController
                                        .alteraDataVenvimento(dtpkr);
                                    widget.acao == "pagar"
                                        ? despesaController.despesaModel
                                            .alteraDespData(_util
                                                .formatData(dtpkr.toString()))
                                        : receitaController.receitaModel
                                            .alteraRecData(_util
                                                .formatData(dtpkr.toString()));
                                  }
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
                              icon: SvgPicture.asset(
                                  "assets/icons/pagamento.svg",
                                  color: Colors.grey,
                                  height: 30,
                                  semanticsLabel: 'Pagamentos'),
                              // text: 'Pagamento',
                            ),
                            new Tab(
                              icon: SvgPicture.asset(
                                  "assets/icons/User Icon.svg",
                                  color: Colors.grey,
                                  height: 28,
                                  semanticsLabel: 'Clientes'),
                              // text: 'Cliente',
                            ),
                            new Tab(
                              icon: SvgPicture.asset(
                                  "assets/icons/descricao.svg",
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
                                  radio: Radio(
                                    groupValue: false,
                                    value: radioDinheiro,
                                    onChanged: (bool value) {
                                      setState(() {
                                        widget.acao == "pagar"
                                            ? despesaController.despesaModel
                                                .alteraDespFormaPagamento(
                                                    "Dinheiro")
                                            : receitaController.receitaModel
                                                .alteraRecFormaPagamento(
                                                    "Dinheiro");
                                        radioDinheiro = false;
                                        radioDebito = true;
                                        radioctransfer = true;
                                        radioCredito = true;
                                      });
                                    },
                                  ),
                                ),
                                Container(
                                  color: kBackgroundColor,
                                  child: ExpansionTile(
                                    backgroundColor: kBackgroundColor,
                                    leading: Container(
                                      width: size.width * .22,
                                      child: Row(
                                        children: [
                                          Radio(
                                            groupValue: false,
                                            value: radioCredito,
                                            onChanged: (bool value) {
                                              setState(() {
                                                if (widget.acao == "pagar") {
                                                  despesaController.despesaModel
                                                      .alteraDespFormaPagamento(
                                                          "Cartão");
                                                  despesaController.despesaModel
                                                      .alteraDespTipoCartao(
                                                          "Crédito");
                                                } else {
                                                  receitaController.receitaModel
                                                      .alteraRecFormaPagamento(
                                                          "Cartão");
                                                  receitaController.receitaModel
                                                      .alteraRecTipoCartao(
                                                          "Crédito");
                                                }
                                                radioCredito = false;
                                                radioctransfer = true;
                                                radioDinheiro = true;
                                                radioDebito = true;
                                              });
                                            },
                                          ),
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
                                              SizedBox(
                                                  height: size.height * 0.01),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  FloatingActionButton(
                                                      mini: true,
                                                      child: Icon(
                                                          Icons
                                                              .exposure_neg_1_sharp,
                                                          color:
                                                              Colors.black87),
                                                      backgroundColor:
                                                          Colors.white,
                                                      onPressed: () {
                                                        setState(() {
                                                          compartilhadoController
                                                              .decrementeNumeroParcela();
                                                          widget.acao == "pagar"
                                                              ? despesaController
                                                                  .despesaModel
                                                                  .alteraDespNumeroParcelas(
                                                                      compartilhadoController
                                                                          .numeroParcela
                                                                          .value)
                                                              : receitaController
                                                                  .receitaModel
                                                                  .alteraRecNumeroParcelas(
                                                                      compartilhadoController
                                                                          .numeroParcela
                                                                          .value);
                                                        });
                                                      }),
                                                  Container(
                                                    child:
                                                        ValueListenableBuilder(
                                                            valueListenable:
                                                                compartilhadoController
                                                                    .numeroParcela,
                                                            builder: (context,
                                                                value, child) {
                                                              numeroParcela =
                                                                  value;
                                                              return Text(
                                                                '$value',
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      30.0,
                                                                ),
                                                              );
                                                            }),
                                                  ),
                                                  FloatingActionButton(
                                                      mini: true,
                                                      child: Icon(
                                                          Icons
                                                              .exposure_plus_1_sharp,
                                                          color:
                                                              Colors.black87),
                                                      backgroundColor:
                                                          Colors.white,
                                                      onPressed: () {
                                                        setState(() {
                                                          compartilhadoController
                                                              .incrementeNumeroParcela();
                                                          widget.acao == "pagar"
                                                              ? despesaController
                                                                  .despesaModel
                                                                  .alteraDespNumeroParcelas(
                                                                      compartilhadoController
                                                                          .numeroParcela
                                                                          .value)
                                                              : receitaController
                                                                  .receitaModel
                                                                  .alteraRecNumeroParcelas(
                                                                      compartilhadoController
                                                                          .numeroParcela
                                                                          .value);
                                                        });
                                                      }),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                ValueListenableBuilder(
                                  valueListenable:
                                      compartilhadoController.radioButton,
                                  builder: (context, value, child) =>
                                      WidgetTipoPagamento(
                                    height: 0.17,
                                    descricao: 'CARTÃO DÉBITO',
                                    caminhoIconSvg: "assets/icons/debito.svg",
                                    color: kBlueLightColor,
                                    radio: Radio(
                                      groupValue: false,
                                      value: radioDebito,
                                      onChanged: (bool value) {
                                        setState(() {
                                          if (widget.acao == "pagar") {
                                            despesaController.despesaModel
                                                .alteraDespFormaPagamento(
                                                    "Cartão");
                                            despesaController.despesaModel
                                                .alteraDespTipoCartao("Débito");
                                          } else {
                                            receitaController.receitaModel
                                                .alteraRecFormaPagamento(
                                                    "Cartão");
                                            receitaController.receitaModel
                                                .alteraRecTipoCartao("Débito");
                                          }
                                          radioDebito = false;
                                          radioDinheiro = true;
                                          radioctransfer = true;
                                          radioCredito = true;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                WidgetTipoPagamento(
                                  height: 0.17,
                                  descricao: 'TRANSFERÊNCIA',
                                  caminhoIconSvg:
                                      "assets/icons/transferencia.svg",
                                  color: kShadowColor,
                                  radio: Radio(
                                    groupValue: false,
                                    value: radioctransfer,
                                    onChanged: (bool value) {
                                      setState(() {
                                        if (widget.acao == "pagar") {
                                          despesaController.despesaModel
                                              .alteraDespFormaPagamento(
                                                  "Transferência");
                                        } else {
                                          receitaController.receitaModel
                                              .alteraRecFormaPagamento(
                                                  "Transferência");
                                        }
                                        radioctransfer = false;
                                        radioDinheiro = true;
                                        radioDebito = true;
                                        radioCredito = true;
                                      });
                                    },
                                  ),
                                ),
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
                                            contentPadding: EdgeInsets.fromLTRB(
                                                17, 0, 0, 0),
                                            leading: Container(
                                                width: 60.0,
                                                height: 60.0,
                                                color: Colors.transparent,
                                                child: pessoaController
                                                            .pessoaModel
                                                            .pessoafotourl ==
                                                        null
                                                    ? CircleAvatar(
                                                        child: SvgPicture.asset(
                                                            "assets/icons/Image foto.svg"),
                                                        backgroundColor:
                                                            Colors.white,
                                                      )
                                                    : CircleAvatar(
                                                        backgroundImage:
                                                            NetworkImage(
                                                                pessoaController
                                                                    .pessoaModel
                                                                    .pessoafotourl),
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
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
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
                                            contentPadding: EdgeInsets.fromLTRB(
                                                40, 0, 0, 0),
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
                                            contentPadding: EdgeInsets.fromLTRB(
                                                40, 0, 0, 0),
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
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
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
                                                              builder:
                                                                  (context) =>
                                                                      ListaPessoa(
                                                                        retonarcadastro:
                                                                            true,
                                                                      )));

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
                              decoration:
                                  BoxDecoration(color: Color(0xfff1f1f1)),
                              child: Column(
                                children: <Widget>[
                                  ListTile(
                                      title: TextFormField(
                                    maxLines: 9,
                                    maxLength: 250,
                                    decoration: InputDecoration(
                                      hintStyle: TextStyle(fontSize: 20),
                                      hintText: "Descrição (250 caracteres.)",
                                      border: InputBorder.none,
                                    ),
                                    initialValue: despesaController
                                        .despesaModel.despObservacao,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0,
                                    ),
                                    onChanged: (value) {
                                      widget.acao == "pagar"
                                          ? despesaController.despesaModel
                                              .alteraDespObservacao(value)
                                          : receitaController.receitaModel
                                              .alteraRecObservacao(value);
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
                        onPressed: () {
                          flushbarIncluir("Confirmar inclusão?",
                              " Registro salvo com sucesso!");
                        },
                      ),
                    ))
              ]))),
    );
  }

  Flushbar flushbarIncluir(String titleQuestione, String menssagemConfirmeAcao,
      {dynamic objetoReceitaDespesa}) {
    Flushbar flush;
    return flush = Flushbar<bool>(
      title: titleQuestione,
      message: " ",
      margin: EdgeInsets.all(10),
      borderRadius: 8,
      isDismissible: true,
      mainButton: Row(
        children: [
          FlatButton(
              onPressed: () {
                flush.dismiss(false);
              },
              child: Text(
                "Não",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              )),
          FlatButton(
              onPressed: () {
                flush.dismiss(true);
                return flush = Flushbar<bool>(
                  title: "Pronto!",
                  message: menssagemConfirmeAcao,
                  margin: EdgeInsets.all(10),
                  borderRadius: 8,
                  duration: Duration(seconds: 3),
                  backgroundGradient: LinearGradient(colors: [
                    Colors.blue,
                    Colors.teal
                  ]), //duration: Duration(seconds: 3),
                )..show(context).then((value) {
                    if (widget.acao == "pagar") {
                      despesaController.despesaModel
                          .alteradespPessoaIdVinculado(
                              pessoaController.pessoaModel.pessoaIdGlobal);
                      despesaController.despesaModel
                          .alteraDespPessoaModel(pessoaController.pessoaModel);
                      despesaController.insiraNovaDespesa();

                      Navigator.of(context).pop();
                      Navigator.pushReplacementNamed(
                          context, RotasNavegacao.LISTA_DESPESAS);
                    } else {
                      receitaController.receitaModel.alteraRecPessoaIdVinculado(
                          pessoaController.pessoaModel.pessoaIdGlobal);
                      receitaController.receitaModel
                          .alteraRecPessoaModel(pessoaController.pessoaModel);
                      receitaController.insiraNovaReceita();

                      Navigator.of(context).pop();
                      Navigator.pushReplacementNamed(
                          context, RotasNavegacao.LISTA_RECEITAS);
                    }
                  });
              },
              child: Text(
                "Sim",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              )),
        ],
      ),
      backgroundGradient: LinearGradient(colors: [Colors.blue, Colors.teal]),
    )..show(context);
  }
}
