import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emanuellemepoupe/controller/receita_controller.dart';
import 'package:emanuellemepoupe/model/receita_model.dart';

class ReceitaRepository {
  FirebaseFirestore db = FirebaseFirestore.instance;
  //final db = Firestore.instance;
  ReceitaModel receitaModel;
  ReceitaController receitaController;
  // ignore: missing_return
  Future<ReceitaModel> insertFirestore(ReceitaModel receita) async {
    await db
        .collection("receita")
        .doc(receita.recIdGlobal)
        .set(receita.toMapFirebase());
  }

  // ignore: missing_return
  Future<ReceitaModel> updateFirestore(ReceitaModel receita) async {
    await db
        .collection("receita")
        .doc(receita.recIdGlobal)
        .set(receita.toMapFirebase());
  }

  // ignore: missing_return
  Future<ReceitaModel> deleteFirestore(ReceitaModel receita) async {
    await db.collection("receita").doc(receita.recIdGlobal).delete();
  }

  // ignore: missing_return
  Future<ReceitaModel> selectListerneFirestore() async {
    receitaController = new ReceitaController();

    var receitasAdicionadasFirestore = new List<ReceitaModel>();
    var receitasAlteradasFirestore = new List<ReceitaModel>();
    var receitasRemovidasFirestore = new List<ReceitaModel>();
    db.snapshotsInSync();
    db.collection("receita").snapshots().listen((snapshots) {
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
