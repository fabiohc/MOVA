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

    final String sql = "CREATE TABLE receita ("
        "recId INT PRIMARY KEY,"
        "recIdGlobal TEXT,"
        "recServico TEXT,"
        "recValor DOUBLE,"
        "recData TEXT,"
        "recFormaPagamento TEXT,"
        "recTipoCartao TEXT,"
        "recNumeroParcelas INT,"
        "recStatusPag BOLEAN,"
        "recIntegrado BOLEAN"
        ")";

    return await openDatabase(pastaBD, version: 1,
        onCreate: (Database db, int newerVersion) async {
      await db.execute(sql);
    });
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

  Future<List> selectAll() async {
    Database dbReceita = await db;
    List list = await dbReceita.rawQuery("Select * from receita");
    List<ReceitaModel> listaReceitas = List();
    for (Map m in list) {
      listaReceitas.add(ReceitaModel.fromMap(m,false));
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
