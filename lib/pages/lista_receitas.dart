import 'package:emanuellemepoupe/constants/constants_color.dart';
import 'package:emanuellemepoupe/controller/receita_controller.dart';
import 'package:emanuellemepoupe/controller/util.dart';
import 'package:emanuellemepoupe/helperBD/receita_helperdb.dart';
import 'package:emanuellemepoupe/model/parcela_model.dart';
import 'package:emanuellemepoupe/model/receita_model.dart';
import 'package:emanuellemepoupe/pages/rotas.dart';
import 'package:emanuellemepoupe/widgets/navegacao.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ListaReceitas extends StatefulWidget {
  final bool ehReceita = true;
  final String tipoLista;

  ListaReceitas({this.tipoLista});

  @override
  _ListaReceitasState createState() => _ListaReceitasState();
}

class _ListaReceitasState extends State<ListaReceitas> {
  final receitaController = ReceitaController();
  final receitaHelper = ReceitaHelper();
  var util = Util();
  List<ReceitaModel> listaReceitasMesAtual = List();
  List<ReceitaModel> listaReceitas = List();
  var refreshKey = GlobalKey<RefreshIndicatorState>();
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
  var mesAnoGlobal;

  @override
  void initState() {
    super.initState();
    if (widget.ehReceita) {
      receitaController.obtentaListaReceitas().then((list) {
        setState(() {
          listaReceitas = list;
          quantidadeDeMeses =
              receitaController.obtenhaQuantidadeDeMeses(listaReceitas);
          listaReceitasMesAtual = util.obtenhaReceitasDoMesAtual(listaReceitas);
        });
      });
    } else {}

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
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Container(
                        child: Text(
                      "Lista de receitas",
                      style: TextStyle(color: Colors.white),
                    )),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 85),
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
                                      if (widget.ehReceita) {
                                        listaReceitasMesAtual =
                                            util.obtenhaRegistroReceitasPorMes(
                                                listaReceitas,
                                                mesAno.toString());
                                        selectedIndexMes = index;
                                        selectedIndexTipo = 0;
                                        mesAnoGlobal = mesAno;
                                      } else {}
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
                padding: const EdgeInsets.only(top: 117),
                child: Divider(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 125),
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
                                      if (widget.ehReceita) {
                                        listaReceitasMesAtual =
                                            receitaController
                                                .obtenhaRegistrosPorTipo(
                                                    listaReceitas,
                                                    categoria,
                                                    mesAnoGlobal.toString());
                                        selectedIndexTipo = index;
                                      } else {}
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
                        return Card(
                            child: Row(
                          children: [
                            Observer(builder: (_) {
                              return Checkbox(
                                  activeColor: Colors.white,
                                  tristate: true,
                                  value: valorPago,
                                  onChanged: (bool value) {
                                    if (value == true) {
                                      inserePagametnoFlushbar(receita);
                                    } else {
                                      flushbarExcluir(receita);
                                    }
                                  },
                                  checkColor: Colors.green);
                            }),
                            Expanded(
                              flex: 2,
                              child: InkWell(
                                onTap: () {
                                  if (receita.recNumeroParcelas != null &&
                                      receita.recNumeroParcelas > 0){
                                    busqueParcelas(receita.recIdGlobal);}
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 2.0, top: 2.0, bottom: 2.0),
                                  child: Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(left: 2.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start, //Alinha conteúdo da esqueda para diréita
                                          children: <Widget>[
                                            Text(
                                              receita.recServico ?? "-",
                                              style: GoogleFonts.lato(
                                                  textStyle: TextStyle(
                                                      color: Colors.pinkAccent),
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              "${receita.recData} " ?? "-",
                                              style: TextStyle(
                                                  fontSize: 13.0,
                                                  color: Colors.blueGrey[600]),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              "R\$ ${receita.recValor.toString()} " ??
                                                  "-",
                                              style: TextStyle(
                                                  fontSize: 13.0,
                                                  color: Colors.blueGrey[600]),
                                              textAlign: TextAlign.start,
                                            ),
                                            if (receita.recFormaPagamento !=
                                                    null &&
                                                receita.recTipoCartao == null)
                                              Text(
                                                "${receita.recFormaPagamento}" ??
                                                    "-",
                                                style: TextStyle(
                                                    fontSize: 13.0,
                                                    color:
                                                        Colors.blueGrey[600]),
                                                textAlign: TextAlign.start,
                                              ),
                                            if (receita.recFormaPagamento !=
                                                    null &&
                                                receita.recTipoCartao != null)
                                              Text(
                                                "${receita.recFormaPagamento} ${receita.recTipoCartao}" ??
                                                    "-",
                                                style: TextStyle(
                                                    fontSize: 13.0,
                                                    color:
                                                        Colors.blueGrey[600]),
                                                textAlign: TextAlign.start,
                                              ),
                                            if (receita.recNumeroParcelas !=
                                                    null &&
                                                receita.recNumeroParcelas > 0)
                                              Text(
                                                "Qtd parcelas: ${receita.recNumeroParcelas}" ??
                                                    "-",
                                                style: TextStyle(
                                                    fontSize: 13.0,
                                                    color:
                                                        Colors.blueGrey[600]),
                                                textAlign: TextAlign.start,
                                              ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                  width: size.width * .5,
                                  color: Colors.transparent,
                                  child: SizedBox(
                                    width: size.width * 0.5,
                                    height: size.height * 0.1,
                                    child: Row(
                                      children: [
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
                                                        .EDITARRECEITA,
                                                    arguments: receita);
                                          },
                                        ),
                                        IconButton(
                                          icon: (SvgPicture.asset(
                                              "assets/icons/Trash.svg")),
                                          tooltip: "Remover",
                                          onPressed: () {
                                            /*   flushbarExcluir(
                                            "Confirmar remoção?",
                                            "Registro removido!",
                                            pessoa);*/
                                          },
                                        ),
                                      ],
                                    ),
                                  )),
                            )
                          ],
                        ));
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

  busqueParcelas(recIdGlobal) {
    List<ParcelaModel> listaParcelas = List();
    receitaController.obtentaListaDeParcelasPorId(recIdGlobal).then((list) {
      listaParcelas = list;
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return new SimpleDialog(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.9,
                child: Observer(builder: (_) {
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 1.0),
                          child: Align(
                              alignment: Alignment.bottomRight,
                              child: IconButton(
                                  icon: Icon(Icons.cancel),
                                  color: Colors.amber,
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  })),
                        ),
                        Expanded(
                          child: Card(
                            child: ListView.separated(
                              itemCount: listaParcelas.length,
                              itemBuilder: (context, index) {
                                final parcela = listaParcelas[index];
                                return ListTile(
                                  title:
                                      Text("${parcela.parcelaNumero}ª Parcela"),
                                  subtitle: Text(
                                      "Valor: ${parcela.parcelaValor}  -  Data: ${parcela.parcelaData}"),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return Divider(color: Colors.blueGrey);
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
                ;
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

  flushbarExcluir(ReceitaModel receita) {
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
                  receitaController.atualizeReceita();
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
