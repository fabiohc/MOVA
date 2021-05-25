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
     /*  if (onError.code == "user-not-found") {
          return "Não há registro de usuário correspondente a este identificador.";
        } else if (onError.code == "wrong-password") {
          return "A senha é inválida ou o usuário não possui uma senha.";
        } else if (onError.code == "invalid-email") {
          return "O endereço de e-mail está formatado incorretamente";
        }*/
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
