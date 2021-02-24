import 'package:emanuellemepoupe/model/receita_model.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:emanuellemepoupe/model/carteira_model.dart';
import 'package:emanuellemepoupe/model/despesa_model.dart';
import 'package:mobx/mobx.dart';

class Util {
  /*
 *Função:
 *Parametro(s):
 *Retorno: 
 */
  formatData(String data) {
    initializeDateFormatting("pt_BR");
    var formatador = DateFormat.yMd("pt_BR");
    DateTime dataConvertida = DateTime.parse(data);
    String dataFormatada = formatador.format(dataConvertida);
    return dataFormatada;
  }

  /*
 *Função: Formata uma data do tipo mêsAno adicionando uma "/".
 *Parametro(s): String mesAno
 *Retorno: mes/Ano - Ex: 102020 => 10/2020
 */
  formataDataMesAno(String mesAno) {
    var nunCaracter = mesAno.length;

    if (nunCaracter > 5) {
      var mes = mesAno.substring(0, 2);
      var ano = mesAno.substring(2, 6);
      return mes + "/" + ano;
    } else {
      var mes = mesAno.substring(0, 1);
      var ano = mesAno.substring(1, 5);
      return '0' + mes + "/" + ano;
    }
  }

/*
 *Função:
 *Parametro(s):
 *Retorno: 
 */
  String obtenhaDataProximaParcela(String data, int contadorParcela) {
    DateFormat inputFormat = DateFormat("dd/MM/yyyy");
    DateTime dateTime = inputFormat.parse(data);
    dateTime = Jiffy(dateTime).add(months: contadorParcela);
    final dataParcela = formatData(dateTime.toString());
    return dataParcela;
  }

/*
 *Função: Retorna o mês e o ano de uma data.
 *Parametro(s):Data
 *Parametro(s):Numero de incremento de Mês
 *Retorno: Mês e ano no formato 'Myyyy'
 */
  String obtenhaMesAno(String data, {int contadorMes}) {
    DateFormat inputFormat = DateFormat("dd/MM/yyyy");
    DateTime dateTime = inputFormat.parse(data);
    var mes = dateTime.month;
    var ano = dateTime.year;
    final mesAno = mes > 9
        ? mes.toString() + ano.toString()
        : '0' + mes.toString() + ano.toString();
    return mesAno;
  }

  /*
 *Função: Retorna o mês e o ano de uma data.
 *Parametro(s):Data no formato mesAno: Exemplo "62020". 
 *Retorno: Mês e ano no formato 'Myyyy'
 */
  String obtenhaMesAnoMyyyyParaMMyyyy(String data) {
    var mes;
    var ano;
    var nunCaracter = data.length;

    if (nunCaracter > 5) {
      mes = data.substring(0, 2);
      ano = data.substring(2, 6);
    } else {
      mes = data.substring(0, 1);
      ano = data.substring(1, 5);
    }

    final mesAno = int.parse(mes) > 9
        ? mes.toString() + ano.toString()
        : '0' + mes.toString() + ano.toString();
    return mesAno;
  }

/*
 *Função:
 *Parametro(s):
 *Retorno: 
 */
  formatMoeda(String data) {
    var valor = double.parse(data);
    final formatter = new NumberFormat.decimalPattern("pt_Br");
    String newText = formatter.format(valor / 100);
    return newText;
  }

/*
Função:Cria número do ID para gravação.
Parametro(s): Prefixo do ID Global.
Retorno: Retorna ID Global.
*/
  String obtenhaIdGlobal(String prefixo) {
    DateTime data = DateTime.now();
    final DateFormat formatter = DateFormat('ddMMyyyy-Hms');
    final String dataFormatada = formatter.format(data);
    String idGlobal = prefixo + dataFormatada + '_' + data.hashCode.toString();
    return idGlobal;
  }

/*
 *Função:
 *Parametro(s):
 *Retorno: 
 */
  String formatMoedaDoubleParaString(String moedaBD) {
    double valorDouble = double.parse(moedaBD);
    final formatador = NumberFormat("#,##0.00", "pt_BR");
    final valorString = formatador.format(valorDouble).toString();
    return valorString;
  }

/*
 *Função:
 *Parametro(s):
 *Retorno: 
 */
  double converteStringToDouble(String valor) {
    valor = valor.replaceAll('.', '').replaceAll(',', '.');
    final valorDouble = double.parse(valor);
    return valorDouble;
  }

/*
 *Função: Retorna o mês e o ano de uma data.
 *Parametro(s):Data
 *Parametro(s):Numero de incremento de Mês
 *Retorno: Mês e ano no formato 'Myyyy'
 */
  List<DespesaModel> obtenhaDespesasDoMesAtual(
      List<DespesaModel> listaDespesas) {
    var dataAtual = formatData(DateTime.now().toString());
    var anoMes = obtenhaMesAno(dataAtual);
    var listaDespesasMesAtual = listaDespesas
        .where((x) => obtenhaMesAno(x.despData).contains(anoMes))
        .toList();

    if (listaDespesasMesAtual.length == 0) {
      DateTime dateTime = Jiffy(DateTime.now()).subtract(months: 1);
      var dataAtual = formatData(dateTime.toString());
      var anoMes = obtenhaMesAno(dataAtual);
      listaDespesas = listaDespesas
          .where((x) => obtenhaMesAno(x.despData).contains(anoMes))
          .toList();
      return listaDespesas;
    }
    return listaDespesas = listaDespesasMesAtual;
  }

