import 'package:emanuellemepoupe/repository/receita_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:emanuellemepoupe/constants/constants_color.dart';
import 'package:emanuellemepoupe/pages/cadastroDespesa.dart';
import 'package:emanuellemepoupe/pages/cadastroReceita.dart';
import 'package:emanuellemepoupe/pages/carteira.dart';
import 'package:emanuellemepoupe/pages/editar_despesas.dart';
import 'package:emanuellemepoupe/pages/editar_receita.dart';
import 'package:emanuellemepoupe/pages/lista_despesas.dart';
import 'package:emanuellemepoupe/pages/lista_receitas.dart';
import 'package:emanuellemepoupe/pages/menu.dart';
import 'package:emanuellemepoupe/pages/menu_despesas.dart';
import 'package:emanuellemepoupe/pages/menu_receitas.dart';
import 'package:emanuellemepoupe/pages/rotas.dart';
import 'package:emanuellemepoupe/repository/despesa_repository.dart';

import 'helperBD/create_helperdb.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  CreateHelper().db;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DespesaRepository().selectListerneFirestore();
    ReceitaRepository().selectListerneFirestore();
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
          primarySwatch: Colors.purple,
          scaffoldBackgroundColor: kBackgroundColor,
          textTheme:
              Theme.of(context).textTheme.apply(displayColor: kTextColor),
        ),
        routes: {
          RotasNavegacao.HOME: (_) => MenuInicio(),
          RotasNavegacao.CADASTRO_DESPESA: (_) => CadastroDespesa(),
          RotasNavegacao.CADASTRO_RECEITA: (_) => CadastroReceita(),
          RotasNavegacao.MENU_DESPESAS: (_) => MenuDespesa(),
          RotasNavegacao.MENU_RECEITAS: (_) => MenuReceitas(),
          RotasNavegacao.LISTA_DESPESAS: (_) => ListaDespesas(),
          RotasNavegacao.LISTA_RECEITAS: (_) => ListaReceitas(),
          RotasNavegacao.EDITARREGISTRO: (_) => EditarRegistro(),
          RotasNavegacao.EDITARRECEITA: (_) => EditarReceita(),
          RotasNavegacao.CARTEIRA: (_) => Carteira(),
        });
  }
}