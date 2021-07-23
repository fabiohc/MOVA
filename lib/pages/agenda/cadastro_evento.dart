import 'package:brasil_fields/brasil_fields.dart';
import 'package:emanuellemepoupe/controller/agenda_controller.dart';
import 'package:emanuellemepoupe/controller/compartilhado_controller.dart';
import 'package:emanuellemepoupe/controller/pessoa_controller.dart';
import 'package:emanuellemepoupe/controller/util.dart';
import 'package:emanuellemepoupe/model/pessoa_model.dart';
import 'package:emanuellemepoupe/model/agenda_model.dart';
import 'package:emanuellemepoupe/pages/cliente/lista_pessoa.dart';
import 'package:emanuellemepoupe/pages/rotas.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';

class CadastroEvento extends StatefulWidget {
  @override
  _CadastroEventoState createState() => _CadastroEventoState();
}

class _CadastroEventoState extends State<CadastroEvento>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  final agendaController = new AgendaController();
  final agendaModel = new AgendaModel();
  final compartilhadoController = CompartilhadoController();
  final pessoaController = PessoaController();
  var pessoaSelecionada = PessoaModel();
  DateTime _dateTime = DateTime.now();
  final Util _util = Util();

  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    if (pessoaSelecionada != null)
      pessoaController.pessoaModel = pessoaSelecionada;
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Color(0xFFF4a47a3),
            iconTheme: IconThemeData(color: Colors.white),
            elevation: 0.0,
            brightness: Brightness.dark,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  onPressed: () =>
                      Navigator.of(context).pushNamed(RotasNavegacao.AGENDA),
                  icon: SvgPicture.asset(
                    "assets/icons/Voltar ICon.svg",
                    color: Colors.amber,
                  ),
                ),
                // Your widgets here
              ],
            )),
        body: SingleChildScrollView(
          child: Wrap(
            children: [
              Stack(
                children: [
                  Container(
                    color: Color(0xFFF4a47a3),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ValueListenableBuilder(
                            valueListenable: agendaController.tituloEvento,
                            builder: (context, value, child) {
                              return TextFormField(
                                textInputAction: TextInputAction.next,
                                autofocus: false,
                                keyboardType: TextInputType.text,
                                maxLines: 1,
                                 maxLengthEnforcement: MaxLengthEnforcement.enforced,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(40),
                                ],
                                initialValue: agendaController.agendaModel !=
                                        null
                                    ? agendaController.agendaModel.agenDescricao
                                    : agendaController.tituloEvento,
                                
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(
                                      fontSize: 15, color: Colors.grey),
                                  hintText: "Título do evento",
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(4.0),
                                  labelStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                ),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (String value) {
                                  return agendaController.valideTitulo();
                                },
                                onChanged: (value) {
                                  agendaController.agendaModel
                                      .alteraAgenTitulo(value);
                                },
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          width: size.width * .92,
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 3,
                                  child: ValueListenableBuilder(
                                    valueListenable:
                                        compartilhadoController.dataVencimento,
                                    builder: (context, value, child) {
                                      return TextFormField(
                                        textInputAction: TextInputAction.next,
                                        controller: new TextEditingController(
                                            text: agendaController.agendaModel
                                                .alteraAgenDataInicio(
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
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                          DataInputFormatter()
                                        ],
                                        decoration: InputDecoration(
                                          hintStyle: TextStyle(
                                              fontSize: 15, color: Colors.grey),
                                          hintText: "Data do evento",
                                          border: InputBorder.none,
                                        ),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15.0,
                                        ),
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        validator: (String value) {
                                          return agendaController.valideData();
                                        },
                                        onChanged: (value) {
                                          agendaController.agendaModel
                                              .alteraAgenDataInicio(
                                                  _util.formatData(value));
                                        },
                                      );
                                    },
                                  )),
                              Expanded(
                                  flex: 4,
                                  child: IconButton(
                                      icon: Icon(Icons.calendar_today),
                                      color: Colors.white,
                                      onPressed: () async {
                                        final dtpkr = await showDatePicker(
                                          context: context,
                                          initialDate: new DateTime.now(),
                                          firstDate: new DateTime(1500),
                                          lastDate: new DateTime(2100),
                                        );
                                        if (dtpkr != null &&
                                            dtpkr != _dateTime) {
                                          compartilhadoController
                                              .alteraDataVenvimento(dtpkr);
                                        }
                                      })),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: size.width * .92,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(
                                  "Inicia as ",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              Expanded(
                                  flex: 2,
                                  child: ValueListenableBuilder(
                                    valueListenable:
                                        agendaController.horaInicio,
                                    builder: (context, value, child) {
                                      return TextFormField(
                                        textInputAction: TextInputAction.next,
                                        autofocus: false,
                                        keyboardType:
                                            TextInputType.numberWithOptions(
                                                decimal: true),
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                          HoraInputFormatter()
                                        ],
                                        decoration: InputDecoration(
                                          hintStyle: TextStyle(
                                              fontSize: 15, color: Colors.grey),
                                          hintText: "00:00 ",
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.all(4.0),
                                          labelStyle: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        ),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15,
                                        ),
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        validator: (value) {
                                          return agendaController
                                              .valideHoraInicio();
                                        },
                                        onChanged: (value) {
                                          agendaController.agendaModel
                                              .alteraAgenDataInicio(value);
                                          agendaController
                                              .mudahoraInicio(value);
                                        },
                                      );
                                    },
                                  )),
                              Expanded(
                                flex: 3,
                                child: Text(
                                  "Encerra as ",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              Expanded(
                                  flex: 2,
                                  child: ValueListenableBuilder(
                                    valueListenable: agendaController.horaFim,
                                    builder: (context, value, child) {
                                      return TextFormField(
                                        textInputAction: TextInputAction.next,
                                        autofocus: false,
                                        keyboardType:
                                            TextInputType.numberWithOptions(
                                                decimal: true),
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                          HoraInputFormatter()
                                        ],
                                        decoration: InputDecoration(
                                          hintStyle: TextStyle(
                                              fontSize: 15, color: Colors.grey),
                                          hintText: "00:00 ",
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.all(4.0),
                                          labelStyle: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        ),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15,
                                        ),
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        validator: (value) {
                                          return agendaController
                                              .valideHoraFim();
                                        },
                                        onChanged: (value) {
                                          agendaController.mudahoraFim(value);
                                        },
                                      );
                                    },
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: size.width * .92,
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 3,
                                  child: Text(
                                    "Dia todo",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  )),
                              Expanded(
                                  flex: 0,
                                  child: Text(
                                    "Não",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  )),
                              Expanded(
                                  flex: 2,
                                  child: ValueListenableBuilder(
                                      valueListenable:
                                          agendaController.switchDiatodo,
                                      builder: (context, value, child) {
                                        return SwitchListTile(
                                          selected: true,
                                          activeColor: Colors.green,
                                          dense: true,
                                          value: value,
                                          onChanged: (bool value) {
                                            agendaController
                                                .mudaswitchDiatodo(value);
                                            agendaController.agendaModel
                                                .alteraAgenDiaTodo(value);
                                          },
                                        );
                                      })),
                              Expanded(
                                  flex: 1,
                                  child: Text(
                                    "Sim",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: size.width * .92,
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 3,
                                  child: Text(
                                    "Concluído",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  )),
                              Expanded(
                                  flex: 0,
                                  child: Text(
                                    "Não",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  )),
                              Expanded(
                                  flex: 2,
                                  child: ValueListenableBuilder(
                                      valueListenable:
                                          agendaController.switchConcluido,
                                      builder: (context, value, child) {
                                        return SwitchListTile(
                                          selected: true,
                                          activeColor: Colors.green,
                                          dense: true,
                                          value: value,
                                          onChanged: (bool value) {
                                            agendaController
                                                .mudaswitchConcluido(value);
                                            agendaController.agendaModel
                                                .alteraAgenEventoAtivo(value);
                                          },
                                        );
                                      })),
                              Expanded(
                                  flex: 1,
                                  child: Text(
                                    "Sim",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                height: size.height * .59,
                child: ListView(
                  physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    new Container(
                      child: new TabBar(
                        controller: _controller,
                        tabs: [
                          new Tab(
                            icon: SvgPicture.asset("assets/icons/descricao.svg",
                                color: Colors.grey,
                                height: 28,
                                semanticsLabel: 'Clientes'),
                            // text: 'Cliente',
                          ),
                          new Tab(
                            icon: SvgPicture.asset("assets/icons/User Icon.svg",
                                color: Colors.grey,
                                height: 30,
                                semanticsLabel: 'Pagamentos'),
                            // text: 'Pagamento',
                          ),
                        ],
                      ),
                    ),
                    new Container(
                        height: size.height * .400,
                        width: size.width,
                        child:
                            new TabBarView(controller: _controller, children: <
                                Widget>[
                          new Container(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(color: Color(0xfff1f1f1)),
                            child: Wrap(
                              children: <Widget>[
                                ListTile(
                                    title: TextFormField(
                                  maxLines: 9,
                                  maxLength: 250,
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(fontSize: 15),
                                    hintText: "Descrição (250 caracteres.)",
                                    border: InputBorder.none,
                                  ),
                                  initialValue: agendaController
                                      .agendaModel.agenDescricao,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                  ),
                                  onChanged: (value) {
                                    agendaController.agendaModel
                                        .alteraAgenDescricao(value);
                                  },
                                )),
                              ],
                            ),
                          ),
                          new ListView(children: [
                            Container(
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
                                          ),
                                        ],
                                      );
                                    }),
                                    Positioned(
                                        right: 10.0,
                                        bottom: 10,
                                        child: FloatingActionButton(
                                          backgroundColor: Colors.blue,
                                          onPressed: () async {
                                            PessoaModel information =
                                                await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        fullscreenDialog: true,
                                                        builder: (context) =>
                                                            ListaPessoa(
                                                              retonarcadastro:
                                                                  true,
                                                            )));

                                            setState(() {
                                              pessoaSelecionada = information;
                                            });
                                          },
                                          child: Icon(Icons.search),
                                          tooltip: "Pesquisar",
                                        ))
                                  ],
                                )),
                          ]),
                        ])),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: size.width,
                          height: size.height * 0.1,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blueAccent),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Observer(builder: (_) {
                            return ElevatedButton(
                   
                              child: Text(
                                "Salvar",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 15,
                                    backgroundColor: Colors.transparent),
                                textAlign: TextAlign.center,
                              ),
                              onPressed: agendaController.isValid
                                  ? () {
                                      flushbarIncluir("Confirmar inclusão?",
                                          " Registro salvo com sucesso!");
                                    }
                                  : null,
                            );
                          }),
                        ))
                  ],
                ),
              ),
            ],
          ),
        ));
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
          TextButton(
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
          TextButton(
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
                    agendaController.agendaModel.alteraAgenPessoaIdVinculado(
                        pessoaController.pessoaModel.pessoaIdGlobal);

                    agendaController.insereEvento();

                    Navigator.of(context).pop();
                    Navigator.pushReplacementNamed(
                        context, RotasNavegacao.AGENDA);
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
