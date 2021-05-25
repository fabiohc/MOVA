import 'dart:io';

import 'package:emanuellemepoupe/constants/constants_color.dart';
import 'package:emanuellemepoupe/controller/pessoa_controller.dart';
import 'package:emanuellemepoupe/model/pessoa_model.dart';
import 'package:emanuellemepoupe/pages/rotas.dart';
import 'package:emanuellemepoupe/widgets/navegacao.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

class CadastroPessoa extends StatefulWidget {
  @override
  _CadastroPessoaState createState() => _CadastroPessoaState();
}

class _CadastroPessoaState extends State<CadastroPessoa> {
  final pessoaController = PessoaController();
  List<File> _imagemSlecionada = List();
  final picker = ImagePicker();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String url;

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
            descricao: "NOVO CLIENTE",
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.symmetric(
                horizontal: size.width * .02, vertical: size.height * .05),
            child: Column(
              children: [
                GestureDetector(
                    onTap: () async {
                      return showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context) {
                            return new SimpleDialog(
                              title: Align(
                                alignment: Alignment.bottomRight,
                                child: IconButton(
                                    icon: SvgPicture.asset(
                                        "assets/icons/Close.svg"),
                                    color: Colors.amber,
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    }),
                              ),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        'Qual a origem da imagem?',
                                        style: TextStyle(fontSize: 20),
                                      )),
                                ),
                                SizedBox(
                                  height: size.height * .010,
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(30.0),
                                      child: Column(
                                        children: [
                                          CircleAvatar(
                                            radius: 40,
                                            backgroundColor: Colors.amberAccent,
                                            child: IconButton(
                                                icon: SvgPicture.asset(
                                                    "assets/icons/camera.svg",
                                                    color: Colors.black,
                                                    height: 30,
                                                    width: 30),
                                                onPressed: () async {
                                                  Navigator.of(context,
                                                          rootNavigator: true)
                                                      .pop('dialog');

                                                  var pickedFile =
                                                      await picker.getImage(
                                                          source: ImageSource
                                                              .camera);

                                                  setState(() {
                                                    if (pickedFile != null) {
                                                      _imagemSlecionada.clear();

                                                      _imagemSlecionada.add(
                                                          File(
                                                              pickedFile.path));
                                                    }
                                                  });

                                                  url = await pessoaController
                                                      .uploadImagem(File(
                                                          pickedFile.path));
                                                }),
                                          ),
                                          Text(
                                            "Camera",
                                            style: TextStyle(fontSize: 20),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(25.0),
                                      child: Column(
                                        children: [
                                          CircleAvatar(
                                              backgroundColor:
                                                  Colors.blueAccent,
                                              radius: 40,
                                              child: IconButton(
                                                  color: Colors.blue,
                                                  icon: SvgPicture.asset(
                                                      "assets/icons/gallery.svg",
                                                      color: Colors.black,
                                                      height: 30,
                                                      width: 30),
                                                  onPressed: () async {
                                                    Navigator.of(context,
                                                            rootNavigator: true)
                                                        .pop('dialog');

                                                    var pickedFile =
                                                        await picker.getImage(
                                                            source: ImageSource
                                                                .gallery);

                                                    setState(() {
                                                      if (pickedFile != null) {
                                                        _imagemSlecionada
                                                            .clear();

                                                        _imagemSlecionada.add(
                                                            File(pickedFile
                                                                .path));
                                                      }
                                                    });

                                                    url = await pessoaController
                                                        .uploadImagem(File(
                                                            pickedFile.path));
                                                  })),
                                          Text(
                                            "Galeria",
                                            style: TextStyle(fontSize: 20),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            );
                          });
                    },
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          if (_imagemSlecionada == null ||
                              _imagemSlecionada.length == 0 &&
                                  pessoaController.pessoaModel.pessoafotourl ==
                                      null)
                            CircleAvatar(
                              backgroundColor:
                                  Colors.transparent.withOpacity(0.1),
                              radius: size.width * 0.14,
                              child: Align(
                                alignment: Alignment.center,
                                child: Icon(Icons.add_a_photo,
                                    size: 60, color: Colors.white),
                              ),
                            ),
                          if (_imagemSlecionada != null &&
                                  _imagemSlecionada.length > 0 ||
                              pessoaController.pessoaModel.pessoafotourl !=
                                  null)
                            CircleAvatar(
                              backgroundImage:
                                  pessoaController.pessoaModel.pessoafotourl !=
                                          null
                                      ? NetworkImage(pessoaController
                                          .pessoaModel.pessoafotourl)
                                      : FileImage(_imagemSlecionada[0]),
                              radius: size.width * 0.14,
                            ),
                          if (_imagemSlecionada != null &&
                                  _imagemSlecionada.length > 0 ||
                              pessoaController.pessoaModel.pessoafotourl !=
                                  null)
                            FlatButton.icon(
                              label: Text(
                                "Remover",
                                style: TextStyle(color: Colors.white),
                              ),
                              color: Colors.transparent,
                              icon: Icon(
                                Icons.delete,
                                semanticLabel: "Delete",
                                color: Colors.red,
                              ),
                              onPressed: () {
                                setState(() {
                                  _imagemSlecionada.clear();
                                });
                              },
                            )
                        ],
                      ),
                    )),
                SizedBox(
                  height: size.height * .05,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                        ),
                        initialValue: pessoaController.pessoaModel.pessoaNome,
                        decoration: InputDecoration(
                          hintText: "Nome",
                          icon: SvgPicture.asset(
                            "assets/icons/User Icon.svg",
                            color: Colors.white,
                            width: 25,
                            height: 25,
                          ),
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            color: Colors.grey[400],
                          ),
                          prefix: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                          ),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (String value) {
                          return pessoaController.valideNome();
                        },
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
                      textInputAction: TextInputAction.next,
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
                          width: 30,
                          height: 30,
                        ),
                        hintText: "(00)00000-0000",
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          color: Colors.grey[400],
                        ),
                        prefix: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                        ),
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (String value) {
                        return pessoaController.valideTelefone();
                      },
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
                      textInputAction: TextInputAction.next,
                      style: TextStyle(
                        color: Colors.white,
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
                          "assets/icons/bolo aniversario.svg",
                          color: Colors.white,
                          width: 27,
                          height: 27,
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
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (String value) {
                        return pessoaController.valideDataNascimento();
                      },
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
                      textInputAction: TextInputAction.next,
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
                          width: 20,
                          height: 20,
                        ),
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (String value) {
                        return pessoaController.valideEmail();
                      },
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
                        icon: SvgPicture.asset(
                          "assets/icons/doc.svg",
                          color: Colors.white,
                          width: 30,
                          height: 30,
                        ),
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (String value) {
                        return pessoaController.valideCPF();
                      },
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
                      child: Observer(builder: (_) {
                        return RaisedButton(
                          color: Color(0xff0BBFD6),
                          shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          child: Text(
                            registroEditado != null ? "Alterar" : "Salvar",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20,
                                backgroundColor: Colors.transparent),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: pessoaController.isValid
                              ? () {
                                  flushbar(
                                      "Confirmar ação?",
                                      registroEditado != null
                                          ? "Registro alterado com sucesso!"
                                          : "Registro salvo com sucesso!",
                                      registroEditado != null ? true : false);
                                }
                              : null,
                        );
                      }),
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
                    if (ehAlteracao) {
                      pessoaController.pessoaModel.alterapessoafotourl(url);
                      pessoaController.atualizePessoa();
                    } else {
                      pessoaController.pessoaModel.alterapessoafotourl(url);
                      pessoaController.inserirPessoa();
                    }
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
