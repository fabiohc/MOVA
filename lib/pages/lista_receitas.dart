import 'package:emanuellemepoupe/constants/constants_color.dart';
import 'package:emanuellemepoupe/controller/parcela_controller.dart';
import 'package:emanuellemepoupe/controller/receita_controller.dart';
import 'package:emanuellemepoupe/controller/util.dart';
import 'package:emanuellemepoupe/helperBD/receita_helperdb.dart';
import 'package:emanuellemepoupe/model/parcela_model.dart';
import 'package:emanuellemepoupe/model/receita_model.dart';
import 'package:emanuellemepoupe/pages/rotas.dart';
import 'package:emanuellemepoupe/widgets/navegacao.dart';
import 'package:emanuellemepoupe/widgets/receita_detalhes.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:emanuellemepoupe/widgets/despesa_detalhes.dart';

class ListaReceitas extends StatefulWidget {
  @override
  _ListaReceitasState createState() => _ListaReceitasState();
}

class _ListaReceitasState extends State<ListaReceitas> {
// #region Variaveis globais
  final receitaController = ReceitaController();
  final receitaHelper = ReceitaHelper();
  final parcelaController = ParcelaController();
  List<ReceitaModel> listaReceitasMesAtual = List();
  List<ReceitaModel> listaReceitas = List();
  var util = Util();
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  dynamic quantidadeDeMeses = [];
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
  var mesAnoGlobal;
// #endregion

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

  Future<Null> atualizeLista() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(
        Duration(seconds: 2),
        () => receitaController.obtentaListaReceitas().then((list) {
              setState(() {
                listaReceitas = list;
                quantidadeDeMeses =
                    receitaController.obtenhaQuantidadeDeMeses(listaReceitas);
                listaReceitasMesAtual =
                    util.obtenhaReceitasDoMesAtual(listaReceitas);
              });
            }));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
          Stack(
            children: [
              Container(
                  height: size.height * .27,
                  decoration: BoxDecoration(color: kBlueColor)),
              Row(
                children: [
                  BottomNavBar(
                    icon: SvgPicture.asset(
                      "assets/icons/Voltar ICon.svg",
                      color: Colors.white,
                    ),
                    margin: 10,
                    alignment: Alignment.bottomLeft,
                    // color: Colors.white.withOpacity(2),
                    press: () {
                      Navigator.of(context)
                          .pushNamed(RotasNavegacao.MENU_RECEITAS);
                    },
                    descricao: "LISTA DE RECEITAS",
                  ),
                ],
              ),
              Padding(
                padding:  EdgeInsets.only(top: size.height * 0.14),
                child: SizedBox(
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
                                      mesAnoGlobal = mesAno;
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
                                SizedBox(width: 10),
                                Divider(
                                  color: Colors.white,
                                  thickness: 20,
                                )
                              ],
                            ),
                          );
                        }),
                  ),
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(top: size.height * 0.19),
                child: Divider(),
              ),
              Padding(
               padding:  EdgeInsets.only(top: size.height * 0.21),
                child: SizedBox(
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
                                      listaReceitasMesAtual = receitaController
                                          .obtenhaRegistrosPorTipo(
                                              listaReceitas,
                                              categoria,
                                              mesAnoGlobal.toString());
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
              ),
            ],
          ),
          SizedBox(
              height: size.height * .72,
              child: RefreshIndicator(
                  onRefresh: atualizeLista,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: listaReceitasMesAtual.length,
                      itemBuilder: (context, index) {
                        final receita = listaReceitasMesAtual[index];
                        valorPago = receita.recStatusPag;
                        return Column(
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  activeColor: Colors.transparent,
                                  checkColor: Colors.greenAccent,
                                  value: valorPago,
                                  onChanged: (bool value) {
                                    if (value == true) {
                                      inserePagametnoFlushbar(receita);
                                    } else {
                                      removaPagamentoFlushbar(receita);
                                    }
                                  },
                                ),
                                Expanded(
                                    flex: 2, child: ReceitaDetalhes(receita)),
                                Expanded(
                                  child: Container(
                                      width: size.width * .5,
                                      color: Colors.transparent,
                                      child: SizedBox(
                                        width: size.width * 0.5,
                                        height: size.height * 0.1,
                                        child: Row(
                                          children: [
                                            if (receita.recServico != "Parcela")
                                              IconButton(
                                                icon: (SvgPicture.asset(
                                                  "assets/icons/editar.svg",
                                                  color: Colors.deepOrange,
                                                )),
                                                tooltip: "Editar",
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pushReplacementNamed(
                                                          RotasNavegacao
                                                              .EDITAR_DESPESA_RECEITA,
                                                          arguments: receita);
                                                },
                                              ),
                                            if (receita.recServico != "Parcela")
                                              IconButton(
                                                icon: (SvgPicture.asset(
                                                    "assets/icons/Trash.svg")),
                                                tooltip: "Remover",
                                                onPressed: () {
                                                  flushbarExcluir(
                                                      "Confirmar remoção?",
                                                      "Registro removido!",
                                                      receita);
                                                },
                                              ),
                                          ],
                                        ),
                                      )),
                                ),
                              ],
                            ),
                            Divider(color: Colors.white)
                          ],
                        );
                      })))
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

  Flushbar flushbarExcluir(String titleQuestione, String menssagemConfirmeAcao,
      ReceitaModel receita) {
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
                    Colors.red,
                    Colors.redAccent
                  ]), //duration: Duration(seconds: 3),
                )..show(context).then((value) {
                    receitaController.deleteRegistro(receita);
                    receitaController.obtentaListaReceitas().then((list) {
                      setState(() {
                        listaReceitas = list;
                        quantidadeDeMeses = receitaController
                            .obtenhaQuantidadeDeMeses(listaReceitas);
                        listaReceitasMesAtual =
                            util.obtenhaReceitasDoMesAtual(listaReceitas);
                      });
                    });
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
      backgroundGradient:
          LinearGradient(colors: [Colors.red, Colors.redAccent]),
    )..show(context);
  }

  inserePagametnoFlushbar(ReceitaModel receita) {
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
                flush.dismiss(true);
                Flushbar(
                  title: "Pronto!",
                  message: "Pagamento confirmado!",
                  margin: EdgeInsets.all(10),
                  borderRadius: 8,
                  duration: Duration(seconds: 2),
                  backgroundGradient: LinearGradient(colors: [
                    Colors.blue,
                    Colors.teal
                  ]), //duration: Duration(seconds: 3),
                )..show(context).then((value) {
                    setState(() {
                      valorPago = true;
                      receita.recStatusPag = valorPago;
                      receitaController.receitaModel = receita;
                      receitaController.atualizeReceita();
                    });
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
      backgroundGradient:
          LinearGradient(colors: [Colors.orange, Colors.orangeAccent]),
    )..show(context);
  }

  removaPagamentoFlushbar(ReceitaModel receita) {
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
                  receita.recStatusPag = valorPago;
                  receitaController.receitaModel = receita;
                  receita.recServico == "Parcela"
                      ? parcelaController
                          .atualizeStatusPagamentoParcela(receita)
                      : receitaController.atualizeReceita();
                });
                Flushbar(
                  title: "Pronto!",
                  message: "Pagamento removido!",
                  margin: EdgeInsets.all(10),
                  borderRadius: 8,
                  duration: Duration(seconds: 2),
                  backgroundGradient: LinearGradient(colors: [
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
      backgroundGradient:
          LinearGradient(colors: [Colors.orange, Colors.orangeAccent]),
    )..show(context);
  }
}
