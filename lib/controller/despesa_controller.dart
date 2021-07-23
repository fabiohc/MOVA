import 'package:emanuellemepoupe/controller/pessoa_controller.dart';
import 'package:emanuellemepoupe/controller/parcela_controller.dart';
import 'package:emanuellemepoupe/controller/util.dart';
import 'package:emanuellemepoupe/helperBD/despesa_helperdb.dart';
import 'package:emanuellemepoupe/helperBD/parcela_helperdb.dart';
import 'package:emanuellemepoupe/helperBD/pessoa_helperdb.dart';
import 'package:emanuellemepoupe/model/despesa_model.dart';
import 'package:emanuellemepoupe/model/parcela_model.dart';
import 'package:emanuellemepoupe/model/pessoa_model.dart';
import 'package:emanuellemepoupe/repository/despesa_repository.dart';
import 'package:emanuellemepoupe/repository/parcela_repository.dart';
import 'package:emanuellemepoupe/validacao/valide_datas.dart';

import 'package:mobx/mobx.dart';

part 'despesa_controller.g.dart';

class DespesaController = _DespesaControllerBase with _$DespesaController;

abstract class _DespesaControllerBase with Store {
  var despesaHelper = DespesaHelper();
  var pessoaHelper = PessoaHelper();
  var repositoryHelper = DespesaRepository();
  var parcelaRepository = ParcelaRepository();
  var parcelaHelper = ParcelaHelper();
  var pessoaModel = PessoaModel();
  var pessoaController = PessoaController();
  var parcelaController = ParcelaController();
  var util = Util();

  @observable
  var despesaModel = DespesaModel();

  @observable
  var parcelaModel = ParcelaModel();

  @computed
  bool get isValid {
    return valideDataNascimento() == null &&
        valideCheckRadio() == null &&
        valideValor() == null;
  }

  String valideDataNascimento() {
    if (despesaModel.despValor == null || despesaModel.despValor.isEmpty) {
      return "Informe um data válida!";
    } else if (despesaModel.despValor.length > 9) {
      return ValideDatas().validedata(despesaModel.despValor);
    }
    return null;
  }

  valideCheckRadio() {
    if (despesaModel.despFormaPagamento == null ||
        despesaModel.despFormaPagamento.isEmpty) {
      return "Informe uma forma de pagamento!";
    }
    return null;
  }

  valideValor() {
    if (despesaModel.despValor == null || despesaModel.despValor.isEmpty) {
      return "Informe um valor!";
    }
    return null;
  }

  @observable
  atualizeDespesa() async {
    await despesaHelper.update(despesaModel);
    await repositoryHelper.deleteParcelasAntesUpdateFirestore(despesaModel);

    if (despesaModel.despNumeroParcelas > 0) {
      var listaParcelas = crieParcelas(despesaModel);
      for (var parcela in listaParcelas) {
        await parcelaHelper.update(parcela);
      }
    }

    if (despesaModel.despIdGlobal.isNotEmpty)
      await repositoryHelper.updateFirestore(despesaModel);
  }

  atualizeDespesaFirebase(List<DespesaModel> despesaAddFirestore) async {
    despesaAddFirestore.forEach((despFirebase) {
      despesaHelper.update(despFirebase);

      if (despFirebase.parcelaModelSnapShot != null) {
        despFirebase.parcelaModelSnapShot.forEach((parcela) {
          parcelaHelper.update(parcela);
        });
      }
    });
  }

  @observable
  deleteRegistro(DespesaModel despesa) async {
    await despesaHelper.delete(despesa.despIdGlobal);
    
    await parcelaHelper.delete(despesa.despIdGlobal);

    if (despesa.despIdGlobal.isNotEmpty)
      await repositoryHelper.deleteFirestore(despesa);

    if (despesa.despIdGlobal.isNotEmpty)
      await parcelaRepository.deleteFiresore(despesa.parcelaModel);
  }

  @observable
  deleteRegistroFirestore(List<DespesaModel> despesaAddFirestore) async {
    despesaAddFirestore.forEach((despFirebase) {
      despesaHelper.delete(despFirebase.despIdGlobal);

      if (despFirebase.parcelaModelSnapShot != null) {
        despFirebase.parcelaModelSnapShot.forEach((parcela) {
          parcelaHelper.delete(parcela.parcelaIdGlobal);
        });
      }
    });
  }

  @observable
  insiraNovaDespesa() async {
    despesaModel.alteraDespIdGlobal(util.obtenhaIdGlobal("desp"));
    await despesaHelper.insert(despesaModel);

    if (despesaModel.despNumeroParcelas > 0) {
      var listaParcelas = await crieParcelas(despesaModel);
      for (var parcela in listaParcelas) {
        await parcelaHelper.insert(parcela);
      }
    }
    await repositoryHelper.insertFirestore(despesaModel);
  }

  @observable
  insiraNovaDespesaFirebase(List<DespesaModel> despesaAddFirestore) async {
    final List<DespesaModel> listaDespLocal = await despesaHelper.selectAll();
    List<DespesaModel> listaNovosRegistros = [];

    if (listaDespLocal.length == 0) {
      listaNovosRegistros = despesaAddFirestore;
    } else {
      despesaAddFirestore.forEach((novoRegistro) {
        var existeRegistro = listaDespLocal
            .any((x) => x.despIdGlobal.contains(novoRegistro.despIdGlobal));

        if (existeRegistro == false) {
          listaNovosRegistros.add(novoRegistro);
        }
      });
    }

    if (listaNovosRegistros != null && listaNovosRegistros.length > 0) {
      listaNovosRegistros.forEach((despFirebase) {
        despesaHelper.insert(despFirebase);

        if (despFirebase.parcelaModelSnapShot != null) {
          despFirebase.parcelaModelSnapShot.forEach((parcela) {
            var parcelaAdd = ParcelaModel.fromMap(parcela, true);
            parcelaHelper.insert(parcelaAdd);
          });
        }
      });
    }
    listaNovosRegistros.clear();
    despesaAddFirestore.clear();
  }

