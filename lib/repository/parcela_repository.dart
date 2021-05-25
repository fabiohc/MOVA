import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emanuellemepoupe/model/parcela_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:emanuellemepoupe/controller/parcela_controller.dart';

class ParcelaRepository {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
  ParcelaModel parcelaModel = new ParcelaModel();

  // ignore: missing_return
  Future<ParcelaModel> deleteFiresore(List<ParcelaModel> listaParcelas) async {
    User ehUsuarioLogado = auth.currentUser;
    if (listaParcelas != null)
      listaParcelas.forEach((parcela) {
        db
            .collection("usuarios")
            .doc(ehUsuarioLogado.email)
            .collection("parcelas")
            .doc(parcela.parcelaIdGlobal + parcela.parcelaNumero.toString())
            .delete();
      });
  }

  updateParcelaFirestore(ParcelaModel parcela) async {
    User ehUsuarioLogado = auth.currentUser;
    db
        .collection("usuarios")
        .doc(ehUsuarioLogado.email)
        .collection("parcelas")
        .doc(parcela.parcelaIdGlobal + parcela.parcelaNumero.toString())
        .set(parcela.toMap());
  }

// ignore: missing_return
  Future<ParcelaModel> selectListerneFirestore() async {
    var parcelaController = new ParcelaController();
    User ehUsuarioLogado = auth.currentUser;

    var parcelasAdicionadasFirestore = new List<ParcelaModel>();
    var parcelasAlteradasFirestore = new List<ParcelaModel>();
    var parcelasRemovidasFirestore = new List<ParcelaModel>();
    db.snapshotsInSync();
    db
        .collection("usuarios")
        .doc(ehUsuarioLogado.email)
        .collection("parcelas")
        .snapshots()
        .listen((snapshots) async {
      parcelasAdicionadasFirestore.clear();
      parcelasAlteradasFirestore.clear();
      parcelasRemovidasFirestore.clear();

      snapshots.docChanges.forEach((documento) {
        if (documento.type == DocumentChangeType.added) {
          print("document: Parcela:  ${documento.doc.id}" +
              "${documento.doc.data()} added");

          var despesasAdicionadas = new ParcelaModel();
          despesasAdicionadas =
              ParcelaModel.fromMap(documento.doc.data(), true);

          parcelasAdicionadasFirestore.add(despesasAdicionadas);
        } else if (documento.type == DocumentChangeType.modified) {
          print("document: ${documento.doc.id}" +
              "${documento.doc.data()} modified");

          final despesasAlteradas =
              ParcelaModel.fromMap(documento.doc.data(), true);
          parcelasAlteradasFirestore.add(despesasAlteradas);
        } else if (documento.type == DocumentChangeType.removed) {
          print("document: ${documento.doc.id}" +
              "${documento.doc.data()} removed");

          final despesasRemovida =
              ParcelaModel.fromMap(documento.doc.data(), true);
          parcelasRemovidasFirestore.add(despesasRemovida);
        }
      });
      if (parcelasAdicionadasFirestore.length > 0)
        parcelaController.insiraParcelaFirebase(parcelasAdicionadasFirestore);

      if (parcelasAlteradasFirestore.length > 0)
        parcelaController.atualizeParcelaFirebase(parcelasAlteradasFirestore);

      if (parcelasRemovidasFirestore.length > 0)
        parcelaController.deleteParcelaFirestore(parcelasRemovidasFirestore);
    });
  }
}
