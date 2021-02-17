import 'package:emanuellemepoupe/model/pessoa_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class PessoaHelper {
  static final PessoaHelper _instance = PessoaHelper.internal();

  PessoaHelper.internal();

  factory PessoaHelper() => _instance;

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

  Future<PessoaModel> insert(PessoaModel pessoa) async {
    Database dbPessoa = await db;
    pessoa.pessoaId = await dbPessoa.insert("pessoa", pessoa.toMap());
    return pessoa;
  }

  Future<int> update(PessoaModel pessoa) async {
    Database dbPessoa = await db;
    return await dbPessoa.update("pessoa", pessoa.toMap(),
        where: "pessoaIdGlobal = ?", whereArgs: [pessoa.pessoaIdGlobal]);
  }

  delete(String id) async {
    Database dbPessoa = await db;
    return await dbPessoa
        .delete("pessoa", where: "pessoaIdGlobal = ?", whereArgs: [id]);
  }


  Future<PessoaModel> selectById(int id) async {
    Database dbPessoa = await db;
    List<Map> maps = await dbPessoa.query("pessoa",
        columns: [
          "pessoaId",
          "pessoaIdGlobal",
          "pessoaNome",
          "pessoaDataNascimento",
          "pessoaEmail",
          "pessoaTelefone",
          "pessoaCpf"
        ],
        where: "pessoaId = ?",
        whereArgs: [id]);
    if (maps.length > 0) {
      return PessoaModel.fromMap(maps.first, false);
    } else {
      return null;
    }
  }

  Future<List<PessoaModel>> selectAll() async {
    Database dbPessoa = await db;
    // List list = await dbPessoa.rawQuery("Select * from despesa");
    List list = await dbPessoa.rawQuery("SELECT * from pessoa order by pessoaNome asc");
    List<PessoaModel> lsPessoa = List();
    for (Map m in list) {
      lsPessoa.add(PessoaModel.fromMap(m, false));
    }
    return lsPessoa;
  }

  
 
  Future close() async {
    Database dbPessoa = await db;
    dbPessoa.close();
  }
}
