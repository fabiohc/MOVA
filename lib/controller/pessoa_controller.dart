import 'package:emanuellemepoupe/controller/util.dart';
import 'package:emanuellemepoupe/helperBD/pessoa_helperdb.dart';
import 'package:emanuellemepoupe/model/pessoa_model.dart';
import 'package:mobx/mobx.dart';
part 'pessoa_controller.g.dart';

class PessoaController = _PessoaControllerBase with _$PessoaController;

abstract class _PessoaControllerBase with Store {
  var pessoaHelper = PessoaHelper();
  var pessoaModel = PessoaModel();
  var util = Util();

  @observable
  inserirPessoa() async {
    pessoaHelper.insert(pessoaModel);
  }

}
