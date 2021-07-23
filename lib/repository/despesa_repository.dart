import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emanuellemepoupe/controller/despesa_controller.dart';
import 'package:emanuellemepoupe/helperBD/despesa_helperdb.dart';
import 'package:emanuellemepoupe/model/despesa_model.dart';
import 'package:emanuellemepoupe/model/parcela_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DespesaRepository {
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  DespesaModel despesaModel;
  ParcelaModel parcelas;
  DespesaHelper despesaHelper;
  DespesaController despesaController;

  // ignore: missing_return
  Future<DespesaModel> insertFirestore(DespesaModel despesa) async {
/*Inserindo despesa */

    User ehUsuarioLogado = auth.currentUser;

    await db
        .collection("usuarios")
        .doc(ehUsuarioLogado.email)
        .collection("despesa")
        .doc(despesa.despIdGlobal)
        .set(despesa.toMapFirebase());

/*Inserindo parcelas */
    if (despesa.parcelaModel != null) {
      despesa.parcelaModel.forEach((parcela) {
        /*Inserindo parcela na tabela parcelas */
        db
            .collection("usuarios")
            .doc(ehUsuarioLogado.email)
            .collection("parcelas")
            .doc(parcela.parcelaIdGlobal + parcela.parcelaNumero.toString())
            .set(parcela.toMap());

        /*Inserindo parcela na tabela despesa/parcelas */
        db
            .collection("usuarios")
            .doc(ehUsuarioLogado.email)
            .collection("despesa")
            .doc(despesa.despIdGlobal)
            .collection("parcelas")
            .doc(parcela.parcelaNumero.toString())
            .set(parcela.toMap());
      });
    }
    /*Inserindo cliente vinculado a despesa */
    if (despesa.pessoaModel != null) if (despesa.pessoaModel.pessoaIdGlobal !=
        null) {
      db
          .collection("usuarios")
          .doc(ehUsuarioLogado.email)
          .collection("despesa")
          .doc(despesa.despIdGlobal)
          .collection("cliente")
          .doc(despesa.pessoaModel.pessoaIdGlobal.toString())
          .set(despesa.pessoaModel.toMap());
    }
  }

  // ignore: missing_return
  Future<DespesaModel> updateFirestore(DespesaModel despesa) async {
    User ehUsuarioLogado = auth.currentUser;
    await db
        .collection("usuarios")
        .doc(ehUsuarioLogado.email)
        .collection("despesa")
        .doc(despesa.despIdGlobal)
        .set(despesa.toMapFirebase());

/*Inserindo parcelas */
    if (despesa.parcelaModel != null) {
      despesa.parcelaModel.forEach((parcela) {
        db
            .collection("usuarios")
            .doc(ehUsuarioLogado.email)
            .collection("despesa")
            .doc(despesa.despIdGlobal)
            .collection("parcelas")
            .doc(parcela.parcelaNumero.toString())
            .set(parcela.toMap());
      });
    }
    /*Inserindo cliente vinculado a despesa */
    if (despesa.pessoaModel != null) {
      db
          .collection("usuarios")
          .doc(ehUsuarioLogado.email)
          .collection("despesa")
          .doc(despesa.despIdGlobal)
          .collection("cliente")
          .doc(despesa.pessoaModel.pessoaIdGlobal.toString())
          .set(despesa.pessoaModel.toMap());
    }
  }

  // ignore: missing_return
  Future<DespesaModel> updateParcelaFirestore(ParcelaModel parcela) async {
    User ehUsuarioLogado = auth.currentUser;
    db
        .collection("usuarios")
        .doc(ehUsuarioLogado.email)
        .collection("despesa")
        .doc(parcela.parcelaIdGlobal)
        .collection("parcelas")
        .doc(parcela.parcelaNumero.toString())
        .set(parcela.toMap());
  }

  // ignore: missing_return
  Future<DespesaModel> deleteParcelasAntesUpdateFirestore(
      DespesaModel despesa) async {
    User ehUsuarioLogado = auth.currentUser;
    if (despesa.parcelaModel != null) {
      for (int numeroParcela = 1; numeroParcela <= 12; numeroParcela++) {
        db
            .collection("usuarios")
            .doc(ehUsuarioLogado.email)
            .collection("despesa")
            .doc(despesa.despIdGlobal)
            .collection("parcelas")
            .doc(numeroParcela.toString())
            .delete();
      }
    }
  }

  // ignore: missing_return
  Future<DespesaModel> deleteFirestore(DespesaModel despesa) async {
    User ehUsuarioLogado = auth.currentUser;
    if (despesa.pessoaModel != null) {
      await db
          .collection("usuarios")
          .doc(ehUsuarioLogado.email)
          .collection("despesa")
          .doc(despesa.despIdGlobal)
          .collection("cliente")
          .doc(despesa.pessoaModel.pessoaIdGlobal.toString())
          .delete();
    }

    if (despesa.parcelaModel != null) {
      despesa.parcelaModel.forEach((parcela) async {
        await db
            .collection("usuarios")
            .doc(ehUsuarioLogado.email)
            .collection("despesa")
            .doc(despesa.despIdGlobal)
            .collection("parcelas")
            .doc(parcela.parcelaNumero.toString())
            .delete();
      });
    }

    await db
        .collection("usuarios")
        .doc(ehUsuarioLogado.email)
        .collection("despesa")
        .doc(despesa.despIdGlobal)
        .delete();
  }

  // ignore: missing_return
  Future<DespesaModel> selectListerneFirestore() async {
    despesaController = new DespesaController();
    User ehUsuarioLogado = auth.currentUser;

    var despesasAdicionadasFirestore = <DespesaModel>[];
    var despesasAlteradasFirestore = <DespesaModel>[];
    var despesasRemovidasFirestore = <DespesaModel>[];
    db.snapshotsInSync();
    db
        .collection("usuarios")
        .doc(ehUsuarioLogado.email)
        .collection("despesa")
        .snapshots()
        .listen((snapshots) {
      despesasAdicionadasFirestore.clear();
      despesasAlteradasFirestore.clear();
      despesasRemovidasFirestore.clear();

      snapshots.docChanges.forEach((documento) {
        if (documento.type == DocumentChangeType.added) {
          print("document: ${documento.doc.id}" +
              "${documento.doc.data()} added");

          var despesasAdicionadas = new DespesaModel();
          despesasAdicionadas =
              DespesaModel.fromMap(documento.doc.data(), true);

          despesasAdicionadasFirestore.add(despesasAdicionadas);
        } else if (documento.type == DocumentChangeType.modified) {
          print("document: ${documento.doc.id}" +
              "${documento.doc.data()} modified");

          final despesasAlteradas =
              DespesaModel.fromMap(documento.doc.data(), true);
          despesasAlteradasFirestore.add(despesasAlteradas);
        } else if (documento.type == DocumentChangeType.removed) {
          print("document: ${documento.doc.id}" +
              "${documento.doc.data()} removed");

          final despesasRemovida =
              DespesaModel.fromMap(documento.doc.data(), true);
          despesasRemovidasFirestore.add(despesasRemovida);
        }
      });
      if (despesasAdicionadasFirestore.length > 0)
        despesaController
            .insiraNovaDespesaFirebase(despesasAdicionadasFirestore);

      if (despesasAlteradasFirestore.length > 0)
        despesaController.atualizeDespesaFirebase(despesasAlteradasFirestore);

      if (despesasRemovidasFirestore.length > 0)
        despesaController.deleteRegistroFirestore(despesasRemovidasFirestore);
    });
  }
}
