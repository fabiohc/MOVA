// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'despesa_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$DespesaController on _DespesaControllerBase, Store {
  final _$despesaModelAtom = Atom(name: '_DespesaControllerBase.despesaModel');

  @override
  DespesaModel get despesaModel {
    _$despesaModelAtom.reportRead();
    return super.despesaModel;
  }

  @override
  set despesaModel(DespesaModel value) {
    _$despesaModelAtom.reportWrite(value, super.despesaModel, () {
      super.despesaModel = value;
    });
  }

  final _$parcelaModelAtom = Atom(name: '_DespesaControllerBase.parcelaModel');

  @override
  ParcelaModel get parcelaModel {
    _$parcelaModelAtom.reportRead();
    return super.parcelaModel;
  }

  @override
  set parcelaModel(ParcelaModel value) {
    _$parcelaModelAtom.reportWrite(value, super.parcelaModel, () {
      super.parcelaModel = value;
    });
  }

  @override
  ObservableFuture insiraNovaDespesa() {
    final _$future = super.insiraNovaDespesa();
    return ObservableFuture(_$future);
  }

  @override
  ObservableFuture atualizeDespesa() {
    final _$future = super.atualizeDespesa();
    return ObservableFuture(_$future);
  }

  @override
  ObservableFuture deleteRegistro(DespesaModel despesa) {
    final _$future = super.deleteRegistro(despesa);
    return ObservableFuture(_$future);
  }

  @override
  ObservableFuture deleteRegistroFirestore(
      List<DespesaModel> despesaAddFirestore) {
    final _$future = super.deleteRegistroFirestore(despesaAddFirestore);
    return ObservableFuture(_$future);
  }

  @override
  ObservableFuture<List<dynamic>> obtentaListaDespesas() {
    final _$future = super.obtentaListaDespesas();
    return ObservableFuture<List<dynamic>>(_$future);
  }

  @override
  ObservableFuture insiraNovaDespesaFirebase(
      List<DespesaModel> despesaAddFirestore) {
    final _$future = super.insiraNovaDespesaFirebase(despesaAddFirestore);
    return ObservableFuture(_$future);
  }

  @override
  ObservableFuture<List<dynamic>> obtentaListaDeParcelasPorId(String id) {
    final _$future = super.obtentaListaDeParcelasPorId(id);
    return ObservableFuture<List<dynamic>>(_$future);
  }

  @override
  ObservableFuture<List<dynamic>> obtentaListaDeParcela(String id) {
    final _$future = super.obtentaListaDeParcela(id);
    return ObservableFuture<List<dynamic>>(_$future);
  }

  @override
  String toString() {
    return '''
despesaModel: ${despesaModel},
parcelaModel: ${parcelaModel}
    ''';
  }
}
