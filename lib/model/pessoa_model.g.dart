// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pessoa_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PessoaModel on _PessoaModelBase, Store {
  final _$pessoaIdAtom = Atom(name: '_PessoaModelBase.pessoaId');

  @override
  int get pessoaId {
    _$pessoaIdAtom.reportRead();
    return super.pessoaId;
  }

  @override
  set pessoaId(int value) {
    _$pessoaIdAtom.reportWrite(value, super.pessoaId, () {
      super.pessoaId = value;
    });
  }

  final _$pessoaIdGlobalAtom = Atom(name: '_PessoaModelBase.pessoaIdGlobal');

  @override
  String get pessoaIdGlobal {
    _$pessoaIdGlobalAtom.reportRead();
    return super.pessoaIdGlobal;
  }

  @override
  set pessoaIdGlobal(String value) {
    _$pessoaIdGlobalAtom.reportWrite(value, super.pessoaIdGlobal, () {
      super.pessoaIdGlobal = value;
    });
  }

  final _$pessoaNomeAtom = Atom(name: '_PessoaModelBase.pessoaNome');

  @override
  String get pessoaNome {
    _$pessoaNomeAtom.reportRead();
    return super.pessoaNome;
  }

  @override
  set pessoaNome(String value) {
    _$pessoaNomeAtom.reportWrite(value, super.pessoaNome, () {
      super.pessoaNome = value;
    });
  }

  final _$pessoaDataNascimentoAtom =
      Atom(name: '_PessoaModelBase.pessoaDataNascimento');

  @override
  String get pessoaDataNascimento {
    _$pessoaDataNascimentoAtom.reportRead();
    return super.pessoaDataNascimento;
  }

  @override
  set pessoaDataNascimento(String value) {
    _$pessoaDataNascimentoAtom.reportWrite(value, super.pessoaDataNascimento,
        () {
      super.pessoaDataNascimento = value;
    });
  }

  final _$pessoaEmailAtom = Atom(name: '_PessoaModelBase.pessoaEmail');

  @override
  String get pessoaEmail {
    _$pessoaEmailAtom.reportRead();
    return super.pessoaEmail;
  }

  @override
  set pessoaEmail(String value) {
    _$pessoaEmailAtom.reportWrite(value, super.pessoaEmail, () {
      super.pessoaEmail = value;
    });
  }

  final _$pessoaTelefoneAtom = Atom(name: '_PessoaModelBase.pessoaTelefone');

  @override
  String get pessoaTelefone {
    _$pessoaTelefoneAtom.reportRead();
    return super.pessoaTelefone;
  }

  @override
  set pessoaTelefone(String value) {
    _$pessoaTelefoneAtom.reportWrite(value, super.pessoaTelefone, () {
      super.pessoaTelefone = value;
    });
  }

  final _$pessoaCpfAtom = Atom(name: '_PessoaModelBase.pessoaCpf');

  @override
  String get pessoaCpf {
    _$pessoaCpfAtom.reportRead();
    return super.pessoaCpf;
  }

  @override
  set pessoaCpf(String value) {
    _$pessoaCpfAtom.reportWrite(value, super.pessoaCpf, () {
      super.pessoaCpf = value;
    });
  }

  final _$_PessoaModelBaseActionController =
      ActionController(name: '_PessoaModelBase');

  @override
  dynamic alteraPessoaId(int value) {
    final _$actionInfo = _$_PessoaModelBaseActionController.startAction(
        name: '_PessoaModelBase.alteraPessoaId');
    try {
      return super.alteraPessoaId(value);
    } finally {
      _$_PessoaModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic alteraPessoaIdGlobal(String value) {
    final _$actionInfo = _$_PessoaModelBaseActionController.startAction(
        name: '_PessoaModelBase.alteraPessoaIdGlobal');
    try {
      return super.alteraPessoaIdGlobal(value);
    } finally {
      _$_PessoaModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic alteraNome(String value) {
    final _$actionInfo = _$_PessoaModelBaseActionController.startAction(
        name: '_PessoaModelBase.alteraNome');
    try {
      return super.alteraNome(value);
    } finally {
      _$_PessoaModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic alteraDataNascimeto(String value) {
    final _$actionInfo = _$_PessoaModelBaseActionController.startAction(
        name: '_PessoaModelBase.alteraDataNascimeto');
    try {
      return super.alteraDataNascimeto(value);
    } finally {
      _$_PessoaModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic alteraEmail(String value) {
    final _$actionInfo = _$_PessoaModelBaseActionController.startAction(
        name: '_PessoaModelBase.alteraEmail');
    try {
      return super.alteraEmail(value);
    } finally {
      _$_PessoaModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic alterapessoaTelefone(String value) {
    final _$actionInfo = _$_PessoaModelBaseActionController.startAction(
        name: '_PessoaModelBase.alterapessoaTelefone');
    try {
      return super.alterapessoaTelefone(value);
    } finally {
      _$_PessoaModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic alteraCPF(String value) {
    final _$actionInfo = _$_PessoaModelBaseActionController.startAction(
        name: '_PessoaModelBase.alteraCPF');
    try {
      return super.alteraCPF(value);
    } finally {
      _$_PessoaModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
pessoaId: ${pessoaId},
pessoaIdGlobal: ${pessoaIdGlobal},
pessoaNome: ${pessoaNome},
pessoaDataNascimento: ${pessoaDataNascimento},
pessoaEmail: ${pessoaEmail},
pessoaTelefone: ${pessoaTelefone},
pessoaCpf: ${pessoaCpf}
    ''';
  }
}
