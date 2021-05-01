import 'package:firebase_auth/firebase_auth.dart';
import 'package:emanuellemepoupe/model/usuario_model.dart';

class LoginUser {
  FirebaseAuth auth = FirebaseAuth.instance;

  login(UsuarioModel _usuario) async => auth
          .signInWithEmailAndPassword(
              email: _usuario.email, password: _usuario.senha)
          .then((firebaseUser) async {
        return true;
      }).catchError((onError) {
        return false;
      });

  consulteUsuarioLogado() {
    User ehUsuarioLogado = auth.currentUser;
    if (ehUsuarioLogado != null) {
      return true;
    }
    return false;
  }

  deslogarUsuario() {
    auth.signOut();
  }
}
