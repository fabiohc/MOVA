import 'package:emanuellemepoupe/constants/constants_color.dart';
import 'package:emanuellemepoupe/controller/parcela_controller.dart';
import 'package:emanuellemepoupe/controller/pessoa_controller.dart';
import 'package:emanuellemepoupe/widgets/navegacao.dart';
import 'package:emanuellemepoupe/widgets/despesa_detalhes.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:emanuellemepoupe/controller/despesa_controller.dart';
import 'package:emanuellemepoupe/controller/util.dart';
import 'package:emanuellemepoupe/helperBD/despesa_helperdb.dart';
import 'package:emanuellemepoupe/model/despesa_model.dart';
import 'package:emanuellemepoupe/pages/rotas.dart';

class ListaDespesas extends StatefulWidget {
  @override
  _ListaDespesaState createState() => _ListaDespesaState();
}

class _ListaDespesaState extends State<ListaDespesas> {
  final despesaController = DespesaController();
  final despesaHelper = DespesaHelper();
  final pessoaController = PessoaController();
  final parcelaController = ParcelaController();

  var util = Util();
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  List<DespesaModel> listaDespesas = List();
  List<DespesaModel> listaDespesasMesAtual = List();
  dynamic quantidadeDeMeses = [];

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
  bool carregamentoCompleto = false;

  @override
  void initState() {
    super.initState();
  despesaController.obtentaListaDespesas().then((list) {
      setState(() {
        listaDespesas = list;
        quantidadeDeMeses =
            despesaController.obtenhaQuantidadeDeMeses(listaDespesas);
        listaDespesasMesAtual = util.obtenhaDespesasDoMesAtual(listaDespesas);
        if (listaDespesasMesAtual != null) carregamentoCompleto = false;
      });
    });
    super.initState();
  }

  Future<Null> atualizeLista() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(
        Duration(seconds: 2),
        () => despesaController.obtentaListaDespesas().then((list) {
              setState(() {
                listaDespesas = list;
                quantidadeDeMeses =
                    despesaController.obtenhaQuantidadeDeMeses(listaDespesas);
                listaDespesasMesAtual =
                    util.obtenhaDespesasDoMesAtual(listaDespesas);
              });
            }));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            Stack(children: [
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
                          .popAndPushNamed(RotasNavegacao.MENU_DESPESAS);
                    },
                    descricao: "LISTA DE DESPESAS",
                  ),
                ],
              ),
              Padding(
               padding: EdgeInsets.only(top: size.height * 0.14),
                child: SizedBox(
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
              ),
              Padding(
                 padding: EdgeInsets.only(top: size.height * 0.19),
                child: Divider(),
              ),
              Padding(
               padding: EdgeInsets.only(top: size.height * 0.21),
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
                                      listaDespesasMesAtual = despesaController
                                          .obtenhaRegistrosPorTipo(
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
              )
            ]),
            carregamentoCompleto
                ? Container(
                    alignment: FractionalOffset.center,
                    child: CircularProgressIndicator(),
                  )
                : SizedBox(
                    height: size.height * .72,
                    child: RefreshIndicator(
                        onRefresh: atualizeLista,
                        child: ListView.builder(
                            
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: listaDespesasMesAtual.length,
                            itemBuilder: (context, index) {
                              final despesa = listaDespesasMesAtual[index];
                              valorPago = despesa.despesaStatusPag;
                              return Column(
                                children: [
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: valorPago,
                                        activeColor: Colors.transparent,
                                        checkColor: Colors.greenAccent,
                                        onChanged: (bool value) {
                                          if (value == true) {
                                            insiraPagametnoFlushbar(despesa);
                                          } else {
                                            removaPagamentoFlushbar(despesa);
                                          }
                                        },
                                      ),
                                      Expanded(
                                          flex: 2,
                                          child: DespesaDetalhes(despesa)),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          width: size.width * .5,
                                          color: Colors.transparent,
                                          child: SizedBox(
                                            width: size.width * 0.10,
                                            height: size.height * 0.1,
                                            child: Row(
                                              children: [
                                                if (despesa.despServico !=
                                                    "Parcela")
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
                                                              arguments:
                                                                  despesa);
                                                    },
                                                  ),
                                                if (despesa.despServico !=
                                                    "Parcela")
                                                  IconButton(
                                                    icon: (SvgPicture.asset(
                                                        "assets/icons/Trash.svg")),
                                                    tooltip: "Remover",
                                                    onPressed: () {
                                                      flushbarExcluir(
                                                          "Confirmar remoção?",
                                                          "Registro removido!",
                                                          despesa);
                                                    },
                                                  ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(color: Colors.white)
                                ],
                              );
                            }))),
          ],
        )),
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
      DespesaModel despesa) {
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
                )..show(context).then((value) async {
                 await despesaController.deleteRegistro(despesa);
                    despesaController.obtentaListaDespesas().then((list) {
                      setState(() {
                        listaDespesas = list;
                        quantidadeDeMeses = despesaController
                            .obtenhaQuantidadeDeMeses(listaDespesas);
                        listaDespesasMesAtual =
                            util.obtenhaDespesasDoMesAtual(listaDespesas);
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

  insiraPagametnoFlushbar(DespesaModel despesa) {
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
                  despesa.despesaStatusPag = valorPago;
                  despesaController.despesaModel = despesa;
                  //despesaController.parcelaModel = parcela;
                  despesa.despServico == "Parcela"
                      ? parcelaController
                          .atualizeStatusPagamentoParcela(despesa)
                      : despesaController.atualizeDespesa();
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

  removaPagamentoFlushbar(DespesaModel despesa) {
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
                  despesa.despesaStatusPag = valorPago;
                  despesaController.despesaModel = despesa;
                  despesa.despServico == "Parcela"
                      ? parcelaController
                          .atualizeStatusPagamentoParcela(despesa)
                      : despesaController.atualizeDespesa();
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
