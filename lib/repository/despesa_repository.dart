import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emanuellemepoupe/controller/despesa_controller.dart';
import 'package:emanuellemepoupe/helperBD/despesa_helperdb.dart';
import 'package:emanuellemepoupe/model/despesa_model.dart';
import 'package:emanuellemepoupe/model/parcela_model.dart';

class DespesaRepository {
  FirebaseFirestore db = FirebaseFirestore.instance;
  //final db = Firestore.instance;
  DespesaModel despesaModel;
  ParcelaModel parcelas;
  DespesaHelper despesaHelper;
  DespesaController despesaController;

  // ignore: missing_return
  Future<DespesaModel> insertFirestore(DespesaModel despesa) async {
    await db
        .collection("despesa")
        .doc(despesa.despIdGlobal)
        .set(despesa.toMapFirebase());
  }

  // ignore: missing_return
  Future<DespesaModel> updateFirestore(DespesaModel despesa) async {
    await db
        .collection("despesa")
        .doc(despesa.despIdGlobal)
        .set(despesa.toMapFirebase());
  }

  // ignore: missing_return
  Future<DespesaModel> deleteFirestore(DespesaModel despesa) async {
    await db.collection("despesa").doc(despesa.despIdGlobal).delete();
  }

  // ignore: missing_return
  Future<DespesaModel> selectListerneFirestore() async {
    despesaController = new DespesaController();

    var despesasAdicionadasFirestore = new List<DespesaModel>();
    var despesasAlteradasFirestore = new List<DespesaModel>();
    var despesasRemovidasFirestore = new List<DespesaModel>();
    db.snapshotsInSync();
    db.collection("despesa").snapshots().listen((snapshots) {
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
