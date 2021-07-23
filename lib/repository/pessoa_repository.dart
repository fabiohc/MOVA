import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emanuellemepoupe/controller/pessoa_controller.dart';
import 'package:emanuellemepoupe/model/pessoa_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class PessoaRepository {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

  PessoaModel pessoaModel;
  PessoaController pessoaController;

  // ignore: missing_return
  Future<PessoaModel> insertFirestore(PessoaModel pessoa) async {
    User ehUsuarioLogado = auth.currentUser;
    await db
        .collection("usuarios")
        .doc(ehUsuarioLogado.email)
        .collection("pessoa")
        .doc(pessoa.pessoaIdGlobal)
        .set(pessoa.toMapFirebase());
  }

  // ignore: missing_return
  Future<PessoaModel> updateFirestore(PessoaModel pessoa) async {
    User ehUsuarioLogado = auth.currentUser;
    await db
        .collection("usuarios")
        .doc(ehUsuarioLogado.email)
        .collection("pessoa")
        .doc(pessoa.pessoaIdGlobal)
        .set(pessoa.toMapFirebase());
  }

  // ignore: missing_return
  Future<PessoaModel> deleteFirestore(PessoaModel pessoa) async {
    User ehUsuarioLogado = auth.currentUser;
    await db
        .collection("usuarios")
        .doc(ehUsuarioLogado.email)
        .collection("pessoa")
        .doc(pessoa.pessoaIdGlobal)
        .delete();
  }

  // ignore: missing_return
  insiraImagem(File imagem) async {
    try {
      User ehUsuarioLogado = auth.currentUser;

      FirebaseStorage db = FirebaseStorage.instance;
      Reference pastaRaiz = db.ref();
      Reference arquivo = pastaRaiz
          .child("perfil_cliente")
          .child(ehUsuarioLogado.uid)
          .child(DateTime.now().microsecondsSinceEpoch.toString());

      arquivo.putFile(imagem);
      TaskSnapshot taskSnapshot;

      return taskSnapshot.ref.getDownloadURL();
    } catch (e) {
      return "erro";
    }
  }

  // ignore: missing_return
  Future<PessoaModel> selectListerneFirestore() async {
    User ehUsuarioLogado = auth.currentUser;
    pessoaController = new PessoaController();

    var pessoasAdicionadasFirestore = <PessoaModel>[];
    var pessoasAlteradasFirestore = <PessoaModel>[];
    var pessoasRemovidasFirestore = <PessoaModel>[];
    db.snapshotsInSync();
    db
        .collection("usuarios")
        .doc(ehUsuarioLogado.email)
        .collection("pessoa")
        .snapshots()
        .listen((snapshots) {
      pessoasAdicionadasFirestore.clear();
      pessoasAlteradasFirestore.clear();
      pessoasRemovidasFirestore.clear();

      snapshots.docChanges.forEach((documento) {
        if (documento.type == DocumentChangeType.added) {
          print("document: ${documento.doc.id}" +
              "${documento.doc.data()} added");

          var pessoasAdicionadas = new PessoaModel();
          pessoasAdicionadas = PessoaModel.fromMap(documento.doc.data(), true);

          pessoasAdicionadasFirestore.add(pessoasAdicionadas);
        } else if (documento.type == DocumentChangeType.modified) {
          print("document: ${documento.doc.id}" +
              "${documento.doc.data()} modified");

          final pessoasAlteradas =
              PessoaModel.fromMap(documento.doc.data(), true);
          pessoasAlteradasFirestore.add(pessoasAlteradas);
        } else if (documento.type == DocumentChangeType.removed) {
          print("document: ${documento.doc.id}" +
              "${documento.doc.data()} removed");

          final pessoasRemovida =
              PessoaModel.fromMap(documento.doc.data(), true);
          pessoasRemovidasFirestore.add(pessoasRemovida);
        }
      });
      if (pessoasAdicionadasFirestore.length > 0)
        pessoaController.insiraNovapessoaFirebase(pessoasAdicionadasFirestore);

      if (pessoasAlteradasFirestore.length > 0)
        pessoaController.atualizepessoaFirebase(pessoasAlteradasFirestore);

      if (pessoasRemovidasFirestore.length > 0)
        pessoaController.deleteRegistroFirestore(pessoasRemovidasFirestore);
    });
  }
}
