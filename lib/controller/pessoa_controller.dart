import 'package:emanuellemepoupe/controller/util.dart';
import 'package:emanuellemepoupe/helperBD/pessoa_helperdb.dart';
import 'package:emanuellemepoupe/model/pessoa_model.dart';
import 'package:emanuellemepoupe/repository/pessoa_repository.dart';
import 'package:emanuellemepoupe/validacao/valide_datas.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:emanuellemepoupe/validacao/ACBrValidaCPF.dart';
import 'dart:io';

part 'pessoa_controller.g.dart';

class PessoaController = _PessoaControllerBase with _$PessoaController;

abstract class _PessoaControllerBase with Store {
  var util = Util();

  final pessoaRepository = PessoaRepository();

  @observable
  var pessoaHelper = PessoaHelper();

  @observable
  var pessoaModel = PessoaModel();

  var pessoa = ValueNotifier<PessoaModel>(PessoaModel());
  var telefone = ValueNotifier<String>('0');
  var desc = ValueNotifier<String>('');
  var valor = ValueNotifier<String>('');
  var imageUpload = ValueNotifier<bool>(false);

  mudatelefone(String value) {
    telefone.value = value;
  }

  mudavalor(String value) {
    valor.value = value;
  }

  mudadesc(String value) {
    desc.value = value;
  }

  @computed
  bool get isValid {
    return valideNome() == null &&
        valideEmail() == null &&
        valideTelefone() == null &&
        valideDataNascimento() == null &&
        valideCPF() == null;
  }

  String valideNome() {
    if (pessoaModel.pessoaNome == null ||
        pessoaModel.pessoaNome.isEmpty ||
        pessoaModel.pessoaNome.length <= 1) return "Informe um nome!";

    return null;
  }

  String valideTelefone() {
    if (pessoaModel.pessoaTelefone == null ||
        pessoaModel.pessoaTelefone.isEmpty ||
        pessoaModel.pessoaTelefone.length <= 13)
      return "Informe telefone válido!";

    return null;
  }

  String valideDataNascimento() {
    if (pessoaModel.pessoaDataNascimento == null ||
        pessoaModel.pessoaDataNascimento.isEmpty) {
      return "Informe um data válida!";
    } else if (pessoaModel.pessoaDataNascimento.length > 9) {
      return ValideDatas().validedata(pessoaModel.pessoaDataNascimento);
    }

    return null;
  }

  String valideEmail() {
    if (pessoaModel.pessoaEmail == null ||
        pessoaModel.pessoaEmail.isEmpty ||
        !pessoaModel.pessoaEmail.contains("@") ||
        !pessoaModel.pessoaEmail.contains('.') ||
        pessoaModel.pessoaEmail.length <= 3) {
      return "Informe um e-mail válido!";
    }
    return null;
  }

   valideCPF() {
    if(pessoaModel.pessoaCpf != null || pessoaModel.pessoaCpf.isNotEmpty)  {
    var cpf = pessoaModel.pessoaCpf.replaceAll('-', '').replaceAll('.', '');
    return validarCPF(cpf);
    }
  }

  @observable
  inserirPessoa() async {
    pessoaModel.alteraPessoaIdGlobal(util.obtenhaIdGlobal("pess"));

    pessoaHelper.insert(pessoaModel);

    await pessoaRepository.insertFirestore(pessoaModel);
  }

  @observable
  atualizePessoa() async {
    await pessoaHelper.update(pessoaModel);
    if (pessoaModel.pessoaIdGlobal.isNotEmpty)
      await pessoaRepository.updateFirestore(pessoaModel);
  }

  @observable
  deletePessoa(PessoaModel pessoa) async {
    await pessoaHelper.delete(pessoa.pessoaIdGlobal);

    if (pessoa.pessoaIdGlobal.isNotEmpty)
      await pessoaRepository.deleteFirestore(pessoa);
  }

  @observable
  Future<List> obtentaListaPessoas() async {
    List lista = await pessoaHelper.selectAll();
    return lista;
  }

  @observable
  Future<PessoaModel> obtentaPessoasPorID(String pessoaIdGlobal) async {
    PessoaModel pessoa = await pessoaHelper.selectById(pessoaIdGlobal);
    return pessoa;
  }

  List<PessoaModel> filtreListaPessoas(List<PessoaModel> listaPessoas, filtro) {
    listaPessoas = listaPessoas
        .where((x) => x.pessoaNome.contains(filtro))
        .toSet()
        .toList();

    return listaPessoas;
  }

  uploadImagem(File imagem) async {
    try {
      return await pessoaRepository.insiraImagem(imagem);
    } catch (e) {}
  }

  insiraNovapessoaFirebase(List<PessoaModel> pessoaAddFirestore) async {
    final List<PessoaModel> listaDespLocal = await pessoaHelper.selectAll();
    List<PessoaModel> listaNovosRegistros = [];

    if (listaDespLocal.length == 0) {
      listaNovosRegistros = pessoaAddFirestore;
    } else {
      pessoaAddFirestore.forEach((novoRegistro) {
        var existeRegistro = listaDespLocal
            .any((x) => x.pessoaIdGlobal.contains(novoRegistro.pessoaIdGlobal));

        if (existeRegistro == false) {
          listaNovosRegistros.add(novoRegistro);
        }
      });
    }

    if (listaNovosRegistros != null && listaNovosRegistros.length > 0) {
      listaNovosRegistros.forEach((pessoaFirebase) {
        pessoaHelper.insert(pessoaFirebase);

        if (pessoaFirebase.pessoaModelSnapShot != null) {
          pessoaFirebase.pessoaModelSnapShot.forEach((parcela) {
            var parcelaAdd = PessoaModel.fromMap(parcela, true);
            pessoaHelper.insert(parcelaAdd);
          });
        }
      });
    }
    listaNovosRegistros.clear();
    pessoaAddFirestore.clear();
  }

  atualizepessoaFirebase(List<PessoaModel> pessoaUpdateFirestore) {
    pessoaUpdateFirestore.forEach((pessoaFirebase) {
      pessoaHelper.update(pessoaFirebase);

      if (pessoaFirebase.pessoaModelSnapShot != null) {
        pessoaFirebase.pessoaModelSnapShot.forEach((parcela) {
          pessoaHelper.update(parcela);
        });
      }
    });
  }

  deleteRegistroFirestore(List<PessoaModel> pessoaDeleteFirestore) {
    pessoaDeleteFirestore.forEach((pessoaFirebase) {
      pessoaHelper.delete(pessoaFirebase.pessoaIdGlobal);

      if (pessoaFirebase.pessoaModelSnapShot != null) {
        pessoaFirebase.pessoaModelSnapShot.forEach((pessoa) {
          pessoaHelper.delete(pessoa.pessoaIdGlobal);
        });
      }
    });
  }
}
