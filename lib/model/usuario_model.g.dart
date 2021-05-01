// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usuario_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UsuarioModel on _UsuarioModelBase, Store {
  final _$idAtom = Atom(name: '_UsuarioModelBase.id');

  @override
  int get id {
    _$idAtom.reportRead();
    return super.id;
  }

  @override
  set id(int value) {
    _$idAtom.reportWrite(value, super.id, () {
      super.id = value;
    });
  }

  final _$nomeAtom = Atom(name: '_UsuarioModelBase.nome');

  @override
  String get nome {
    _$nomeAtom.reportRead();
    return super.nome;
  }

  @override
  set nome(String value) {
    _$nomeAtom.reportWrite(value, super.nome, () {
      super.nome = value;
    });
  }

  final _$emailAtom = Atom(name: '_UsuarioModelBase.email');

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  final _$senhaAtom = Atom(name: '_UsuarioModelBase.senha');

  @override
  String get senha {
    _$senhaAtom.reportRead();
    return super.senha;
  }

  @override
  set senha(String value) {
    _$senhaAtom.reportWrite(value, super.senha, () {
      super.senha = value;
    });
  }

  final _$_UsuarioModelBaseActionController =
      ActionController(name: '_UsuarioModelBase');

  @override
  dynamic alteraId(int value) {
    final _$actionInfo = _$_UsuarioModelBaseActionController.startAction(
        name: '_UsuarioModelBase.alteraId');
    try {
      return super.alteraId(value);
    } finally {
      _$_UsuarioModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic alteraNome(String value) {
    final _$actionInfo = _$_UsuarioModelBaseActionController.startAction(
        name: '_UsuarioModelBase.alteraNome');
    try {
      return super.alteraNome(value);
    } finally {
      _$_UsuarioModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic alteraEmail(String value) {
    final _$actionInfo = _$_UsuarioModelBaseActionController.startAction(
        name: '_UsuarioModelBase.alteraEmail');
    try {
      return super.alteraEmail(value);
    } finally {
      _$_UsuarioModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic alteraSenha(String value) {
    final _$actionInfo = _$_UsuarioModelBaseActionController.startAction(
        name: '_UsuarioModelBase.alteraSenha');
    try {
      return super.alteraSenha(value);
    } finally {
      _$_UsuarioModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
id: ${id},
nome: ${nome},
email: ${email},
senha: ${senha}
    ''';
  }
}
