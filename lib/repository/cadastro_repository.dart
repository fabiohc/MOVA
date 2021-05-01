import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:emanuellemepoupe/model/usuario_model.dart';

class CadastreUser {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

  casdastreUsuario(UsuarioModel _usuario) async => auth
          .createUserWithEmailAndPassword(
              email: _usuario.email, password: _usuario.senha)
          .then((user) async {
        return true;
      }).catchError((onError) {
        return false;
      });
}
