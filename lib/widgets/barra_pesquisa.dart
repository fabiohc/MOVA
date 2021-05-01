import 'package:emanuellemepoupe/controller/pessoa_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BarraPesquisa extends StatelessWidget {
  final Function press;
  final List lista;
  final TextEditingController filtro;
  const BarraPesquisa({Key key, this.press, this.lista, this.filtro})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var pessoaController = PessoaController();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 100, horizontal: 10),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: TextFormField(
          decoration: InputDecoration(
            hintText: "Pesquisar",
            icon: SvgPicture.asset("assets/icons/Search Icon.svg"),
            border: InputBorder.none,
          ),
          controller: filtro,
          onChanged: (value) {
            var a = pessoaController.filtreListaPessoas(lista, value);
            return a;
          },
        ),
      ),
    );
  }
}
