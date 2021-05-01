import 'package:emanuellemepoupe/pages/rotas.dart';
import 'package:emanuellemepoupe/widgets/navegacao.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:emanuellemepoupe/controller/carteira_controller.dart';
import 'package:emanuellemepoupe/controller/util.dart';
import 'package:emanuellemepoupe/helperBD/despesa_helperdb.dart';
import 'package:emanuellemepoupe/model/carteira_model.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:emanuellemepoupe/constants/constants_color.dart';

class Carteira extends StatefulWidget {
  @override
  _CarteiraState createState() => _CarteiraState();
}

class _CarteiraState extends State<Carteira> {
  final carteiraController = CarteiraController();
  final despesaHelper = DespesaHelper();
  var util = Util();
  List<CarteiraModel> listaCarteira = List();
  List<CarteiraModel> listaCarteiraMesAtual = List();
  var controller = PageController(viewportFraction: 0.8);
  List quantidadeDeCards;
  @override
  void initState() {
    super.initState();
    carteiraController.obtentaListaCompleta().then((list) {
      setState(() {
        listaCarteira = list;
        quantidadeDeCards = util.obtenhaQuantidadeDeMeses(listaCarteira);
        listaCarteiraMesAtual = util.obtenhaRegistroPorMes(listaCarteira);
        CircularProgressIndicator();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: size.height * .40,
            decoration: BoxDecoration(
              color: Color(0xFFcdd0cb),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(),
              child: Column(
                children: <Widget>[
                  Row(
                    children: [
                      BottomNavBar(
                        icon: SvgPicture.asset(
                          "assets/icons/Voltar ICon.svg",
                          color: Colors.white,
                        ),
                        margin: 10,
                        alignment: Alignment.bottomLeft,
                       colorfonte: kTextColor,
                        // color: Colors.white.withOpacity(2),
                        press: () {
                          Navigator.of(context).pushNamed(RotasNavegacao.HOME);
                        },
                        descricao: "CARTEIRA",
                      ),
                    ],
                  ),
                  Expanded(
                      flex: 1,
                      child: Swiper(
                          pagination: new SwiperPagination(),
                          control: new SwiperControl(size: 20),
                          itemCount: quantidadeDeCards.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            var mesAno = quantidadeDeCards[index];
                            var valorParcelaRec =
                                carteiraController.obtentaSoma(listaCarteira,
                                    mesAno.toString(), "parcelarec");
                            var valorParcelaDesp =
                                carteiraController.obtentaSoma(listaCarteira,
                                    mesAno.toString(), "parceladesp");
                            var valorDespesa = carteiraController.obtentaSoma(
                                listaCarteira, mesAno.toString(), "despesa");
                            var valorReceita = carteiraController.obtentaSoma(
                                listaCarteira, mesAno.toString(), "receita");

                            var somaReceitaParcela =
                                valorParcelaRec + valorReceita;
                            var somaDespesaParcela =
                                valorParcelaDesp + valorDespesa;
                            var somaReceitaDespesa =
                                somaReceitaParcela - somaDespesaParcela;

                            var caixa = util.formatMoedaDoubleParaString(
                                somaReceitaDespesa.toString());
                            var somaDespesa = util.formatMoedaDoubleParaString(
                                somaDespesaParcela.toString());
                            var somaReceita = util.formatMoedaDoubleParaString(
                                somaReceitaParcela.toString());

                            listaCarteiraMesAtual = util.obtenhaRegistroPorMes(
                                listaCarteira, mesAno.toString());
                            return PageView(
                              controller: controller,
                              children: [
                                Container(
                                  width: size.width,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                          flex: 1,
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  flex: 1,
                                                  child: Container(
                                                    width: size.width * .90,
                                                    height: size.height,
                                                    margin: EdgeInsets.only(
                                                        top: size.height * .01,
                                                        bottom:
                                                            size.height * .01),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                size.height *
                                                                    .01,
                                                            vertical:
                                                                size.height *
                                                                    .01),
                                                    decoration: BoxDecoration(
                                                      color: Colors.transparent,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.5),
                                                    ),
                                                    child: Expanded(
                                                        flex: 2,
                                                        child: Column(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                util.formataDataMesAno(
                                                                    mesAno
                                                                        .toString()),
                                                                textAlign:
                                                                    TextAlign
                                                                        .justify,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 20,
                                                                ),
                                                              ),
                                                            ),
                                                            Divider(),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(4.0),
                                                              child: Row(
                                                                children: [
                                                                  Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          Text(
                                                                        "Caixa",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                17,
                                                                            color:
                                                                                Colors.blueAccent),
                                                                      )),
                                                                  Expanded(
                                                                      child:
                                                                          Text(
                                                                    "Despesas",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            17,
                                                                        color: Colors
                                                                            .redAccent),
                                                                  )),
                                                                  Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          Text(
                                                                        "Receitas",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                17,
                                                                            color:
                                                                                Colors.green),
                                                                      )),
                                                                ],
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(4.0),
                                                              child: Expanded(
                                                                  child: Row(
                                                                children: [
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                        caixa
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                15)),
                                                                  ),
                                                                  Expanded(
                                                                      flex: 1,
                                                                      child: Text(
                                                                          "- " +
                                                                              somaDespesa
                                                                                  .toString(),
                                                                          style:
                                                                              TextStyle(fontSize: 15))),
                                                                  Expanded(
                                                                      flex: 1,
                                                                      child: Text(
                                                                          somaReceita
                                                                              .toString(),
                                                                          style:
                                                                              TextStyle(fontSize: 15))),
                                                                ],
                                                              )),
                                                            ),
                                                          ],
                                                        )),
                                                  ))
                                            ],
                                          )),
                                      Expanded(
                                          flex: 2,
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  flex: 2,
                                                  child: Container(
                                                    width: size.width * .90,
                                                    child: GridView.count(
                                                        shrinkWrap: true,
                                                        crossAxisCount: 1,
                                                        childAspectRatio:
                                                            size.height * .001,
                                                        crossAxisSpacing: 20,
                                                        mainAxisSpacing: 20,
                                                        children: <Widget>[
                                                          Flexible(
                                                              child: ListView
                                                                  .builder(
                                                                      scrollDirection:
                                                                          Axis
                                                                              .vertical,
                                                                      shrinkWrap:
                                                                          true,
                                                                      itemCount:
                                                                          listaCarteiraMesAtual
                                                                              .length,
                                                                      itemBuilder:
                                                                          (context,
                                                                              index) {
                                                                        listaCarteiraMesAtual = util.obtenhaRegistroPorMes(
                                                                            listaCarteira,
                                                                            mesAno.toString());
                                                                        var parcela =
                                                                            listaCarteiraMesAtual[index];
                                                                        return Observer(builder:
                                                                            (_) {
                                                                          return ListTile(
                                                                              leading: Icon(
                                                                                Icons.circle,
                                                                                color: parcela.tipo == "receita" || parcela.tipo == "parcelarec" ? Colors.greenAccent : Colors.redAccent,
                                                                                size: 12,
                                                                              ),
                                                                              title: Text("${parcela.data}", style: TextStyle(color: Colors.white)),
                                                                              subtitle: parcela.parcela.toString() == null || parcela.parcela.toString() == '0' ? Text("") : Text("Parcela " + "${parcela.parcela.toString()} de ${parcela.parcelaQuatParc.toString()}", style: TextStyle(color: Colors.white)),
                                                                              trailing: parcela.tipo == "receita" || parcela.tipo == "parcelarec"
                                                                                  ? Text(
                                                                                      util.formatMoedaDoubleParaString(
                                                                                        " ${parcela.valor.toString()}",
                                                                                      ),
                                                                                      style: TextStyle(
                                                                                        color: Colors.greenAccent,
                                                                                        fontSize: 15,
                                                                                      ),
                                                                                    )
                                                                                  : Text(
                                                                                      "- " +
                                                                                          util.formatMoedaDoubleParaString(
                                                                                            "${parcela.valor.toString()}",
                                                                                          ),
                                                                                      style: TextStyle(
                                                                                        color: Colors.redAccent,
                                                                                        fontSize: 15,
                                                                                      ),
                                                                                    ));
                                                                        });
                                                                      }))
                                                        ]),
                                                  )),
                                            ],
                                          ))
                                    ],
                                  ),
                                ),
                              ],
                            );
                          })),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
