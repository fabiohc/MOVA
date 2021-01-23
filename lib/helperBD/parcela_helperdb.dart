import 'package:emanuellemepoupe/model/parcela_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ParcelaHelper {
  static final ParcelaHelper _instance = ParcelaHelper.internal();

  ParcelaHelper.internal();

  factory ParcelaHelper() => _instance;

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

   
    return await openDatabase(pastaBD, version: 1,
        onCreate: (Database db, int newerVersion) async {
     
    });
  }

  Future<ParcelaModel> insert(ParcelaModel parcela) async {
    Database dbparcela = await db;
    parcela.parcelaId = await dbparcela.insert("parcelas", parcela.toMap());
    return parcela;
  }

  Future<ParcelaModel> selectById(String id) async {
    Database dbparcela = await db;
    List<Map> maps = await dbparcela.query("parcelas",
        columns: [
          "parcelaId",
          "parcelaIdGlobal",
          "parcelaNumero",
          "parcelaQuatParc",
          "parcelaValor",
          "parcelaData",
          "parcelaStatusPag",
          "parcelaIntegrado"
        ],
        where: "parcelaIdGlobal = ?",
        whereArgs: [id]);
    if (maps.length > 0) {
      return ParcelaModel.fromMap(maps.first,false);
    } else {
      return null;
    }
  }

  Future<List<ParcelaModel>> selectparcelaById(String id) async {
    Database dbparcela = await db;
    List maps = await dbparcela.query("parcelas",
        columns: [
          "parcelaId",
          "parcelaIdGlobal",
          "parcelaNumero",
          "parcelaQuatParc",
          "parcelaValor",
          "parcelaData",
          "parcelaStatusPag",
          "parcelaIntegrado"
        ],
        where: "parcelaIdGlobal = ?",
        whereArgs: [id]);
    List<ParcelaModel> lsparcela = List();

    for (Map item in maps) {
      lsparcela.add(ParcelaModel.fromMap(item,false));
    }
    return lsparcela;
  }

  Future<List<ParcelaModel>> selectAll() async {
    Database dbparcela = await db;
    List list = await dbparcela.rawQuery("Select * from parcelas");
    
    List<ParcelaModel> lsparcela = List();
    for (Map m in list) {
      lsparcela.add(ParcelaModel.fromMap(m,false));
    }
    return lsparcela;
  }

  Future<int> update(ParcelaModel parcela) async {
    Database dbparcela = await db;
    return await dbparcela.update("parcelas", parcela.toMap(),
        where: "parcelaIdGlobal = ? and parcelaNumero = ?", whereArgs: [parcela.parcelaIdGlobal, parcela.parcelaNumero ]);
  }

   delete(String id) async {
    Database dbparcela = await db;
    return await dbparcela
        .delete("parcelas", where: "parcelaIdGlobal = ?", whereArgs: [id]);
  }

  Future close() async {
    Database dbparcela = await db;
    dbparcela.close();
  }
}
