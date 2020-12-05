import 'package:emanuellemepoupe/model/despesa_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'create_helperdb.dart';

final criadb = CreateHelper();

class DespesaHelper {
  static final DespesaHelper _instance = DespesaHelper.internal();

  DespesaHelper.internal();

  factory DespesaHelper() => _instance;

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

  Future<DespesaModel> insert(DespesaModel despesa) async {
    Database dbDespesa = await db;
    despesa.despId = await dbDespesa.insert("despesa", despesa.toMap());
    return despesa;
  }

  Future<DespesaModel> selectById(int id) async {
    Database dbDespesa = await db;
    List<Map> maps = await dbDespesa.query("despesa",
        columns: [
          "despId",
          "despIdGlobal",
          "despServico",
          "despValor",
          "despData",
          "despFormaPagamento",
          "despTipoCartao",
          "despNumeroParcelas",
          "despObservacao",
          "despesaStatusPag",
          "despIntegrado"
        ],
        where: "despId = ?",
        whereArgs: [id]);
    if (maps.length > 0) {
      return DespesaModel.fromMap(maps.first,false);
    } else {
      return null;
    }
  }

  Future<List<DespesaModel>> selectAll() async {
    Database dbDespesa = await db;
    List list = await dbDespesa.rawQuery("Select * from despesa");
    List<DespesaModel> lsDespesa = List();
    for (Map m in list) {
      lsDespesa.add(DespesaModel.fromMap(m,false));
    }
    return lsDespesa;
  }

  Future<int> update(DespesaModel despesa) async {
    Database dbDespesa = await db;
    return await dbDespesa.update("despesa", despesa.toMap(),
        where: "despIdGlobal = ?", whereArgs: [despesa.despIdGlobal]);
  }

  Future<int> delete(String id) async {
    Database dbDespesa = await db;
    return await dbDespesa
        .delete("despesa", where: "despIdGlobal = ?", whereArgs: [id]);
  }

  Future close() async {
    Database dbDespesa = await db;
    dbDespesa.close();
  }
}