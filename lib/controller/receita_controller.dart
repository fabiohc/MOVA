import 'package:emanuellemepoupe/controller/util.dart';
import 'package:emanuellemepoupe/helperBD/parcela_helperdb.dart';
import 'package:emanuellemepoupe/helperBD/pessoa_helperdb.dart';
import 'package:emanuellemepoupe/helperBD/receita_helperdb.dart';
import 'package:emanuellemepoupe/model/parcela_model.dart';
import 'package:emanuellemepoupe/model/receita_model.dart';
import 'package:emanuellemepoupe/repository/parcela_repository.dart';
import 'package:emanuellemepoupe/repository/receita_repository.dart';
import 'package:emanuellemepoupe/validacao/valide_datas.dart';
import 'package:mobx/mobx.dart';
import 'package:emanuellemepoupe/model/agenda_model.dart';
part 'receita_controller.g.dart';

class ReceitaController = _ReceitaControllerBase with _$ReceitaController;

abstract class _ReceitaControllerBase with Store {
  var receitaHelper = ReceitaHelper();

  var repositoryHelper = ReceitaRepository();
  var parcelaHelper = ParcelaHelper();
  var pessoaHelper = PessoaHelper();
  var parcelaRepository = ParcelaRepository();

  @observable
  var agendaModel = AgendaModel();

  @observable
  var receitaModel = ReceitaModel();
  @observable
  var parcelaModel = ParcelaModel();

  var util = Util();

  @computed
  bool get isValid {
    return valideDataNascimento() == null &&
        valideCheckRadio() == null &&
        valideValor() == null;
  }

  String valideDataNascimento() {
    if (receitaModel.recValor == null || receitaModel.recValor.isEmpty) {
      return "Informe um data válida!";
    } else if (receitaModel.recValor.length > 9) {
      return ValideDatas().validedata(receitaModel.recValor);
    }
    return null;
  }

  valideCheckRadio() {
    if (receitaModel.recFormaPagamento == null ||
        receitaModel.recFormaPagamento.isEmpty) {
      return "Informe uma forma de pagamento!";
    }
    return null;
  }

  valideValor() {
    if (receitaModel.recValor == null || receitaModel.recValor.isEmpty) {
      return "Informe um valor!";
    }
    return null;
  }

  insiraNovaReceita() async {
    receitaModel.alteraRecIdFGlobal(util.obtenhaIdGlobal("rec"));
    await receitaHelper.insert(receitaModel);

    if (receitaModel.recNumeroParcelas > 0) {
      var listaParcelas = obtenhaParcelas(receitaModel);
      for (var parcela in listaParcelas) {
        await parcelaHelper.insert(parcela);
      }
    }
    if (receitaModel.recIdGlobal.isNotEmpty)
      await repositoryHelper.insertFirestore(receitaModel);
  }

  obtenhaParcelas(ReceitaModel receitaModel) {
    List<ParcelaModel> listParcelas = [];
    //List<Map> parcelas = [];

    var _valorParcela = util.converteStringToDouble(receitaModel.recValor) /
        receitaModel.recNumeroParcelas;
    _valorParcela.toStringAsPrecision(9);

    int contador = 0;
    for (var i = 0; i < receitaModel.recNumeroParcelas; i++) {
      contador++;
      var parcelaModel = new ParcelaModel();
      parcelaModel.alteraParcelaIdGlobal(receitaModel.recIdGlobal);
      parcelaModel.alteraParcelaNumero(contador);
      parcelaModel.alteraQuantParcelas(receitaModel.recNumeroParcelas);
      parcelaModel.alteraParcelaValor(_valorParcela.toString());
      parcelaModel.alteraParcelaData(
          util.obtenhaDataProximaParcela(receitaModel.recData, contador));
      parcelaModel.alteraPacelaStatus(false);
      parcelaModel
          .alteraPacelaPessoaIdVinculado(receitaModel.recPessoaIdVinculado);
      listParcelas.add(parcelaModel);
    }

    receitaModel.alteraRecListaParcelas(listParcelas);
    return listParcelas;
  }

  @observable
  atualizeReceita() async {
    await receitaHelper.update(receitaModel);
    await repositoryHelper.deleteParcelasAntesUpdateFirestore(receitaModel);

    if (receitaModel.recNumeroParcelas > 0) {
      var listaParcelas = obtenhaParcelas(receitaModel);
      for (var parcela in listaParcelas) {
        await parcelaHelper.update(parcela);
      }
    }

    if (receitaModel.recIdGlobal.isNotEmpty)
      await repositoryHelper.updateFirestore(receitaModel);
  }

  @observable
  deleteRegistro(ReceitaModel receita) async {
    await receitaHelper.delete(receita.recIdGlobal);
    await parcelaHelper.delete(receita.recIdGlobal);

    if (receita.recIdGlobal.isNotEmpty)
      await repositoryHelper.deleteFirestore(receita);

    if (receita.recIdGlobal.isNotEmpty)
      await parcelaRepository.deleteFiresore(receita.parcelaModel);
  }

  @observable
  Future<List> obtentaListaDeParcelasPorId(String id) async {
    var lista = await parcelaHelper.selectparcelaById(id);
    return lista;
  }

  @observable
  Future<List> obtentaListaDeParcelas(String id) async {
    var lista = await parcelaHelper.selectAll();

    return lista;
  }

