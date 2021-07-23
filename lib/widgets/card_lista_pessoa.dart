import 'package:emanuellemepoupe/constants/constants_color.dart';
import 'package:emanuellemepoupe/controller/pessoa_controller.dart';
import 'package:emanuellemepoupe/model/pessoa_model.dart';
import 'package:emanuellemepoupe/pages/rotas.dart';
import 'package:emanuellemepoupe/widgets/navegacao.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CardlistaPessoa extends StatefulWidget {
  @override
  _CardlistaPessoaState createState() => _CardlistaPessoaState();
}

class _CardlistaPessoaState extends State<CardlistaPessoa> {
  final pessoaController = PessoaController();
  List<PessoaModel> listaPessoasCompleta = [];
  List<PessoaModel> listaPessoas = [];

  TextEditingController filtro;

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(
        Duration(seconds: 2),
        () => pessoaController.obtentaListaPessoas().then((list) {
              setState(() {
                listaPessoasCompleta = list;
              });
            }));
  }

  var refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    pessoaController.obtentaListaPessoas().then((list) {
      setState(() {
        listaPessoasCompleta = list;
        listaPessoas = listaPessoasCompleta;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Stack(
              children: [
                Container(
                  height: size.height * .15,
                  decoration: BoxDecoration(color: kBlueColor),
                ),
               BottomNavBar(
                  icon: Icon(
                    Icons.group_add_outlined,
                    color: Colors.white,
                  ),
                  margin: 10,
                  alignment: Alignment.topRight,
                  //color: Colors.transparent,
                  press: () {
                    Navigator.of(context)
                        .pushNamed(RotasNavegacao.CADASTRO_PESSOA);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 50, horizontal: 10),
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
                      onChanged: (filtro) {
                        setState(() {
                          if (filtro != "") {
                            listaPessoas = pessoaController.filtreListaPessoas(
                                listaPessoas, filtro);
                          } else {
                            listaPessoas = listaPessoasCompleta;
                          }
                        });
                      },
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: size.height * .20),
                  height: size.height * .30,
                  child: RefreshIndicator(
                      onRefresh: refreshList,
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: listaPessoas.length,
                          itemBuilder: (context, index) {
                            var pessoa = listaPessoas[index];
                            return ListTile(
                                onLongPress: () {
                                  pessoaController.mudatelefone(pessoa.pessoaTelefone);
                                   pessoaController.pessoaModel.alteraPessoaModel(pessoa);
                              /*   PessoaModel.fromMap(pessoa.toMap(), false);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Despesapro(initialIndexTab: 1

                                                  // pessoaSelecionada: pessoa,
                                                  )));*/

                                },
                                leading: Container(
                                    width: 60.0,
                                    height: 60.0,
                                    color: Colors.transparent,
                                    child: CircleAvatar(
                                      child: SvgPicture.asset(
                                          "assets/icons/Image foto.svg"),
                                      backgroundColor: Colors.white,
                                    )),
                                title: Text("${pessoa.pessoaNome}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                    )),
                                subtitle: Text("${pessoa.pessoaTelefone}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.0,
                                    )),
                                trailing: Observer(builder: (_) {
                                  return Container(
                                      width: size.width * .27,
                                      color: Colors.transparent,
                                      child: SizedBox(
                                        width: size.width,
                                        height: size.height,
                                        child: Row(
                                          children: [
                                            IconButton(
                                              icon: (SvgPicture.asset(
                                                "assets/icons/editar.svg",
                                                color: Colors.deepOrange,
                                              )),
                                              tooltip: "Editar",
                                              onPressed: () {
                                                Navigator.of(context).pushNamed(
                                                    RotasNavegacao
                                                        .CADASTRO_PESSOA,
                                                    arguments: pessoa);
                                              },
                                            ),
                                            IconButton(
                                              icon: (SvgPicture.asset(
                                                  "assets/icons/Trash.svg")),
                                              tooltip: "Remover",
                                              onPressed: () {
                                                flushbarExcluir(
                                                    "Confirmar remoção?",
                                                    "Registro removido!",
                                                    pessoa);
                                              },
                                            ),
                                          ],
                                        ),
                                      ));
                                }));
                          })),
                )
              ],
            )));
  }

  Flushbar flushbarExcluir(
      String titleQuestione, String menssagemConfirmeAcao, PessoaModel pessoa) {
    Flushbar flush;
    return flush = Flushbar<bool>(
      title: titleQuestione,
      message: " ",
      margin: EdgeInsets.all(10),
      borderRadius: 8,
      isDismissible: true,
      mainButton: Row(
        children: [
          TextButton(
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
          TextButton(
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
                )..show(context).then((value) {
                    pessoaController.deletePessoa(pessoa);
                    pessoaController.obtentaListaPessoas().then((list) {
                      setState(() {
                        listaPessoas = list;
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
}
