// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pessoa_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PessoaController on _PessoaControllerBase, Store {
  Computed<bool> _$isValidComputed;

  @override
  bool get isValid => (_$isValidComputed ??= Computed<bool>(() => super.isValid,
          name: '_PessoaControllerBase.isValid'))
      .value;

  final _$pessoaHelperAtom = Atom(name: '_PessoaControllerBase.pessoaHelper');

  @override
  PessoaHelper get pessoaHelper {
    _$pessoaHelperAtom.reportRead();
    return super.pessoaHelper;
  }

  @override
  set pessoaHelper(PessoaHelper value) {
    _$pessoaHelperAtom.reportWrite(value, super.pessoaHelper, () {
      super.pessoaHelper = value;
    });
  }

  final _$pessoaModelAtom = Atom(name: '_PessoaControllerBase.pessoaModel');

  @override
  PessoaModel get pessoaModel {
    _$pessoaModelAtom.reportRead();
    return super.pessoaModel;
  }

  @override
  set pessoaModel(PessoaModel value) {
    _$pessoaModelAtom.reportWrite(value, super.pessoaModel, () {
      super.pessoaModel = value;
    });
  }

  @override
  ObservableFuture inserirPessoa() {
    final _$future = super.inserirPessoa();
    return ObservableFuture(_$future);
  }

  @override
  ObservableFuture atualizePessoa() {
    final _$future = super.atualizePessoa();
    return ObservableFuture(_$future);
  }

  @override
  ObservableFuture deletePessoa(PessoaModel pessoa) {
    final _$future = super.deletePessoa(pessoa);
    return ObservableFuture(_$future);
  }

  @override
  ObservableFuture<List<dynamic>> obtentaListaPessoas() {
    final _$future = super.obtentaListaPessoas();
    return ObservableFuture<List<dynamic>>(_$future);
  }

  @override
  ObservableFuture<PessoaModel> obtentaPessoasPorID(String pessoaIdGlobal) {
    final _$future = super.obtentaPessoasPorID(pessoaIdGlobal);
    return ObservableFuture<PessoaModel>(_$future);
  }

  @override
  String toString() {
    return '''
pessoaHelper: ${pessoaHelper},
pessoaModel: ${pessoaModel},
isValid: ${isValid}
    ''';
  }
}