  /*
 *Função: Obtem a lista de receitas com suas parcelas e cliente vinculado.
 *Retorno: Retorna a lista de receitas.
 */
  @observable
  Future<List> obtentaListaReceitas() async {
    var receitasCompletas = <ReceitaModel>[];
    var lista = await receitaHelper.selectAll();

    /*Obtendo lista de parcelas da receira*/
    lista.forEach((receita) {
      if (receita.recNumeroParcelas > 0) {
        var parcelas = parcelaHelper.selectparcelaById(receita.recIdGlobal);
        parcelas.then((parcelas) {
          receita.parcelaModel = parcelas;
        });
      }
      /*Obtendo pessoa vinculada a receira*/
      if (receita.recPessoaIdVinculado != null) {
        var pessoa = pessoaHelper.selectById(receita.recPessoaIdVinculado);
        pessoa.then((pessoa) {
          receita.pessoaModel = pessoa;
        });
      }

      receitasCompletas.add(receita);
    });

    return receitasCompletas;
  }

  @observable
  insiraNovaReceitaFirebase(List<ReceitaModel> receitaAddFirestore) async {
    final List<ReceitaModel> listaDespLocal = await receitaHelper.selectAll();
    List<ReceitaModel> listaNovosRegistros = [];

    if (listaDespLocal.length == 0) {
      listaNovosRegistros = receitaAddFirestore;
    } else {
/*
      var a = listaDespLocal.map((e) => e).toSet().toList();
      var b = receitaAddFirestore.map((e) => e).toSet().toList();*/

      receitaAddFirestore.forEach((novoRegistro) {
        var existeRegistro = listaDespLocal
            .any((x) => x.recIdGlobal.contains(novoRegistro.recIdGlobal));

        if (existeRegistro == false) {
          listaNovosRegistros.add(novoRegistro);
        }
      });
/*
      listaDespLocal.forEach((listalocal) {
        listaNovosRegistros = receitaAddFirestore
            .where((x) => !x.recIdGlobal.contains(listalocal.recIdGlobal))
            .toList();
      });*/
    }

    if (listaNovosRegistros != null && listaNovosRegistros.length > 0) {
      listaNovosRegistros.forEach((recFirebase) {
        receitaHelper.insert(recFirebase);

        if (recFirebase.parcelaModelSnapShot != null) {
          recFirebase.parcelaModelSnapShot.forEach((parcela) {
            var parcelaAdd = ParcelaModel.fromMap(parcela, true);
            parcelaHelper.insert(parcelaAdd);
          });
        }
      });
    }
    listaNovosRegistros.clear();
    receitaAddFirestore.clear();
  }

  atualizeReceitaFirebase(List<ReceitaModel> despesaAddFirestore) async {
    despesaAddFirestore.forEach((recFirebase) {
      receitaHelper.update(recFirebase);

      if (recFirebase.parcelaModelSnapShot != null) {
        recFirebase.parcelaModelSnapShot.forEach((parcela) {
          parcelaHelper.update(parcela);
        });
      }
    });
  }

  @observable
  deleteRegistroFirestore(List<ReceitaModel> despesaAddFirestore) async {
    despesaAddFirestore.forEach((recFirebase) {
      receitaHelper.delete(recFirebase.recIdGlobal);

      if (recFirebase.parcelaModelSnapShot != null) {
        recFirebase.parcelaModelSnapShot.forEach((parcela) {
          parcelaHelper.delete(parcela.parcelaIdGlobal);
        });
      }
    });
  }

  /*
 *Função: Retorna o mês e o ano de uma data.
 *Parametro(s):Data
 *Parametro(s):Numero de incremento de Mês
 *Retorno: Mês e ano no formato 'Myyyy'
 */
  List obtenhaQuantidadeDeMeses(List<ReceitaModel> listaDespesas) {
    List listaMesesConvertido = [];
    List listaMeses;

    listaMeses = listaDespesas
        .map((e) => util.obtenhaMesAno(e.recData))
        .toSet()
        .toList();

    listaMeses.forEach((data) {
      listaMesesConvertido.add(int.parse(data));
    });

    listaMesesConvertido.sort();

    return listaMesesConvertido;
  }

  /*
 *Função: Retorna registro da categoria selecionada.
 *Parametro(s):Lista de despesas.
 *Parametro(s):Categoria selecionada.
 *Retorno: Retorna lista de despesas por categoria.
 */
  List<ReceitaModel> obtenhaRegistrosPorTipo(
      List<ReceitaModel> listaReceitas, String categoria, String mesAno) {
    // var dataAtual = util.formatData(DateTime.now().toString());
    // var mesAno = util.obtenhaMesAno(dataAtual);

    mesAno = util.obtenhaMesAnoMyyyyParaMMyyyy(mesAno);

    if (!categoria.contains("Todos")) {
      listaReceitas = listaReceitas
          .where((x) =>
              util.obtenhaMesAno(x.recData).contains(mesAno) &&
              (x.recServico).contains(categoria))
          .toList();
    } else {
      listaReceitas = listaReceitas
          .where((x) => util.obtenhaMesAno(x.recData).contains(mesAno))
          .toList();
    }
    return listaReceitas;
  }

  /*
 *Função: Retorna o mês e o ano de uma data.
 *Parametro(s):Data
 *Parametro(s):Numero de incremento de Mês
 *Retorno: Mês e ano no formato 'Myyyy'
 */
  @observable
  Future<List<ReceitaModel>> obtenhaRegistroPorMes(
      List<ReceitaModel> listaDespesas,
      [String anoMes]) async {
    if (anoMes == null) {
      var dataAtual = util.formatData(DateTime.now().toString());
      anoMes = util.obtenhaMesAno(dataAtual);
    }
    listaDespesas = listaDespesas
        .where((x) => util.obtenhaMesAno(x.recData).contains(anoMes))
        .toList();
    return listaDespesas;
  }
}
