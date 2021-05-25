// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:emanuellemepoupe/controller/agenda_controller.dart';
import 'package:emanuellemepoupe/controller/carteira_controller.dart';
import 'package:emanuellemepoupe/controller/parcela_controller.dart';
import 'package:emanuellemepoupe/controller/util.dart';
import 'package:emanuellemepoupe/model/parcela_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  //testeStatusPagamento();
  testeAgenda();
}

testeAgenda() {

  
  setUp(() {
    util = Util();
  });

  test('Verifica se o tipo e DateTime', () async {
   var angendaController = new AgendaController();



 var a = angendaController.obtenhaEventosAgenda();

    // Verify that our counter starts at 0.
    expect(a, a != null);
  });
}

testeStatusPagamento() {
  ParcelaController parcela;
  ParcelaModel parcelaModel;

  setUp(() {
    parcela = ParcelaController();
    parcelaModel = ParcelaModel();
  });

  test('Verifica se o tipo e DateTime', () {
    parcelaModel.parcelaStatusPag = false;
    parcelaModel.parcelaData = "19/03/2021";

    var a = parcela.verificaStatusPagamento(parcelaModel);

    // Verify that our counter starts at 0.
    expect(a, "Nao pago X.svg");
  });
}
