import 'package:emanuellemepoupe/controller/util.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:emanuellemepoupe/controller/receita_controller.dart';
import 'package:emanuellemepoupe/helperBD/receita_helperdb.dart';
import 'package:emanuellemepoupe/model/parcela_model.dart';
import 'package:emanuellemepoupe/model/receita_model.dart';
import 'package:emanuellemepoupe/pages/rotas.dart';

class ListaReceitas extends StatefulWidget {
  @override
  _ListaReceitasState createState() => _ListaReceitasState();
}

class _ListaReceitasState extends State<ListaReceitas> {
  final receitaController = ReceitaController();
  final receitaHelper = ReceitaHelper();
  var util = Util();
  List<ReceitaModel> listaReceitasMesAtual = List();
  List<ReceitaModel> listaReceitas = List();
  dynamic quantidadeDeMeses;
  List<String> categorias = [
    "Todos",
    "BBGlow",
    "Cílios",
    "Desing sobrancelhas",
    "Micro fio a fio",
    "Limpeza de pele",
    "Peeling"
  ];
  bool valorPago = false;
  Flushbar flush;
  int selectedIndexTipo = 0;
  int selectedIndexMes = 0;

  @override
  void initState() {
    super.initState();
    receitaController.obtentaListaReceitas().then((list) {
      setState(() {
        listaReceitas = list;
        quantidadeDeMeses =
            receitaController.obtenhaQuantidadeDeMeses(listaReceitas);
        listaReceitasMesAtual = util.obtenhaReceitasDoMesAtual(listaReceitas);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text("Lista de Receitas"),
          centerTitle: true,
          backgroundColor: Color(0xFF222B45),
        ),
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
          SizedBox(
            height: 40,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: quantidadeDeMeses.length,
                  itemBuilder: (context, index) {
                    var mesAno = quantidadeDeMeses[index];
                    final meses = quantidadeDeMeses[index];
                    return Container(
                      child: Row(
                        children: [
                          FlatButton(
                            onPressed: () {
                              setState(() {
                                listaReceitasMesAtual =
                                    util.obtenhaRegistroReceitasPorMes(
                                        listaReceitas, mesAno.toString());
                                selectedIndexMes = index;
                                selectedIndexTipo = 0;
                              });
                            },
                            color: selectedIndexMes == index
                                ? Colors.deepPurple[200]
                                : Colors.transparent,
                            child:
                                Text(util.formataDataMesAno(meses.toString())),
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
              padding: const EdgeInsets.all(8.0),
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
                                listaReceitasMesAtual =
                                    receitaController.obtenhaRegistrosPorTipo(
                                        listaReceitas, categoria);
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
                  }
                  
                  ),
            ),
          ),
          SizedBox(
              height:size.height * .70,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: listaReceitasMesAtual.length,
                  itemBuilder: (context, index) {
                    final receita = listaReceitasMesAtual[index];
                    valorPago = receita.recStatusPag;
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
                                                receita.recStatusPag =
                                                    valorPago;
                                                receitaController.receitaModel =
                                                    receita;
                                                receitaController
                                                    .atualizeReceita();
                                              });
                                              Flushbar(
                                                title: "Pronto!",
                                                message:
                                                    "Pagamento confirmado!",
                                                margin: EdgeInsets.all(10),
                                                borderRadius: 8,
                                                duration: Duration(seconds: 2),
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
                                    backgroundGradient: LinearGradient(colors: [
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
                                                receita.recStatusPag =
                                                    valorPago;
                                                receitaController.receitaModel =
                                                    receita;
                                                receitaController
                                                    .atualizeReceita();
                                              });
                                              Flushbar(
                                                title: "Pronto!",
                                                message: "Pagamento removido!",
                                                margin: EdgeInsets.all(10),
                                                borderRadius: 8,
                                                duration: Duration(seconds: 2),
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
                                    backgroundGradient: LinearGradient(colors: [
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
                            receitaController
                                .obtentaListaDeParcelasPorId(
                                    receita.recIdGlobal)
                                .then((list) {
                              listaParcelas = list;
                              return showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return new SimpleDialog(
                                    children: <Widget>[
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                        height:
                                            MediaQuery.of(context).size.height *
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
                                                      alignment:
                                                          Alignment.bottomRight,
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
                                                      itemCount:
                                                          listaParcelas.length,
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
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start, //Alinha conteúdo da esqueda para diréita
                                    children: <Widget>[
                                      Text(
                                        receita.recServico ?? "-",
                                        style: GoogleFonts.lato(
                                            textStyle: TextStyle(
                                                color: Colors.pinkAccent),
                                            fontSize: 17.0,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.start,
                                      ),
                                      Text(
                                        "Data: ${receita.recData} " ?? "-",
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.blueGrey[600]),
                                        textAlign: TextAlign.start,
                                      ),
                                      Text(
                                        "Valor: ${receita.recValor.toString()} " ??
                                            "-",
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.blueGrey[600]),
                                        textAlign: TextAlign.start,
                                      ),
                                      if (receita.recFormaPagamento != null)
                                        Text(
                                          "Pago com: ${receita.recFormaPagamento}" ??
                                              "-",
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.blueGrey[600]),
                                          textAlign: TextAlign.start,
                                        ),
                                      if (receita.recTipoCartao != null)
                                        Text(
                                          "Cartão: ${receita.recTipoCartao}" ??
                                              "-",
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.blueGrey[600]),
                                          textAlign: TextAlign.start,
                                        ),
                                      if (receita.recNumeroParcelas != null &&
                                          receita.recNumeroParcelas > 0)
                                        Text(
                                          "Qtd parcelas: ${receita.recNumeroParcelas}" ??
                                              "-",
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.blueGrey[600]),
                                          textAlign: TextAlign.start,
                                        ),
                                    ],
                                  ),
                                ),


                                Observer(builder: (_) {
                                  return Row(
                                    children: [
                                      /*FlatButton(
            onPressed: () {
              Card(child: InkWell(
            onTap: () {
              return showDialog(
            context: context,
            builder:
              (BuildContext context) {
            return new SimpleDialog(
              children: <Widget>[
                Container(
                    width: MediaQuery.of(
                  context)
                  .size
                  .width *
                  0.9,
                    height: MediaQuery.of(
                  context)
                  .size
                  .height *
                  0.9,
                    child: Card(
                      child: Row(
                  children: <
                  Widget>[
                    Text(
                    "sdfad")
                  ],
                      ),
                    ))
              ],
            );
            });
            },
              ));
            },
            child: Text(
              "Obs.",
              style: TextStyle(
              fontSize: 16.0,
              color: Colors.blueAccent),
              textAlign: TextAlign.start,
            )),*/
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: IconButton(
                                              icon: Icon(Icons.edit),
                                              color: Colors.orange,
                                              padding: EdgeInsets.all(0),
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pushReplacementNamed(
                                                        RotasNavegacao
                                                            .EDITARRECEITA,
                                                        arguments: receita);
                                              })),
                                      Align(
                                          alignment: Alignment.centerRight,
                                          child: Observer(builder: (_) {
                                            return IconButton(
                                                icon: Icon(Icons.delete),
                                                color: Colors.red,
                                                padding: EdgeInsets.all(0),
                                                onPressed: () {
                                                  receitaController
                                                      .deleteRegistro(receita);
                                                  Flushbar(
                                                    title: "Pronto!",
                                                    message:
                                                        "Registro removido.",
                                                    margin: EdgeInsets.all(10),
                                                    borderRadius: 8,
                                                    backgroundGradient:
                                                        LinearGradient(colors: [
                                                      Colors.red,
                                                      Colors.redAccent
                                                    ]),
                                                    duration:
                                                        Duration(seconds: 2),
                                                  )..show(context);
                                                  receitaController
                                                      .obtentaListaReceitas()
                                                      .then((list) {
                                                    setState(() {
                                                      listaReceitas = list;
                                                      listaReceitasMesAtual = util
                                                          .obtenhaReceitasDoMesAtual(
                                                              listaReceitas);
                                                    });
                                                  });
                                                });
                                          }))
                                    ],
                                  );
                                })
                              ],
                            ),
                          ),
                        ),
                      ],
                    ));
                  }))
        ])),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
