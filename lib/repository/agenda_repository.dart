import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emanuellemepoupe/model/agenda_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:emanuellemepoupe/controller/agenda_controller.dart';

class AgendaRepository {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
  AgendaModel agendaModel = new AgendaModel();

  insertFirestore(AgendaModel agenda) async {
    User ehUsuarioLogado = auth.currentUser;
    await db
        .collection("usuarios")
        .doc(ehUsuarioLogado.email)
        .collection("agenda")
        .doc(agenda.agenIdGlobal)
        .set(agenda.toMap());
  }

   updateFirestore(AgendaModel agenda) async {
    User ehUsuarioLogado = auth.currentUser;
    await db
        .collection("usuarios")
        .doc(ehUsuarioLogado.email)
        .collection("agenda")
        .doc(agenda.agenIdGlobal)
        .set(agenda.toMap());
  }


  deleteFirestore(AgendaModel agenda) async {
    User ehUsuarioLogado = auth.currentUser;
    await db
        .collection("usuarios")
        .doc(ehUsuarioLogado.email)
        .collection("agenda")
        .doc(agenda.agenIdGlobal)
        .delete();
  }

  // ignore: missing_return
  Future<AgendaModel> selectListerneFirestore() async {
    User ehUsuarioLogado = auth.currentUser;
    var agendaController = new AgendaController();

    var agendaAdicionadasFirestore = <AgendaModel>[];
    var agendaAlteradasFirestore =  <AgendaModel>[];
    var agendaRemovidasFirestore = <AgendaModel>[];
    db.snapshotsInSync();
    db
        .collection("usuarios")
        .doc(ehUsuarioLogado.email)
        .collection("agenda")
        .snapshots()
        .listen((snapshots) {
      agendaAdicionadasFirestore.clear();
      agendaAlteradasFirestore.clear();
      agendaRemovidasFirestore.clear();

      snapshots.docChanges.forEach((documento) {
        if (documento.type == DocumentChangeType.added) {
          print("document: ${documento.doc.id}" +
              "${documento.doc.data()} added");

          var agendaAdicionadas = new AgendaModel();
          agendaAdicionadas = AgendaModel.fromMap(documento.doc.data());

          agendaAdicionadasFirestore.add(agendaAdicionadas);
        } else if (documento.type == DocumentChangeType.modified) {
          print("document: ${documento.doc.id}" +
              "${documento.doc.data()} modified");

          final agendaAlteradas = AgendaModel.fromMap(documento.doc.data());
          agendaAlteradasFirestore.add(agendaAlteradas);
        } else if (documento.type == DocumentChangeType.removed) {
          print("document: ${documento.doc.id}" +
              "${documento.doc.data()} removed");

          final pessoasRemovida = AgendaModel.fromMap(documento.doc.data());
          agendaRemovidasFirestore.add(pessoasRemovida);
        }
      });
      if (agendaAdicionadasFirestore.length > 0)
        agendaController.insiraNovoEventoFirebase(agendaAdicionadasFirestore);

      if (agendaAlteradasFirestore.length > 0)
        agendaController.atualizeEventoFirebase(agendaAlteradasFirestore);

      if (agendaRemovidasFirestore.length > 0)
        agendaController.deleteRegistroFirestore(agendaRemovidasFirestore);
    });
  }
}
