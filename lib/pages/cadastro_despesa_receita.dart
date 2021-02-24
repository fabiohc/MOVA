import 'package:brasil_fields/brasil_fields.dart';
import 'package:emanuellemepoupe/constants/constants_color.dart';
import 'package:emanuellemepoupe/controller/despesa_controller.dart';
import 'package:emanuellemepoupe/controller/pessoa_controller.dart';
import 'package:emanuellemepoupe/controller/util.dart';
import 'package:emanuellemepoupe/model/pessoa_model.dart';
import 'package:emanuellemepoupe/pages/lista_pessoa.dart';
import 'package:emanuellemepoupe/pages/rotas.dart';
import 'package:emanuellemepoupe/widgets/expansion_tile_cartao_custom.dart';
import 'package:emanuellemepoupe/widgets/navegacao.dart';
import 'package:emanuellemepoupe/widgets/widget_tipo_pagamento.dart';
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
  var pessoaSelecionada = PessoaModel();
  var pessoaModel = PessoaModel();
  bool radioDinheiro = true;
  bool radioDebito = true;
  bool radioctransfer = true;
  bool radioCredito = true;
  Util _util = Util();
  DateTime _dateTime = DateTime.now();

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
      body: SafeArea(
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
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 70, vertical: 23),
                    child: Text(
                      "${widget.descricaoServico}",
                      style: TextStyle(color: Colors.white),
                    )),
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
                    widget.acao == "pagar"
                        ? Navigator.of(context)
                            .pushNamed(RotasNavegacao.LISTA_DESPESAS)
                        : Navigator.of(context)
                            .pushNamed(RotasNavegacao.LISTA_RECEITAS);
                  },
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
                      SizedBox(height: 15),
                      Container(
                        child: Row(
                          children: [
                            SizedBox(
                                height: 30,
                                width: size.width * .4,
                                child: ValueListenableBuilder(
                                  valueListenable:
                                      despesaController.dataVencimento,
                                  builder: (context, value, child) {
                                    return TextFormField(
                                      controller: new TextEditingController(
                                          text: _util.formatData(
                                              despesaController
                                                  .dataVencimento.value
                                                  .toString())),
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
                                      onChanged: (_valorServico) {
                                        despesaController.despesaModel
                                            .alteraDespValor(_valorServico);
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
                                    despesaController
                                        .alteraDataVenvimento(dtpkr);
                                    despesaController.despesaModel
                                        .alteraDespData(
                                            _util.formatData(dtpkr.toString()));
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
                                        radioDinheiro = false;
                                        radioDebito = true;
                                        radioctransfer = true;
                                        radioCredito = true;
                                      });
                                    },
                                  ),
                                ),
                                ExpansionTileCuston(
                                  radio: Radio(
                                    groupValue: false,
                                    value: radioCredito,
                                    onChanged: (bool value) {
                                      setState(() {
                                        radioCredito = false;
                                        radioctransfer = true;
                                        radioDinheiro = true;
                                        radioDebito = true;
                                      });
                                    },
                                  ),
                                ),
                                ValueListenableBuilder(
                                  valueListenable:
                                      despesaController.radioButton,
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
                              decoration:
                                  BoxDecoration(color: Color(0xfff1f1f1)),
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
              ]))),
    );
  }
}