  crieParcelas(DespesaModel despesaModel) {
    List<ParcelaModel> listParcelas = [];

    var _valorParcela = util.converteStringToDouble(despesaModel.despValor) /
        despesaModel.despNumeroParcelas;
    _valorParcela.toStringAsPrecision(9);

    int contador = 0;
    for (var i = 0; i < despesaModel.despNumeroParcelas; i++) {
      contador++;
      var parcelaModel = new ParcelaModel();
      parcelaModel.alteraParcelaIdGlobal(despesaModel.despIdGlobal);
      parcelaModel.alteraParcelaNumero(contador);
      parcelaModel.alteraQuantParcelas(despesaModel.despNumeroParcelas);
      parcelaModel.alteraParcelaValor(_valorParcela.toString());
      parcelaModel.alteraParcelaData(
          util.obtenhaDataProximaParcela(despesaModel.despData, contador));
      parcelaModel.alteraPacelaStatus(false);
      parcelaModel
          .alteraPacelaPessoaIdVinculado(despesaModel.despPessoaIdVinculado);
      listParcelas.add(parcelaModel);
    }
    /*  listParcelas.forEach((ParcelaModel parcelaModel) {
      Map parcela = parcelaModel.toMap();
      parcelas.add(parcela);
    });*/
    despesaModel.alteraDespListaParcelas(listParcelas);
    return listParcelas;
  }

  List obtenhaQuantidadeDeMeses(List<dynamic> listaDespesas) {
    List listaMesesConvertido = [];
    List listaMesesOrdenada = [];
    List listaMeses;

    listaMeses = listaDespesas
        .map((e) => util.obtenhaMesAno(e.despData))
        .toSet()
        .toList();

    listaMeses.forEach((data) {
      data = util.formataDataMesAno(data);
      data = data.replaceAll('/', '');
      var mes = data.substring(0, 2);
      var ano = data.substring(2, 6);
      data = ano + mes;
      listaMesesConvertido.add(int.parse(data));
    });

    /*Ordena em ordem crescente.*/
    listaMesesConvertido.sort();

    listaMesesConvertido.forEach((data) {
      data = data.toString();
      var ano = data.substring(0, 4);
      var mes = data.substring(4, 6);
      data = mes + ano;
      listaMesesOrdenada.add(data);
    });
    return listaMesesOrdenada;
  }

  List<DespesaModel> obtenhaRegistrosPorTipo(
      List<DespesaModel> listaDespesas, String categoria) {
    var dataAtual = util.formatData(DateTime.now().toString());
    var anoMes = util.obtenhaMesAno(dataAtual);

    if (!categoria.contains("Todos")) {
      listaDespesas = listaDespesas
          .where((x) =>
              util.obtenhaMesAno(x.despData).contains(anoMes) &&
              (x.despServico).contains(categoria))
          .toList();
    } else {
      listaDespesas = listaDespesas
          .where((x) => util.obtenhaMesAno(x.despData).contains(anoMes))
          .toList();
    }
    return listaDespesas;
  }

  @observable
  Future<List> obtentaListaDeParcela(String id) async {
    var lista = await parcelaHelper.selectAll();
    return lista;
  }

  /*
 *Função: Retorna registro da categoria selecionada.
 *Parametro(s):Lista de despesas.
 *Parametro(s):Categoria selecionada.
 *Retorno: Retorna lista de despesas por categoria.
 */
  @observable
  Future<List<ParcelaModel>> obtentaListaDeParcelasPorId(String id) async {
    var lista = await parcelaHelper.selectparcelaById(id);
    return lista;
  }

  /*
 *Função: Retorna o mês e o ano de uma data.
 *Parametro(s):Data
 *Parametro(s):Numero de incremento de Mês
 *Retorno: Mês e ano no formato 'Myyyy'
 */
  @observable
  Future<List> obtentaListaDespesas() async {
    var despesasCompletas = <DespesaModel>[];
    var lista = await despesaHelper.selectAll();

    lista.forEach((despesa) async {
      if (despesa.despNumeroParcelas > 0) {
        parcelaHelper
            .selectparcelaById(despesa.despIdGlobal)
            .then((value) => despesa.parcelaModel = value);
      }

      if (despesa.despPessoaIdVinculado != null) {
        var pessoa = pessoaHelper.selectById(despesa.despPessoaIdVinculado);
        pessoa.then((pessoa) {
          despesa.pessoaModel = pessoa;
        });
      }

      despesasCompletas.add(despesa);
    });

    return despesasCompletas;
  }

  /*
 *Função: Retorna o mês e o ano de uma data.
 *Parametro(s):Data
 *Parametro(s):Numero de incremento de Mês
 *Retorno: Mês e ano no formato 'Myyyy'
 */ /*
   @observable
  Future<List<DespesaModel>> obtenhaRegistroPorMes(List<DespesaModel> listaDespesas,
      [String anoMes]) {
    if (anoMes == null) {
      var dataAtual = util.formatData(DateTime.now().toString());
      anoMes = util.obtenhaMesAno(dataAtual);
    }
Future<List<DespesaModel>> listaDespesas1;

    listaDespesas = listaDespesas
        .where((x) => util.obtenhaMesAno(x.despData).contains(anoMes))
        .toList();
    return listaDespesas;
  }*/
}
