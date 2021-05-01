import 'package:emanuellemepoupe/controller/parcela_controller.dart';
import 'package:emanuellemepoupe/model/despesa_model.dart';
import 'package:emanuellemepoupe/widgets/pessoa_detalhes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class DespesaDetalhes extends StatefulWidget {
  final DespesaModel despesa;

  DespesaDetalhes(this.despesa);

  @override
  _DespesaDetalhesState createState() => _DespesaDetalhesState();
}

class _DespesaDetalhesState extends State<DespesaDetalhes> {
  final parcelaController = ParcelaController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
        child: InkWell(
      onTap: () {
        return showDialog(
          context: context,
          builder: (BuildContext context) {
            return new SimpleDialog(
              children: <Widget>[
                Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.9,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 1.0),
                            child: Align(
                                alignment: Alignment.bottomRight,
                                child: IconButton(
                                    icon: SvgPicture.asset(
                                        "assets/icons/Close.svg"),
                                    color: Colors.amber,
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    })),
                          ),
                          Expanded(
                            child: ListView(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                children: [
                                  Column(
                                    children: <Widget>[
                                      Container(
                                        height: size.height * .20,
                                        decoration: BoxDecoration(
                                            color: Colors.blueAccent),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                      flex: 1,
                                                      child: Text(
                                                        "Data",
                                                        style: TextStyle(
                                                            fontSize: 14.0,
                                                            color:
                                                                Colors.white),
                                                        textAlign:
                                                            TextAlign.start,
                                                      )),
                                                  Text(
                                                    "${widget.despesa.despData} " ??
                                                        "-",
                                                    style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                    ),
                                                    textAlign: TextAlign.end,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                      flex: 1,
                                                      child: Text(
                                                        "Valor",
                                                        style: TextStyle(
                                                            fontSize: 14.0,
                                                            color:
                                                                Colors.white),
                                                        textAlign:
                                                            TextAlign.start,
                                                      )),
                                                  Text(
                                                    "R\$ ${widget.despesa.despValor.toString()} " ??
                                                        "-",
                                                    style: TextStyle(
                                                        fontSize: 14.0,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w800),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            if (widget.despesa
                                                        .despFormaPagamento !=
                                                    null &&
                                                widget.despesa
                                                        .despFormaPagamento !=
                                                    "null")
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          "Pago com",
                                                          style: TextStyle(
                                                              fontSize: 14.0,
                                                              color:
                                                                  Colors.white),
                                                          textAlign:
                                                              TextAlign.start,
                                                        )),
                                                    Text(
                                                      "${widget.despesa.despFormaPagamento}" ??
                                                          "-",
                                                      style: TextStyle(
                                                          fontSize: 14.0,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w800),
                                                      textAlign:
                                                          TextAlign.start,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            if (widget.despesa.despServico ==
                                                "Parcela")
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          "Parcela",
                                                          style: TextStyle(
                                                              fontSize: 14.0,
                                                              color:
                                                                  Colors.white),
                                                          textAlign:
                                                              TextAlign.start,
                                                        )),
                                                    if (widget.despesa
                                                                .despNumeroParcelas !=
                                                            null &&
                                                        widget.despesa
                                                                .despNumeroParcelas >
                                                            0)
                                                      Text(
                                                        "",
                                                        //  "${parcela.parcelaNumero} / ${despesa.despNumeroParcelas}" ?? "-",
                                                        style: TextStyle(
                                                            fontSize: 14.0,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w800),
                                                        textAlign:
                                                            TextAlign.start,
                                                      ),
                                                  ],
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                      if (widget.despesa.pessoaModel != null)
                                        Container(
                                            height: size.height * .15,
                                            decoration: BoxDecoration(
                                                color: Colors.blueAccent),
                                            child: PessoaDespesa(
                                                widget.despesa.pessoaModel)),
                                      Container(
                                        height: size.height * .15,
                                        decoration: BoxDecoration(
                                            color: Colors.blueAccent),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Descrição",
                                                    style: TextStyle(
                                                        fontSize: 15.0,
                                                        color: Colors.white),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "${widget.despesa.despObservacao}",
                                                    style: TextStyle(
                                                        fontSize: 14.0,
                                                        color: Colors.white),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      if (widget.despesa.parcelaModel != null)
                                        ListView.separated(
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          itemCount: widget
                                              .despesa.parcelaModel.length,
                                          itemBuilder: (context, index) {
                                            final parcela = widget
                                                .despesa.parcelaModel[index];
                                            var icon = parcelaController
                                                .verificaStatusPagamento(
                                                    parcela);
                                            return ListTile(
                                              leading: SvgPicture.asset(
                                                icon[0]["icon"],
                                                color: icon[0]["color"],
                                                width: 10,
                                                height: 10,
                                              ),
                                              title: Text(
                                                  "${parcela.parcelaNumero}ª Parcela"),
                                              subtitle: Text(
                                                  "R\$ ${parcela.parcelaValor}\n${parcela.parcelaData}"),
                                            );
                                          },
                                          separatorBuilder: (context, index) {
                                            return Divider(
                                                color: Colors.blueGrey);
                                          },
                                        ),
                                    ],
                                  )
                                ]),
                          )
                        ]))
              ],
            );
          },
        );
      },
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.despesa.despServico ?? "-",
                    style: GoogleFonts.lato(
                        textStyle: TextStyle(color: Colors.blue[200]),
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    "${widget.despesa.despData} " ?? "-",
                    style: TextStyle(fontSize: 14.0, color: Colors.white),
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    "R\$ ${widget.despesa.despValor.toString()} " ?? "-",
                    style: TextStyle(fontSize: 14.0, color: Colors.white),
                    textAlign: TextAlign.start,
                  ),
                  if (widget.despesa.despFormaPagamento != "null" &&
                          widget.despesa.despTipoCartao == "null" ||
                      widget.despesa.despTipoCartao == null)
                    Text(
                      "${widget.despesa.despFormaPagamento}" ?? "-",
                      style: TextStyle(fontSize: 14.0, color: Colors.white),
                      textAlign: TextAlign.start,
                    ),
                  if (widget.despesa.despFormaPagamento != "null" &&
                      widget.despesa.despTipoCartao != "null" &&
                      widget.despesa.despTipoCartao != null)
                    Text(
                      "${widget.despesa.despFormaPagamento} ${widget.despesa.despTipoCartao}" ??
                          "-",
                      style: TextStyle(fontSize: 14.0, color: Colors.white),
                      textAlign: TextAlign.start,
                    ),
                  if (widget.despesa.despNumeroParcelas != null &&
                      widget.despesa.despNumeroParcelas > 0)
                    Text(
                      "Qtd parcelas: ${widget.despesa.despNumeroParcelas}" ??
                          "-",
                      style: TextStyle(fontSize: 14.0, color: Colors.white),
                      textAlign: TextAlign.start,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
