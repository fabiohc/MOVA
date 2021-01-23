// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'carteira_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CarteiraModel on _CarteiraModelBase, Store {
  final _$dataAtom = Atom(name: '_CarteiraModelBase.data');

  @override
  String get data {
    _$dataAtom.reportRead();
    return super.data;
  }

  @override
  set data(String value) {
    _$dataAtom.reportWrite(value, super.data, () {
      super.data = value;
    });
  }

  final _$valorAtom = Atom(name: '_CarteiraModelBase.valor');

  @override
  double get valor {
    _$valorAtom.reportRead();
    return super.valor;
  }

  @override
  set valor(double value) {
    _$valorAtom.reportWrite(value, super.valor, () {
      super.valor = value;
    });
  }

  final _$parcelaAtom = Atom(name: '_CarteiraModelBase.parcela');

  @override
  int get parcela {
    _$parcelaAtom.reportRead();
    return super.parcela;
  }

  @override
  set parcela(int value) {
    _$parcelaAtom.reportWrite(value, super.parcela, () {
      super.parcela = value;
    });
  }

  final _$parcelaQuatParcAtom =
      Atom(name: '_CarteiraModelBase.parcelaQuatParc');

  @override
  int get parcelaQuatParc {
    _$parcelaQuatParcAtom.reportRead();
    return super.parcelaQuatParc;
  }

  @override
  set parcelaQuatParc(int value) {
    _$parcelaQuatParcAtom.reportWrite(value, super.parcelaQuatParc, () {
      super.parcelaQuatParc = value;
    });
  }

  final _$tipoAtom = Atom(name: '_CarteiraModelBase.tipo');

  @override
  String get tipo {
    _$tipoAtom.reportRead();
    return super.tipo;
  }

  @override
  set tipo(String value) {
    _$tipoAtom.reportWrite(value, super.tipo, () {
      super.tipo = value;
    });
  }

  final _$statusAtom = Atom(name: '_CarteiraModelBase.status');

  @override
  bool get status {
    _$statusAtom.reportRead();
    return super.status;
  }

  @override
  set status(bool value) {
    _$statusAtom.reportWrite(value, super.status, () {
      super.status = value;
    });
  }

  final _$_CarteiraModelBaseActionController =
      ActionController(name: '_CarteiraModelBase');

  @override
  dynamic alteraData(String value) {
    final _$actionInfo = _$_CarteiraModelBaseActionController.startAction(
        name: '_CarteiraModelBase.alteraData');
    try {
      return super.alteraData(value);
    } finally {
      _$_CarteiraModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic alteraValor(double value) {
    final _$actionInfo = _$_CarteiraModelBaseActionController.startAction(
        name: '_CarteiraModelBase.alteraValor');
    try {
      return super.alteraValor(value);
    } finally {
      _$_CarteiraModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic alteraParcela(int value) {
    final _$actionInfo = _$_CarteiraModelBaseActionController.startAction(
        name: '_CarteiraModelBase.alteraParcela');
    try {
      return super.alteraParcela(value);
    } finally {
      _$_CarteiraModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic alteraQuantParcelas(int value) {
    final _$actionInfo = _$_CarteiraModelBaseActionController.startAction(
        name: '_CarteiraModelBase.alteraQuantParcelas');
    try {
      return super.alteraQuantParcelas(value);
    } finally {
      _$_CarteiraModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic alteraTipo(String value) {
    final _$actionInfo = _$_CarteiraModelBaseActionController.startAction(
        name: '_CarteiraModelBase.alteraTipo');
    try {
      return super.alteraTipo(value);
    } finally {
      _$_CarteiraModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic alteraStatus(bool value) {
    final _$actionInfo = _$_CarteiraModelBaseActionController.startAction(
        name: '_CarteiraModelBase.alteraStatus');
    try {
      return super.alteraStatus(value);
    } finally {
      _$_CarteiraModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
data: ${data},
valor: ${valor},
parcela: ${parcela},
parcelaQuatParc: ${parcelaQuatParc},
tipo: ${tipo},
status: ${status}
    ''';
  }
}
