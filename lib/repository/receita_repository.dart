import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emanuellemepoupe/controller/receita_controller.dart';
import 'package:emanuellemepoupe/model/receita_model.dart';
import 'package:emanuellemepoupe/model/parcela_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ReceitaRepository {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
  ReceitaModel receitaModel;
  ReceitaController receitaController;
  // ignore: missing_return
  Future<ReceitaModel> insertFirestore(ReceitaModel receita) async {
    User ehUsuarioLogado = auth.currentUser;
    await db
        .collection("usuarios")
        .doc(ehUsuarioLogado.email)
        .collection("receita")
        .doc(receita.recIdGlobal)
        .set(receita.toMapFirebase());

/*Inserindo parcelas */
    if (receita.parcelaModel != null) {
      receita.parcelaModel.forEach((parcela) {
        db
            .collection("usuarios")
            .doc(ehUsuarioLogado.email)
            .collection("receita")
            .doc(receita.recIdGlobal)
            .collection("parcelas")
            .doc(parcela.parcelaNumero.toString())
            .set(parcela.toMap());
      });
    }
    /*Inserindo cliente vinculado a despesa */
    if (receita.pessoaModel != null) {
      db
          .collection("usuarios")
          .doc(ehUsuarioLogado.email)
          .collection("receita")
          .doc(receita.recIdGlobal)
          .collection("cliente")
          .doc(receita.pessoaModel.pessoaIdGlobal.toString())
          .set(receita.pessoaModel.toMap());
    }
  }

  // ignore: missing_return
  Future<ReceitaModel> updateFirestore(ReceitaModel receita) async {
    User ehUsuarioLogado = auth.currentUser;
    await db
        .collection("usuarios")
        .doc(ehUsuarioLogado.email)
        .collection("receita")
        .doc(receita.recIdGlobal)
        .set(receita.toMapFirebase());

    /*Inserindo parcelas */
    if (receita.parcelaModel != null) {
      receita.parcelaModel.forEach((parcela) {
        db
            .collection("usuarios")
            .doc(ehUsuarioLogado.email)
            .collection("receita")
            .doc(receita.recIdGlobal)
            .collection("parcelas")
            .doc(parcela.parcelaNumero.toString())
            .set(parcela.toMap());
      });
    }
    /*Inserindo cliente vinculado a despesa */
    if (receita.pessoaModel != null) {
      db
          .collection("usuarios")
          .doc(ehUsuarioLogado.email)
          .collection("receita")
          .doc(receita.recIdGlobal)
          .collection("cliente")
          .doc(receita.pessoaModel.pessoaIdGlobal.toString())
          .set(receita.pessoaModel.toMap());
    }
  }

  // ignore: missing_return
  Future<ReceitaModel> updateParcelaFirestore(ParcelaModel parcela) async {
    User ehUsuarioLogado = auth.currentUser;
    db
        .collection("usuarios")
        .doc(ehUsuarioLogado.email)
        .collection("receita")
        .doc(parcela.parcelaIdGlobal)
        .collection("parcelas")
        .doc(parcela.parcelaNumero.toString())
        .set(parcela.toMap());
  }

  // ignore: missing_return
  Future<ReceitaModel> deleteParcelasAntesUpdateFirestore(
      ReceitaModel receita) async {
    User ehUsuarioLogado = auth.currentUser;
    if (receita.parcelaModel != null) {
      for (int numeroParcela = 1; numeroParcela <= 12; numeroParcela++) {
        db
            .collection("usuarios")
            .doc(ehUsuarioLogado.email)
            .collection("receita")
            .doc(receita.recIdGlobal)
            .collection("parcelas")
            .doc(numeroParcela.toString())
            .delete();
      }
    }
  }

  // ignore: missing_return
  Future<ReceitaModel> deleteFirestore(ReceitaModel receita) async {
    User ehUsuarioLogado = auth.currentUser;
    if (receita.pessoaModel != null) {
      db
          .collection("usuarios")
          .doc(ehUsuarioLogado.email)
          .collection("receita")
          .doc(receita.recIdGlobal)
          .collection("cliente")
          .doc(receita.pessoaModel.pessoaIdGlobal.toString())
          .delete();
    }

    if (receita.parcelaModel != null) {
      receita.parcelaModel.forEach((parcela) {
        db
            .collection("usuarios")
            .doc(ehUsuarioLogado.email)
            .collection("receita")
            .doc(receita.recIdGlobal)
            .collection("parcelas")
            .doc(parcela.parcelaNumero.toString())
            .delete();
      });
    }

    await db.collection("receita").doc(receita.recIdGlobal).delete();
  }

  // ignore: missing_return
  Future<ReceitaModel> selectListerneFirestore() async {
    User ehUsuarioLogado = auth.currentUser;
    receitaController = new ReceitaController();

    var receitasAdicionadasFirestore = new List<ReceitaModel>();
    var receitasAlteradasFirestore = new List<ReceitaModel>();
    var receitasRemovidasFirestore = new List<ReceitaModel>();
    db.snapshotsInSync();

    db
        .collection("usuarios")
        .doc(ehUsuarioLogado.email)
        .collection("receita")
        .snapshots()
        .listen((snapshots) {
      receitasAdicionadasFirestore.clear();
      receitasAlteradasFirestore.clear();
      receitasRemovidasFirestore.clear();

      snapshots.docChanges.forEach((documento) {
        if (documento.type == DocumentChangeType.added) {
          print("document: ${documento.doc.id}" +
              "${documento.doc.data()} added");

          var receitasAdicionadas = new ReceitaModel();
          receitasAdicionadas =
              ReceitaModel.fromMap(documento.doc.data(), true);

          receitasAdicionadasFirestore.add(receitasAdicionadas);
        } else if (documento.type == DocumentChangeType.modified) {
          print("document: ${documento.doc.id}" +
              "${documento.doc.data()} modified");

          final receitasAlteradas =
              ReceitaModel.fromMap(documento.doc.data(), true);
          receitasAlteradasFirestore.add(receitasAlteradas);
        } else if (documento.type == DocumentChangeType.removed) {
          print("document: ${documento.doc.id}" +
              "${documento.doc.data()} removed");

          final receitasRemovida =
              ReceitaModel.fromMap(documento.doc.data(), true);
          receitasRemovidasFirestore.add(receitasRemovida);
        }
      });
      if (receitasAdicionadasFirestore.length > 0)
        receitaController
            .insiraNovaReceitaFirebase(receitasAdicionadasFirestore);

      if (receitasAlteradasFirestore.length > 0)
        receitaController.atualizeReceitaFirebase(receitasAlteradasFirestore);

      if (receitasRemovidasFirestore.length > 0)
        receitaController.deleteRegistroFirestore(receitasRemovidasFirestore);
    });
  }
}
