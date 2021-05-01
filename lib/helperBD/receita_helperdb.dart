import 'package:emanuellemepoupe/model/receita_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ReceitaHelper {
  static final ReceitaHelper _instance = ReceitaHelper.internal();

  ReceitaHelper.internal();

  factory ReceitaHelper() => _instance;

  Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return db;
  }

  Future<Database> initDb() async {
    final pasta = await getDatabasesPath();
    final pastaBD = join(pasta, "emanuelle.db");

    return await openDatabase(pastaBD,
        version: 1, onCreate: (Database db, int newerVersion) async {});
  }

  Future<ReceitaModel> insert(ReceitaModel receita) async {
    Database dbReceita = await db;
    receita.recId = await dbReceita.insert("receita", receita.toMap());
    return receita;
  }

  Future<ReceitaModel> selectById(int id) async {
    Database dbReceita = await db;
    List<Map> maps = await dbReceita.query("receita",
        columns: [
          "recId",
          "recIdGlobal",
          "recServico",
          "recValor",
          "recData",
          "recFormaPagamento",
          "recTipoCartao",
          "recNumeroParcelas",
          "recStatusPag",
          "recIntegrado"
        ],
        where: "recid = ?",
        whereArgs: [id]);
    if (maps.length > 0) {
      return ReceitaModel.fromMap(maps.first, false);
    } else {
      return null;
    }
  }

  Future<List<ReceitaModel>> selectAll() async {
    Database dbReceita = await db;
    List<ReceitaModel> listaReceitas = List();

    List list = await dbReceita.rawQuery("SELECT * " +
        " FROM   (SELECT  " +
        "               [r].[recIdGlobal], " +
        "               [r].[recServico], " +
        "               [r].[recData], " +
        "               [r].[recValor], " +
        "               [r].[recFormaPagamento], " +
        "               [r].[recTipoCartao], " +
        "               [r].[recObservacao], " +
        "               0 AS [numParcela], " +
        "               [r].[recNumeroParcelas]," +
        "               [r].[recStatusPag], " +
        "               [r].[recIntegrado], " +
        "               [r].[recPessoaIdVinculado]" +
        "        FROM   [receita] [r]" +
        "        UNION" +
        "        SELECT " +
        "               [p].[parcelaIdGlobal] AS [recIdGlobal], " +
        "               'Parcela' AS [recServico], " +
        "               [p].[parcelaData] AS [recData], " +
        "               [p].[parcelaValor] AS [recValor], " +
        "               'null' AS [recFormaPagamento], " +
        "               'null' AS [recTipoCartao], " +
        "               'null' AS [recObservacao], " +
        "               [p].[parcelaNumero] AS [numParcela], " +
        "               [p].[parcelaQuatParc] AS [recNumeroParcelas], " +
        "               [p].[parcelaStatusPag] AS [recesaStatusPag], " +
        "               [p].[parcelaIntegrado] AS [recIntegrado], " +
        "               [p].[pacelaPessoaIdVinculado] AS [recPessoaIdVinculado]" +
        "        FROM   [parcelas] [p]" +
        "        WHERE  [parcelaIdGlobal] LIKE '%rec%') AS consulta" +
        " ORDER  BY 3 asc;");

    for (Map m in list) {
      listaReceitas.add(ReceitaModel.fromMap(m, false));
    }

    return listaReceitas;
  }

  Future<int> update(ReceitaModel receita) async {
    Database dbReceita = await db;
    return await dbReceita.update("receita", receita.toMap(),
        where: "recIdGlobal = ?", whereArgs: [receita.recIdGlobal]);
  }

  Future<int> delete(String id) async {
    Database dbReceita = await db;
    return await dbReceita
        .delete("receita", where: "recIdGlobal = ?", whereArgs: [id]);
  }

  Future close() async {
    Database dbReceita = await db;
    dbReceita.close();
  }
}
