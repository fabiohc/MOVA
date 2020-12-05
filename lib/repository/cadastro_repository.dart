import 'package:firebase_auth/firebase_auth.dart';
import 'package:emanuellemepoupe/model/usuario_model.dart';

class CadastreUser {

FirebaseAuth auth = FirebaseAuth.instance;

casdastreUsuario(UsuarioModel _usuario) async => auth.createUserWithEmailAndPassword(
    email: _usuario.email,
    password: _usuario.senha
  ).then((firebaseUser){
      return " Usuário Cadastrado com sucesso";
  }).catchError((onError){
      return "erro ao cadastra usuário";
    });
  
}