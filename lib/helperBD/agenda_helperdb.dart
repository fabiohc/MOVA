import 'package:emanuellemepoupe/model/agenda_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AgendaHelper {
  static final AgendaHelper _instance = AgendaHelper.internal();

  AgendaHelper.internal();

  factory AgendaHelper() => _instance;

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

  insert(AgendaModel agenda) async {
    Database dbAgenda = await db;
    await dbAgenda.insert("agenda", agenda.toMap());
  }

  Future<AgendaModel> selectById(String id) async {
    Database dbagenda = await db;
    List<Map> maps = await dbagenda.query("agenda",
        columns: [
          "agenIdGlobal",
          "agenTitulo",
          "agenDataInicio",
          "agenHoraInico",
          "agenHoraFim",
          "agenDescricao",
          "agenCor",
          "agenDiaTodo",
          "agenEventoAtivo",
          "agenPessoaIdVinculado"
        ],
        where: "agenIdGlobal = ?",
        whereArgs: [id]);
    if (maps.length > 0) {
      return AgendaModel.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<List<AgendaModel>> selectAll() async {
    Database dbagenda = await db;
    List list = await dbagenda.rawQuery("Select * from agenda");

    List<AgendaModel> lsagenda = [];
    for (Map compromisso in list) {
      lsagenda.add(AgendaModel.fromMap(compromisso));
    }
    return lsagenda;
  }

  void update(AgendaModel agenda) async {
    Database dbagenda = await db;
    dbagenda.update("agenda", agenda.toMap(),
        where: "agenIdGlobal = ?", whereArgs: [agenda.agenIdGlobal]);
  }

  delete(String id) async {
    Database dbagenda = await db;
    return await dbagenda
        .delete("agenda", where: "agenIdGlobal = ?", whereArgs: [id]);
  }

  Future close() async {
    Database dbagenda = await db;
    dbagenda.close();
  }
}
