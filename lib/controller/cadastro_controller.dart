import 'package:emanuellemepoupe/model/usuario_model.dart';
import 'package:emanuellemepoupe/repository/cadastro_repository.dart';
import 'package:mobx/mobx.dart';
part 'cadastro_controller.g.dart';

class CadastroController = _CadastroControllerBase with _$CadastroController;

abstract class _CadastroControllerBase with Store {
  var servico = CadastreUser();

  var usuarioModel = UsuarioModel();

  @computed
  bool get isValid {
    return valideEmail() == null &&
        valideNome() == null &&
        valideSenha() == null;
  }

  String valideNome() {
    if (usuarioModel.nome == null || usuarioModel.nome.isEmpty)
      return "O nome é obrigatório";

    return null;
  }

  String valideEmail() {
    if (usuarioModel.email == null || usuarioModel.email.isEmpty)
      return "O E-mail é obrigatório";

    return null;
  }

  String valideSenha() {
    if (usuarioModel.senha == null || usuarioModel.senha.isEmpty)
      return "O senha é obrigatório";

    return null;
  }

  void cadastreUsuario() {
    usuarioModel.nome;
    usuarioModel.email;
    usuarioModel.senha;
    servico.casdastreUsuario(usuarioModel);
  }
}
