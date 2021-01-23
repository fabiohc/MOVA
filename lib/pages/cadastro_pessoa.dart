import 'package:emanuellemepoupe/constants/constants_color.dart';
import 'package:emanuellemepoupe/controller/util.dart';
import 'package:flutter/material.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class CadastroPessoa extends StatefulWidget {
  @override
  _CadastroPessoaState createState() => _CadastroPessoaState();
}

class _CadastroPessoaState extends State<CadastroPessoa> {
  Util _util = Util();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
          child: SafeArea(
              child: SingleChildScrollView(
                  child: Stack(
        children: [
          Container(
              height: size.height * .40,
              decoration: BoxDecoration(color: kBlueColor)),
          Container(
            margin: EdgeInsets.symmetric(vertical: size.height * .10),
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                      ),
                      decoration: InputDecoration(
                        hintText: "Nome",
                        icon: SvgPicture.asset(
                          "assets/icons/User Icon.svg",
                          color: Colors.white,
                          width: 20,
                          height: 20,
                        ),
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          color: Colors.white,
                        ),
                        prefix: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        TelefoneInputFormatter()
                      ],
                      decoration: InputDecoration(
                        icon: SvgPicture.asset(
                          "assets/icons/Phone.svg",
                          color: Colors.white,
                          width: 20,
                          height: 20,
                        ),
                        hintText: "Telefone",
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          color: Colors.white,
                        ),
                        prefix: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "E-mail",
                        hintStyle: TextStyle(
                          color: Colors.white,
                        ),
                        prefix: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                        ),
                        icon: SvgPicture.asset(
                          "assets/icons/Mail.svg",
                          color: Colors.white,
                          width: 15,
                          height: 15,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CpfInputFormatter()
                      ],
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefix: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                        ),
                        hintText: "CPF",
                        hintStyle: TextStyle(
                          color: Colors.white,
                        ),
                        icon: SvgPicture.asset("assets/icons/search.svg"),
                      ),
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: size.width,
                      height: size.height * 0.1,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueAccent),
                        color: Colors.transparent.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: FlatButton(
                        child: Text(
                          "Salvar",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20,
                              backgroundColor: Colors.transparent),
                          textAlign: TextAlign.center,
                        ),
                        onPressed: () {},
                      ),
                    ))
              ],
            ),
          ),
        ],
      )))),
    );
  }
}
