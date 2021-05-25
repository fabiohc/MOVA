import 'package:emanuellemepoupe/controller/login_controller.dart';
import 'package:emanuellemepoupe/controller/compartilhado_controller.dart';
import 'package:emanuellemepoupe/pages/agenda/cadastro_evento.dart';
import 'package:emanuellemepoupe/pages/cliente/cadastro_pessoa.dart';
import 'package:emanuellemepoupe/pages/cadastro_despesa_receita.dart';
import 'package:emanuellemepoupe/pages/agenda/agenda.dart';
import 'package:emanuellemepoupe/pages/cliente/lista_pessoa.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:emanuellemepoupe/constants/constants_color.dart';
import 'package:emanuellemepoupe/pages/editar_despesa_receita.dart';
import 'package:emanuellemepoupe/pages/carteira/carteira.dart';
import 'package:emanuellemepoupe/pages/pagar/lista_despesas.dart';
import 'package:emanuellemepoupe/pages/receber/lista_receitas.dart';
import 'package:emanuellemepoupe/pages/menu.dart';
import 'package:emanuellemepoupe/pages/menu_despesas.dart';
import 'package:emanuellemepoupe/pages/menu_receitas.dart';
import 'package:emanuellemepoupe/pages/rotas.dart';
import 'package:emanuellemepoupe/pages/usuario/cadastro_usuario.dart';
import 'package:emanuellemepoupe/pages/usuario/login_usuario.dart';
import 'package:emanuellemepoupe/pages/agenda/editar_evento.dart';
import 'package:flutter/services.dart';

import 'helperBD/create_helperdb.dart';

dynamic userLogado;
bool conectado;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  CreateHelper().db;

  final logincontroller = LoginController();
  final compartilhadoController = CompartilhadoController();
  conectado = await compartilhadoController.verifiqueConexao();
  if (conectado == true) {
    userLogado = await logincontroller.verifiqueUsuarioLogado();
  } else {
    userLogado = await logincontroller.getPreferencias();
  }

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
        initialRoute: userLogado == false ? '/' : '/menu.dart',
        routes: {
          '/': (context) => Login(),
          '/menu.dart': (context) => MenuInicio(),
          RotasNavegacao.CADASTRO_USUARIO: (_) => Cadastro(),
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
          RotasNavegacao.EDITAR_EVENTO: (_) => EditarEvento(),
        });
  }
}
