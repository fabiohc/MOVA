
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:emanuellemepoupe/controller/carteira_controller.dart';
import 'package:emanuellemepoupe/controller/util.dart';
import 'package:emanuellemepoupe/helperBD/despesa_helperdb.dart';
import 'package:emanuellemepoupe/model/carteira_model.dart';

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
  List quantidadeDeCards;
  @override
  void initState() {
    super.initState();
    carteiraController.obtentaListaCompleta().then((list) {
      setState(() {
        listaCarteira = list;
        quantidadeDeCards = util.obtenhaQuantidadeDeMeses(listaCarteira);
        listaCarteiraMesAtual = util.obtenhaRegistroPorMes(listaCarteira);
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
            // Here the height of the container is 45% of our total height
            height: size.height * .45,
            decoration: BoxDecoration(
              color: Color(0xFFF5CEB8),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      child: Container(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: quantidadeDeCards.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          var mesAno = quantidadeDeCards[index];
                          var valorParcelaRec = carteiraController.obtentaSoma(
                              listaCarteira, mesAno.toString(), "parcelarec");
                          var valorParcelaDesp = carteiraController.obtentaSoma(
                              listaCarteira, mesAno.toString(), "parceladesp");
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
                          return Container(
                            width: size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                    child: Row(
                                  children: [
                                    Container(
                                      width: 300,
                                      height: 150,
                                      margin:
                                          EdgeInsets.symmetric(vertical: 30),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 10),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10.5),
                                      ),
                                      child: Expanded(
                                          child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              util.formataDataMesAno(
                                                  mesAno.toString()),
                                              textAlign: TextAlign.justify,
                                              style: TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                          Divider(),
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                    child: Text(
                                                  "Caixa",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.blueAccent),
                                                )),
                                                Expanded(
                                                    child: Text(
                                                  "Despesas",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.redAccent),
                                                )),
                                                Expanded(
                                                    child: Text(
                                                  "Receitas",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.green),
                                                )),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Expanded(
                                                child: Row(
                                              children: [
                                                Expanded(
                                                    child:
                                                        Text(caixa.toString())),
                                                Expanded(
                                                    child: Text(somaDespesa
                                                        .toString())),
                                                Expanded(
                                                    child: Text(somaReceita
                                                        .toString())),
                                              ],
                                            )),
                                          ),
                                        ],
                                      )),
                                    )
                                  ],
                                )),
                                Row(
                                  children: [
                                    Container(
                                      width: 300.0,
                                      child: GridView.count(
                                          shrinkWrap: true,
                                          crossAxisCount: 1,
                                          childAspectRatio: .85,
                                          crossAxisSpacing: 20,
                                          mainAxisSpacing: 20,
                                          children: <Widget>[
                                            Flexible(
                                                child: Card(
                                                    child: ListView.builder(
                                                        scrollDirection:
                                                            Axis.vertical,
                                                        shrinkWrap: true,
                                                        itemCount:
                                                            listaCarteiraMesAtual
                                                                .length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          listaCarteiraMesAtual =
                                                              util.obtenhaRegistroPorMes(
                                                                  listaCarteira,
                                                                  mesAno
                                                                      .toString());
                                                          var parcela =
                                                              listaCarteiraMesAtual[
                                                                  index];
                                                          return Observer(
                                                              builder: (_) {
                                                            return ListTile(
                                                              leading: Icon(
                                                                Icons.circle,
                                                                color: parcela.tipo ==
                                                                            "receita" ||
                                                                        parcela.tipo ==
                                                                            "parcelarec"
                                                                    ? Colors
                                                                        .greenAccent
                                                                    : Colors
                                                                        .redAccent,
                                                                size: 12,
                                                              ),
                                                              title: Text(
                                                                "${parcela.data}",
                                                              ),
                                                              subtitle: Text(util
                                                                  .formatMoedaDoubleParaString(
                                                                      "${parcela.valor.toString()} ")),
                                                              trailing: parcela
                                                                              .parcela
                                                                              .toString() ==
                                                                          null ||
                                                                      parcela.parcela
                                                                              .toString() ==
                                                                          '0'
                                                                  ? Text("")
                                                                  : Text(
                                                                      "  ${parcela.parcela.toString()} / ${parcela.parcelaQuatParc.toString()}"),
                                                            );
                                                          });
                                                        })))
                                          ]),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        }),
                  )),
                ],
              ),
            ),
          ),
   
        ],
      ),
    );
  }
}
