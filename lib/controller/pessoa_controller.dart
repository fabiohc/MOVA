import 'package:emanuellemepoupe/controller/util.dart';
import 'package:emanuellemepoupe/helperBD/pessoa_helperdb.dart';
import 'package:emanuellemepoupe/model/pessoa_model.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'pessoa_controller.g.dart';

class PessoaController = _PessoaControllerBase with _$PessoaController;

abstract class _PessoaControllerBase with Store {
  @observable
  var pessoaHelper = PessoaHelper();

  @observable
  var pessoaModel = PessoaModel();

  var util = Util();

  var pessoa = ValueNotifier<PessoaModel>(PessoaModel());
  var telefone = ValueNotifier<String>('0');
  var desc = ValueNotifier<String>('');
  var valor = ValueNotifier<String>( '');
  // var nome = ValueNotifier<String>( PessoaModel());
  // var data = ValueNotifier<String>( PessoaModel());

  mudatelefone(String value) {
    telefone.value = value;
  }

  mudavalor(String value) {
    valor.value = value;
  }

  mudadesc(String value) {
    desc.value = value;
  }

  @observable
  inserirPessoa() async {
    pessoaModel.alteraPessoaIdGlobal(util.obtenhaIdGlobal("pess"));
    pessoaHelper.insert(pessoaModel);
  }

  @observable
  atualizePessoa() async {
    await pessoaHelper.update(pessoaModel);
    // if (pessoaModel.pessoaIdGlobal.isNotEmpty)
    //  await repositoryHelper.updateFirestore(pessoaModel);
  }

  @observable
  deletePessoa(PessoaModel pessoa) async {
    await pessoaHelper.delete(pessoa.pessoaIdGlobal);

    /* if (despesa.despIdGlobal.isNotEmpty)
      await repositoryHelper.deleteFirestore(despesa);*/
  }

  @observable
  Future<List> obtentaListaPessoas() async {
    List lista = await pessoaHelper.selectAll();
    return lista;
  }

  List<PessoaModel> filtreListaPessoas(List<PessoaModel> listaPessoas, filtro) {
    listaPessoas = listaPessoas
        .where((x) => x.pessoaNome.contains(filtro))
        .toSet()
        .toList();

    return listaPessoas;
  }
}
