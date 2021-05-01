import 'package:emanuellemepoupe/controller/pessoa_controller.dart';
import 'package:emanuellemepoupe/model/pessoa_model.dart';
import 'package:flutter/material.dart';

class PessoaDespesa extends StatefulWidget {
  final PessoaModel pessoa;
  PessoaDespesa(this.pessoa)  ;

  @override
  _PessoaDespesaState createState() => _PessoaDespesaState();
}

class _PessoaDespesaState extends State<PessoaDespesa> {
  final pessoaController = PessoaController();

  //var pessoa = new PessoaModel();



  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: [
                Expanded(
                    flex: 2,
                    child: Text(
                      "Nome",
                      style: TextStyle(fontSize: 14.0, color: Colors.white),
                      textAlign: TextAlign.start,
                    )),
                Text(
                  "${widget.pessoa.pessoaNome}",
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                  textAlign: TextAlign.end,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Text(
                      "Telefone",
                      style: TextStyle(fontSize: 14.0, color: Colors.white),
                      textAlign: TextAlign.start,
                    )),
                Text(
                  "${widget.pessoa.pessoaTelefone}",
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                  textAlign: TextAlign.end,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Text(
                      "E-mail",
                      style: TextStyle(fontSize: 14.0, color: Colors.white),
                      textAlign: TextAlign.start,
                    )),
                Text(
                  "${widget.pessoa.pessoaEmail}",
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
