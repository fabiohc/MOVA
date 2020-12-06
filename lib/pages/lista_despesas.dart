import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:emanuellemepoupe/controller/despesa_controller.dart';
import 'package:emanuellemepoupe/controller/util.dart';
import 'package:emanuellemepoupe/helperBD/despesa_helperdb.dart';
import 'package:emanuellemepoupe/model/despesa_model.dart';
import 'package:emanuellemepoupe/model/parcela_model.dart';
import 'package:emanuellemepoupe/pages/rotas.dart';

class ListaDespesas extends StatefulWidget {
  @override
  _ListaDespesaState createState() => _ListaDespesaState();
}

class _ListaDespesaState extends State<ListaDespesas> {
  final despesaController = DespesaController();
  final despesaHelper = DespesaHelper();
  var util = Util();
  List<DespesaModel> listaDespesas = List();
  List<DespesaModel> listaDespesasMesAtual = List();
  dynamic quantidadeDeMeses;
  List<String> categorias = [
    "Todos",
    "Condominio",
    "Aluguel",
    "Energia",
    "Outros"
  ];

  bool valorPago = false;
  Flushbar flush;
  int selectedIndexTipo = 0;
  int selectedIndexMes = 0;

  @override
  void initState() {
    super.initState();
    despesaController.obtentaListaDespesas().then((list) {
      setState(() {
        listaDespesas = list;
        quantidadeDeMeses =
            despesaController.obtenhaQuantidadeDeMeses(listaDespesas);
        listaDespesasMesAtual = util.obtenhaDespesasDoMesAtual(listaDespesas);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text("Lista de despesas"),
          centerTitle: true,
          backgroundColor: Color(0XFFF92B7F),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            SizedBox(
              height: 40,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: quantidadeDeMeses.length,
                    itemBuilder: (context, index) {
                      final meses = quantidadeDeMeses[index];
                      return Container(
                        child: Row(
                          children: [
                            FlatButton(
                              onPressed: () {
                                setState(() {
                                  listaDespesasMesAtual =
                                      util.obtenhaRegistroDespesasPorMes(
                                          listaDespesas, meses.toString());
                                  selectedIndexMes = index;
                                  selectedIndexTipo = 0;
                                });
                              },
                              color: selectedIndexMes == index
                                  ? Colors.deepPurple[200]
                                  : Colors.transparent,
                              child: Text(
                                  util.formataDataMesAno(meses.toString())),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: BorderSide(color: Colors.white60)),
                            ),
                            SizedBox(width: 10)
                          ],
                        ),
                      );
                    }),
              ),
            ),
            Divider(),
            SizedBox(
              height: 40,
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categorias.length,
                    itemBuilder: (context, index) {
                      final categoria = categorias[index];
                      return Container(
                        child: Row(
                          children: [
                            FlatButton(
                              onPressed: () {
                                setState(() {
                                  listaDespesasMesAtual =
                                      despesaController.obtenhaRegistrosPorTipo(
                                          listaDespesas, categoria);
                                  selectedIndexTipo = index;
                                });
                              },
                              color: selectedIndexTipo == index
                                  ? Colors.deepPurple[200]
                                  : Colors.transparent,
                              child: Text(categorias[index]),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: BorderSide(color: Colors.white60)),
                            ),
                            SizedBox(width: 10)
                          ],
                        ),
                      );
                    }),
              ),
            ),
            SizedBox(
                height: size.height * .70,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: listaDespesasMesAtual.length,
                    itemBuilder: (context, index) {
                      final despesa = listaDespesasMesAtual[index];
                      valorPago = despesa.despesaStatusPag;
                      return Card(
                          child: Row(
                        children: [
                          Observer(builder: (_) {
                            return Checkbox(
                                value: valorPago,
                                onChanged: (bool value) {
                                  if (value == true) {
                                    flush = Flushbar<bool>(
                                      title: "Confirmar pagamento?",
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
                                                flush.dismiss(false);
                                                setState(() {
                                                  valorPago = true;
                                                  despesa.despesaStatusPag =
                                                      valorPago;
                                                  despesaController
                                                      .despesaModel = despesa;
                                                  despesaController
                                                      .atualizeDespesa();
                                                });
                                                Flushbar(
                                                  title: "Pronto!",
                                                  message:
                                                      "Pagamento confirmado!",
                                                  margin: EdgeInsets.all(10),
                                                  borderRadius: 8,
                                                  duration:
                                                      Duration(seconds: 2),
                                                  backgroundGradient:
                                                      LinearGradient(colors: [
                                                    Colors.blue,
                                                    Colors.teal
                                                  ]), //duration: Duration(seconds: 3),
                                                )..show(context);
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
                                      backgroundGradient: LinearGradient(
                                          colors: [
                                            Colors.orange,
                                            Colors.orangeAccent
                                          ]),
                                    )..show(context);
                                  } else {
                                    flush = Flushbar<bool>(
                                      title: "Remover pagamento?",
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
                                                flush.dismiss(false);
                                                setState(() {
                                                  valorPago = false;
                                                  despesa.despesaStatusPag =
                                                      valorPago;
                                                  despesaController
                                                      .despesaModel = despesa;
                                                  despesaController
                                                      .atualizeDespesa();
                                                });
                                                Flushbar(
                                                  title: "Pronto!",
                                                  message:
                                                      "Pagamento removido!",
                                                  margin: EdgeInsets.all(10),
                                                  borderRadius: 8,
                                                  duration:
                                                      Duration(seconds: 2),
                                                  backgroundGradient:
                                                      LinearGradient(colors: [
                                                    Colors.blue,
                                                    Colors.teal
                                                  ]), //duration: Duration(seconds: 3),
                                                )..show(context);
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
                                      backgroundGradient: LinearGradient(
                                          colors: [
                                            Colors.orange,
                                            Colors.orangeAccent
                                          ]),
                                    )..show(context);
                                  }
                                },
                                checkColor: Colors.green);
                          }),
                          InkWell(
                            onTap: () {
                              List<ParcelaModel> listaParcelas = List();
                              despesaController
                                  .obtentaListaDeParcelasPorId(
                                      despesa.despIdGlobal)
                                  .then((list) {
                                listaParcelas = list;
                                return showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return new SimpleDialog(
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.9,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.9,
                                          child: Observer(builder: (_) {
                                            return Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 1.0),
                                                    child: Align(
                                                        alignment: Alignment
                                                            .bottomRight,
                                                        child: IconButton(
                                                            icon: Icon(
                                                                Icons.cancel),
                                                            color: Colors.amber,
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            })),
                                                  ),
                                                  Expanded(
                                                    child: Card(
                                                      child: ListView.separated(
                                                        itemCount: listaParcelas
                                                            .length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          final parcela =
                                                              listaParcelas[
                                                                  index];
                                                          return ListTile(
                                                            title: Text(
                                                                "${parcela.parcelaNumero}ª Parcela"),
                                                            subtitle: Text(
                                                                "Valor: ${parcela.parcelaValor}  -  Data: ${parcela.parcelaData}"),
                                                          );
                                                        },
                                                        separatorBuilder:
                                                            (context, index) {
                                                          return Divider(
                                                              color: Colors
                                                                  .blueGrey);
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ]);
                                          }),
                                        )
                                      ],
                                    );
                                  },
                                );
                              });
                            },
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(left: 8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          despesa.despServico ?? "-",
                                          style: GoogleFonts.lato(
                                              textStyle: TextStyle(
                                                  color: Colors.pinkAccent),
                                              fontSize: 17.0,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.start,
                                        ),
                                        Text(
                                          "Data: ${despesa.despData} " ?? "-",
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.blueGrey[600]),
                                          textAlign: TextAlign.start,
                                        ),
                                        Text(
                                          "Valor: ${despesa.despValor.toString()} " ??
                                              "-",
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.blueGrey[600]),
                                          textAlign: TextAlign.start,
                                        ),
                                        if (despesa.despFormaPagamento !=
                                                null &&
                                            despesa.despFormaPagamento !=
                                                "null")
                                          Text(
                                            "Pago com: ${despesa.despFormaPagamento}" ??
                                                "-",
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.blueGrey[600]),
                                            textAlign: TextAlign.start,
                                          ),
                                        if (despesa.despTipoCartao != null &&
                                            despesa.despTipoCartao != "null")
                                          Text(
                                            "Cartão: ${despesa.despTipoCartao}" ??
                                                "-",
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.blueGrey[600]),
                                            textAlign: TextAlign.start,
                                          ),
                                        if (despesa.despNumeroParcelas !=
                                                null &&
                                            despesa.despNumeroParcelas > 0)
                                          Text(
                                            "Qtd parcelas: ${despesa.despNumeroParcelas}" ??
                                                "-",
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.blueGrey[600]),
                                            textAlign: TextAlign.start,
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Observer(builder: (_) {
                            return Row(
                              children: [
                                if (despesa.despObservacao != null &&
                                    despesa.despObservacao != "null")
                                  new IconButton(
                                      icon: Icon(Icons.speaker_notes_outlined),
                                      color: Colors.blueGrey,
                                      padding: EdgeInsets.all(0),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return new SimpleDialog(
                                              children: <Widget>[
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.3,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.3,
                                                  child: Observer(builder: (_) {
                                                    return Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          Align(
                                                            alignment: Alignment.bottomRight,
                                                            child: 
                                                           Padding(
                                                                    padding: const EdgeInsets
                                                                    .only(
                                                             
                                                                    ),
                                                                    child: IconButton(
                                                                icon: Icon(Icons.cancel),
                                                                color: Colors.amber,
                                                                onPressed: () {
                                                                  Navigator.of(context)
                                                                      .pop();
                                                                }),
                                                                  )),
                                                          Align(
                                                            alignment: Alignment.bottomLeft,
                                                            child: 
                                                        
                                                          Padding(
                                                              padding: const EdgeInsets
                                                                      .only(
                                                                  left:
                                                                      10.0),
                                                              child: Text(
                                                                  "Descrição"))),
                                                          Expanded(
                                                              child: Align(
                                                            alignment: Alignment
                                                                .topLeft,
                                                            child: Text(
                                                              "${despesa.despObservacao}",
                                                            ),
                                                          )),
                                                        ]);
                                                  }),
                                                )
                                              ],
                                            );
                                          },
                                        );
                                      }),
                                if (despesa.despServico != "Parcela")
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: IconButton(
                                        icon: Icon(Icons.edit),
                                        color: Colors.orange,
                                        padding: EdgeInsets.all(0),
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pushReplacementNamed(
                                                  RotasNavegacao.EDITARREGISTRO,
                                                  arguments: despesa);
                                        }),
                                  ),
                                if (despesa.despServico != "Parcela")
                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: Observer(builder: (_) {
                                        return IconButton(
                                            icon: Icon(Icons.delete),
                                            color: Colors.red,
                                            padding: EdgeInsets.all(0),
                                            onPressed: () {
                                              despesaController
                                                  .deleteRegistro(despesa);
                                              Flushbar(
                                                title: "Pronto!",
                                                message: "Registro removido.",
                                                margin: EdgeInsets.all(10),
                                                borderRadius: 8,
                                                backgroundGradient:
                                                    LinearGradient(colors: [
                                                  Colors.red,
                                                  Colors.redAccent
                                                ]),
                                                duration: Duration(seconds: 2),
                                              )..show(context);
                                              despesaController
                                                  .obtentaListaDespesas()
                                                  .then((list) {
                                                setState(() {
                                                  listaDespesas = list;
                                                  listaDespesasMesAtual = util
                                                      .obtenhaDespesasDoMesAtual(
                                                          listaDespesas);
                                                });
                                              });
                                            });
                                      }))
                              ],
                            );
                          }),
                        ],
                      ));
                    })),
          ],
        )),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blueAccent,
          child: Icon(
            Icons.home,
            color: Colors.white,
          ),
          mini: false,
          onPressed: () {
            Navigator.of(context).pushNamed(RotasNavegacao.HOME);
          },
        ));
  }
}
