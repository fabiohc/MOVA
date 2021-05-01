import 'package:emanuellemepoupe/controller/login_controller.dart';
import 'package:emanuellemepoupe/pages/cadastro_evento.dart';
import 'package:emanuellemepoupe/pages/cadastro_pessoa.dart';
import 'package:emanuellemepoupe/pages/cadastro_despesa_receita.dart';
import 'package:emanuellemepoupe/pages/agenda.dart';
import 'package:emanuellemepoupe/pages/lista_pessoa.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:emanuellemepoupe/repository/agenda_repository.dart';
import 'package:emanuellemepoupe/repository/receita_repository.dart';
import 'package:emanuellemepoupe/repository/despesa_repository.dart';
import 'package:emanuellemepoupe/repository/pessoa_repository.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:emanuellemepoupe/constants/constants_color.dart';
import 'package:emanuellemepoupe/pages/editar_despesa_receita.dart';
import 'package:emanuellemepoupe/pages/carteira.dart';
import 'package:emanuellemepoupe/pages/lista_despesas.dart';
import 'package:emanuellemepoupe/pages/lista_receitas.dart';
import 'package:emanuellemepoupe/pages/menu.dart';
import 'package:emanuellemepoupe/pages/menu_despesas.dart';
import 'package:emanuellemepoupe/pages/menu_receitas.dart';
import 'package:emanuellemepoupe/pages/rotas.dart';
import 'package:emanuellemepoupe/pages/cadastro_usuario.dart';
import 'package:emanuellemepoupe/pages/login_usuario.dart';

import 'helperBD/create_helperdb.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  CreateHelper().db;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final logincontroller = LoginController();
  @override
  Widget build(BuildContext context) {
    DespesaRepository().selectListerneFirestore();
    ReceitaRepository().selectListerneFirestore();
    PessoaRepository().selectListerneFirestore();
    AgendaRepository().selectListerneFirestore();

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: [const Locale('pt', 'BR')],
        title: 'Cadastro',
        theme: ThemeData(
          fontFamily: "Cairo",
          primarySwatch: Colors.orange,
          scaffoldBackgroundColor: kTextColor,
          unselectedWidgetColor: Colors.grey,
          textTheme:
              Theme.of(context).textTheme.apply(displayColor: kTextColor),
        ),
        routes: {
          RotasNavegacao.LOGIN: (_) => Login(),
          RotasNavegacao.CADASTRO_USUARIO: (_) => Cadastro(),
          RotasNavegacao.HOME: (_) => MenuInicio(),
          RotasNavegacao.CADASTRO_DESPESA: (_) => CadastroDespesaReceita(),
          // ignore: equal_keys_in_map
          RotasNavegacao.CADASTRO_RECEITA: (_) => CadastroDespesaReceita(),
          RotasNavegacao.CADASTRO_PESSOA: (_) => CadastroPessoa(),
          RotasNavegacao.MENU_RECEITAS: (_) => MenuReceitas(),
          RotasNavegacao.MENU_DESPESAS: (_) => MenuDespesa(),
          RotasNavegacao.LISTA_DESPESAS: (_) => ListaDespesas(),
          RotasNavegacao.LISTA_RECEITAS: (_) => ListaReceitas(),
          RotasNavegacao.EDITAR_DESPESA_RECEITA: (_) => EditarDespesaReceita(),
          RotasNavegacao.CARTEIRA: (_) => Carteira(),
          RotasNavegacao.LISTA_PESSOAS: (_) => ListaPessoa(),
          RotasNavegacao.AGENDA: (_) => Agenda(),
          RotasNavegacao.CADASTRO_EVENTO: (_) => CadastroEvento(),
        });
  }
}
