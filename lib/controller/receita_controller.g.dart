// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receita_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ReceitaController on _ReceitaControllerBase, Store {
  final _$receitaModelAtom = Atom(name: '_ReceitaControllerBase.receitaModel');

  @override
  ReceitaModel get receitaModel {
    _$receitaModelAtom.reportRead();
    return super.receitaModel;
  }

  @override
  set receitaModel(ReceitaModel value) {
    _$receitaModelAtom.reportWrite(value, super.receitaModel, () {
      super.receitaModel = value;
    });
  }

  @override
  ObservableFuture atualizeReceita() {
    final _$future = super.atualizeReceita();
    return ObservableFuture(_$future);
  }

  @override
  ObservableFuture deleteRegistro(ReceitaModel receita) {
    final _$future = super.deleteRegistro(receita);
    return ObservableFuture(_$future);
  }

  @override
  ObservableFuture<List<dynamic>> obtentaListaDeParcelasPorId(String id) {
    final _$future = super.obtentaListaDeParcelasPorId(id);
    return ObservableFuture<List<dynamic>>(_$future);
  }

  @override
  ObservableFuture<List<dynamic>> obtentaListaDeParcelas(String id) {
    final _$future = super.obtentaListaDeParcelas(id);
    return ObservableFuture<List<dynamic>>(_$future);
  }

  @override
  ObservableFuture insiraNovaReceitaFirebase(
      List<ReceitaModel> receitaAddFirestore) {
    final _$future = super.insiraNovaReceitaFirebase(receitaAddFirestore);
    return ObservableFuture(_$future);
  }

  @override
  ObservableFuture deleteRegistroFirestore(
      List<ReceitaModel> despesaAddFirestore) {
    final _$future = super.deleteRegistroFirestore(despesaAddFirestore);
    return ObservableFuture(_$future);
  }

  @override
  ObservableFuture<List<ReceitaModel>> obtenhaRegistroPorMes(
      List<ReceitaModel> listaDespesas,
      [String anoMes]) {
    final _$future = super.obtenhaRegistroPorMes(listaDespesas, anoMes);
    return ObservableFuture<List<ReceitaModel>>(_$future);
  }

  @override
  String toString() {
    return '''
receitaModel: ${receitaModel}
    ''';
  }
}
