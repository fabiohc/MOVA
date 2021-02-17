import 'package:emanuellemepoupe/constants/constants_color.dart';
import 'package:emanuellemepoupe/controller/pessoa_controller.dart';
import 'package:emanuellemepoupe/model/pessoa_model.dart';
import 'package:emanuellemepoupe/pages/rotas.dart';
import 'package:emanuellemepoupe/widgets/navegacao.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class CadastroPessoa extends StatefulWidget {
  @override
  _CadastroPessoaState createState() => _CadastroPessoaState();
}

class _CadastroPessoaState extends State<CadastroPessoa> {
  final pessoaController = PessoaController();

  @override
  Widget build(BuildContext context) {
    final PessoaModel registroEditado =
        ModalRoute.of(context).settings.arguments;
    if (registroEditado != null) pessoaController.pessoaModel = registroEditado;

    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
          child: SafeArea(
              child: SingleChildScrollView(
                  child: Stack(
        children: [
          Container(
              height: size.height * .30,
              decoration: BoxDecoration(color: kBlueColor)),
          BottomNavBar(
            icon: SvgPicture.asset(
              "assets/icons/Voltar ICon.svg",
              color: Colors.white,
            ),
            margin: 10,
            alignment: Alignment.bottomLeft,
            press: () {
              Navigator.of(context).pushNamed(RotasNavegacao.LISTA_PESSOAS);
            },
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    color: Colors.transparent.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  //child: SvgPicture.asset(caminhoIconSvg))
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                        ),
                        //   controller: _nome,
                        initialValue: pessoaController.pessoaModel.pessoaNome,
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
                            color: Colors.grey[400],
                          ),
                          prefix: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                          ),
                        ),
                        onChanged: (value) {
                          pessoaController.pessoaModel.alteraNome(value);
                        },
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      initialValue: pessoaController.pessoaModel.pessoaTelefone,
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
                          color: Colors.grey[400],
                        ),
                        prefix: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                        ),
                      ),
                      onChanged: (value) {
                        pessoaController.pessoaModel
                            .alterapessoaTelefone(value);
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      style: TextStyle(
                        color: Colors.grey[400],
                      ),
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        DataInputFormatter()
                      ],
                      initialValue:
                          pessoaController.pessoaModel.pessoaDataNascimento,
                      decoration: InputDecoration(
                        icon: SvgPicture.asset(
                          "assets/icons/Phone.svg",
                          color: Colors.white,
                          width: 20,
                          height: 20,
                        ),
                        hintText: "Dt. Nascimento",
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          color: Colors.grey[400],
                        ),
                        prefix: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                        ),
                      ),
                      onChanged: (value) {
                        pessoaController.pessoaModel.alteraDataNascimeto(value);
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      initialValue: pessoaController.pessoaModel.pessoaEmail,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "E-mail",
                        hintStyle: TextStyle(
                          color: Colors.grey[400],
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
                      onChanged: (value) {
                        pessoaController.pessoaModel.alteraEmail(value);
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CpfInputFormatter()
                      ],
                      initialValue: pessoaController.pessoaModel.pessoaCpf,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefix: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                        ),
                        hintText: "CPF",
                        hintStyle: TextStyle(
                          color: Colors.grey[400],
                        ),
                        icon: SvgPicture.asset("assets/icons/Trash.svg"),
                      ),
                      onChanged: (value) {
                        pessoaController.pessoaModel.alteraCPF(value);
                      },
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
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
                          registroEditado != null ? "Alterar" : "Salvar",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20,
                              backgroundColor: Colors.transparent),
                          textAlign: TextAlign.center,
                        ),
                        onPressed: () {
                          flushbar(
                              "Confirmar ação?",
                              registroEditado != null
                                  ? "Registro alterado com sucesso!"
                                  : "Registro salvo com sucesso!",
                              registroEditado != null ? true : false);
                        },
                      ),
                    ))
              ],
            ),
          ),
        ],
      )))),
    );
  }

  Flushbar flushbar(
      String titleQuestione, menssagemConfirmeAcao, bool ehAlteracao) {
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

                flush = Flushbar<bool>(
                  title: "Pronto!",
                  message: menssagemConfirmeAcao,
                  margin: EdgeInsets.all(10),
                  borderRadius: 8,
                  duration: Duration(seconds: 2),
                  backgroundGradient: LinearGradient(colors: [
                    Colors.blue,
                    Colors.teal
                  ]), //duration: Duration(seconds: 3),
                )..show(context).then((value) {
                    if (ehAlteracao)
                      pessoaController.atualizePessoa();
                    else
                      pessoaController.inserirPessoa();
                    Navigator.of(context)
                        .pushNamed(RotasNavegacao.LISTA_PESSOAS);
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
      backgroundGradient: LinearGradient(colors: [Colors.blue, Colors.teal]),
    )..show(context);
  }
}