  /*
 *Função: Retorna o mês e o ano de uma data.
 *Parametro(s):Data
 *Parametro(s):Numero de incremento de Mês
 *Retorno: Mês e ano no formato 'Myyyy'
 */
  List<ReceitaModel> obtenhaReceitasDoMesAtual(
      List<ReceitaModel> listaReceitas) {
    var dataAtual = formatData(DateTime.now().toString());
    var anoMes = obtenhaMesAno(dataAtual);
    var listaReceitasMesAtual = listaReceitas
        .where((x) => obtenhaMesAno(x.recData).contains(anoMes))
        .toList();

    if (listaReceitasMesAtual.length == 0) {
      DateTime dateTime = Jiffy(DateTime.now()).subtract(months: 1);
      var dataAtual = formatData(dateTime.toString());
      var anoMes = obtenhaMesAno(dataAtual);
      listaReceitas = listaReceitas
          .where((x) => obtenhaMesAno(x.recData).contains(anoMes))
          .toList();
      return listaReceitas;
    }
    return listaReceitas = listaReceitasMesAtual;
  }

  /*
 *Função: Retorna o mês e o ano de uma data.
 *Parametro(s):Data
 *Parametro(s):Numero de incremento de Mês
 *Retorno: Mês e ano no formato 'Myyyy'
 */
  @observable
  List<CarteiraModel> obtenhaRegistroPorMes(List<CarteiraModel> listaDespesas,
      [String anoMes]) {
    if (anoMes == null) {
      var dataAtual = formatData(DateTime.now().toString());
      anoMes = obtenhaMesAno(dataAtual);
    }
    listaDespesas = listaDespesas
        .where((x) => obtenhaMesAno(x.data).contains(anoMes))
        .toList();
    return listaDespesas;
  }

  /*
 *Função: Retornar uma lista de despesas de um mês e ano.
 *Parametro(s):Lista de despesas do tipo "List<DespesaModel>"
 *Parametro(s):Mês e ano do tipo "String anoMes"
 *Retorno: Lista de despesas filtrada por mês e ano.
 */
  @observable
  List<DespesaModel> obtenhaRegistroDespesasPorMes(
      List<DespesaModel> listaDespesas,
      [String anoMes]) {
    if (anoMes == null) {
      var dataAtual = formatData(DateTime.now().toString());
      anoMes = obtenhaMesAno(dataAtual);
    }
    listaDespesas = listaDespesas
        .where((x) => obtenhaMesAno(x.despData).contains(anoMes))
        .toList();
    return listaDespesas;
  }

  /*
 *Função: Retorna uma lista de receitas de um mês e ano.
 *Parametro(s):Lista de receitas do tipo "List<ReceitaModel>"
 *Parametro(s):Mês e ano do tipo "String anoMes"
 *Retorno: Lista de receitas filtrada por mês e ano.
 */
  @observable
  List<ReceitaModel> obtenhaRegistroReceitasPorMes(
      List<ReceitaModel> listaReceitas,
      [String anoMes]) {
    if (anoMes == null) {
      var dataAtual = formatData(DateTime.now().toString());
      anoMes = obtenhaMesAno(dataAtual);
    }
    listaReceitas = listaReceitas
        .where((x) => obtenhaMesAno(x.recData).contains(anoMes))
        .toList();
    return listaReceitas;
  }

  /*
 *Função: Retorna o mês e o ano de uma data.
 *Parametro(s):Data
 *Parametro(s):Numero de incremento de Mês
 *Retorno: Mês e ano no formato 'Myyyy'
 */
  double obtenhaSomaValorPorTipo(
      List<CarteiraModel> listaDespesas, String mesDePesquisa,
      [String tipo, String tipo2]) {
    var soma = listaDespesas
        .where((x) =>
            x.tipo.contains(tipo) &&
            obtenhaMesAno(x.data).contains(mesDePesquisa))
        .fold(0.0, (p, e) => p + e.valor);
    // soma = formatMoedaDoubleParaString(soma.toString());
    return soma;
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

    listaMeses =
        listaDespesas.map((e) => obtenhaMesAno(e.data)).toSet().toList();

    listaMeses.forEach((data) {
      data = formataDataMesAno(data);
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
 */
  List<DespesaModel> obtenhaRegistrosPorTipo(List<DespesaModel> listaDespesas) {
    var dataAtual = formatData(DateTime.now().toString());
    var anoMes = obtenhaMesAno(dataAtual);
    listaDespesas = listaDespesas
        .where((x) => obtenhaMesAno(x.despData).contains(anoMes))
        .toList();
    return listaDespesas;
  }
}
