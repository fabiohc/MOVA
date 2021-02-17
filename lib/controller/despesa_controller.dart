import 'package:emanuellemepoupe/controller/util.dart';
import 'package:emanuellemepoupe/helperBD/despesa_helperdb.dart';
import 'package:emanuellemepoupe/helperBD/parcela_helperdb.dart';
import 'package:emanuellemepoupe/model/despesa_model.dart';
import 'package:emanuellemepoupe/model/parcela_model.dart';
import 'package:emanuellemepoupe/model/pessoa_model.dart';
import 'package:emanuellemepoupe/repository/despesa_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
part 'despesa_controller.g.dart';

class DespesaController = _DespesaControllerBase with _$DespesaController;

abstract class _DespesaControllerBase with Store {
  var despesaHelper = DespesaHelper();
  var repositoryHelper = DespesaRepository();
  var parcelaHelper = ParcelaHelper();
  var pessoaModel = PessoaModel();
  var util = Util();

  final numeroParcela = ValueNotifier<int>(0);

  @observable
  var despesaModel = DespesaModel();

  @observable
  var parcelaModel = ParcelaModel();

  @observable
  insiraNovaDespesa() async {
    despesaModel.alteraDespIdGlobal(util.obtenhaIdGlobal("desp"));

    await despesaHelper.insert(despesaModel);

    if (despesaModel.despNumeroParcelas > 1) {
      var listaParcelas = obtenhaParcelas(despesaModel);
      for (var parcela in listaParcelas) {
        await parcelaHelper.insert(parcela);
      }
    }

    await repositoryHelper.insertFirestore(despesaModel);
  }

  @observable
  atualizeDespesa() async {
    await despesaHelper.update(despesaModel);
    if (despesaModel.despIdGlobal.isNotEmpty)
      await repositoryHelper.updateFirestore(despesaModel);
  }

  @observable
  deleteRegistro(DespesaModel despesa) async {
    await despesaHelper.delete(despesa.despIdGlobal);
    await parcelaHelper.delete(despesa.despIdGlobal);
    if (despesa.despIdGlobal.isNotEmpty)
      await repositoryHelper.deleteFirestore(despesa);
  }

  obtenhaParcelas(DespesaModel despesaModel) {
    List<ParcelaModel> listParcelas = [];
    List<Map> parcelas = [];

    var _valorParcela = util.converteStringToDouble(despesaModel.despValor) /
        despesaModel.despNumeroParcelas;
    _valorParcela.toStringAsPrecision(9);

    int contador = 0;
    for (var i = 0; i < despesaModel.despNumeroParcelas; i++) {
      contador++;
      var parcelaModel = new ParcelaModel();
      //parcelaModel.alteraParcelaId(contador);
      parcelaModel.alteraParcelaIdGlobal(despesaModel.despIdGlobal);
      parcelaModel.alteraParcelaNumero(contador);
      parcelaModel.alteraQuantParcelas(despesaModel.despNumeroParcelas);
      parcelaModel.alteraParcelaValor(_valorParcela.toString());
      parcelaModel.alteraParcelaData(
          util.obtenhaDataProximaParcela(despesaModel.despData, contador));
      parcelaModel.alteraPacelaStatus(false);
      listParcelas.add(parcelaModel);
    }
    listParcelas.forEach((ParcelaModel parcelaModel) {
      Map parcela = parcelaModel.toMap();
      parcelas.add(parcela);
    });
    despesaModel.alteraDespListaParcelas(parcelas);
    return listParcelas;
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

  atualizeStatusPagamrnto() async {
    await despesaHelper.update(despesaModel);
    if (despesaModel.despIdGlobal.isNotEmpty)
      await repositoryHelper.updateFirestore(despesaModel);
  }

  @observable
  Future<List> obtentaListaDespesas() async {
    List lista = await despesaHelper.selectAll();
    return lista;
  }

  @observable
  insiraNovaDespesaFirebase(List<DespesaModel> despesaAddFirestore) async {
    final List<DespesaModel> listaDespLocal = await despesaHelper.selectAll();
    List<DespesaModel> listaNovosRegistros = [];

    if (listaDespLocal.length == 0) {
      listaNovosRegistros = despesaAddFirestore;
    } else {
      /* var a = listaDespLocal.map((e) => e).toSet().toList();
      var b = despesaAddFirestore.map((e) => e).toSet().toList();*/

      despesaAddFirestore.forEach((novoRegistro) {
        var existeRegistro = listaDespLocal
            .any((x) => x.despIdGlobal.contains(novoRegistro.despIdGlobal));

        if (existeRegistro == false) {
          listaNovosRegistros.add(novoRegistro);
        }
      });

      /* listaDespLocal.forEach((listalocal) {
        listaNovosRegistros = despesaAddFirestore
            .where((x) => (x.despIdGlobal.(listalocal.despIdGlobal)))
            .toList();
      });*/
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

  @observable
  Future<List> obtentaListaDeParcelasPorId(String id) async {
    var lista = await parcelaHelper.selectparcelaById(id);
    return lista;
  }

  @observable
  Future<List> obtentaListaDeParcela(String id) async {
    var lista = await parcelaHelper.selectAll();
    return lista;
  }

  incrementeNumeroParcela() {
    numeroParcela.value++;
  }

  decrementeNumeroParcela() {
    numeroParcela.value--;
  }

  /*
 *Função: Retorna registro da categoria selecionada.
 *Parametro(s):Lista de despesas.
 *Parametro(s):Categoria selecionada.
 *Retorno: Retorna lista de despesas por categoria.
 */
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

  /*
 *Função: Retorna o mês e o ano de uma data.
 *Parametro(s):Data
 *Parametro(s):Numero de incremento de Mês
 *Retorno: Mês e ano no formato 'Myyyy'
 */
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

    ///Ordena em ordem crescente.
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
