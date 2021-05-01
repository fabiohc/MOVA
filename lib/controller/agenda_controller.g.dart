// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agenda_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AgendaController on _AgendaControllerBase, Store {
  final _$agendaModelAtom = Atom(name: '_AgendaControllerBase.agendaModel');

  @override
  AgendaModel get agendaModel {
    _$agendaModelAtom.reportRead();
    return super.agendaModel;
  }

  @override
  set agendaModel(AgendaModel value) {
    _$agendaModelAtom.reportWrite(value, super.agendaModel, () {
      super.agendaModel = value;
    });
  }

  @override
  String toString() {
    return '''
agendaModel: ${agendaModel}
    ''';
  }
}
