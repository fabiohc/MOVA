import 'package:emanuellemepoupe/model/usuario_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class UsuarioHelper {
  static final UsuarioHelper _instance = UsuarioHelper.internal();

  UsuarioHelper.internal();

  factory UsuarioHelper() => _instance;

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

  Future<UsuarioModel> insert(UsuarioModel usuario) async {
    Database dbUsuario = await db;
    usuario.id = await dbUsuario.insert("usuario", usuario.toMap());
    return usuario;
  }

  Future<UsuarioModel> selectById(int id) async {
    Database dbUsuario = await db;
    List<Map> maps = await dbUsuario.query("usuario",
        columns: [
          "id",
          "nome",
          "email",
          "senha",
        ],
        where: "id = ?",
        whereArgs: [id]);
    if (maps.length > 0) {
      return UsuarioModel.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<List<UsuarioModel>> selectAll() async {
    Database dbUsuario = await db;
    List<UsuarioModel> listaUsuario =[];

    List list = await dbUsuario.rawQuery("SELECT * " + " FROM  usuario ");

    for (Map user in list) {
      listaUsuario.add(UsuarioModel.fromMap(user));
    }

    return listaUsuario;
  }

  Future<int> update(UsuarioModel usuario) async {
    Database dbUsuario = await db;
    return await dbUsuario.update("usuario", usuario.toMap(),
        where: "id = ?", whereArgs: [usuario.id]);
  }

  Future<int> delete(String id) async {
    Database dbUsuario = await db;
    return await dbUsuario
        .delete("usuario", where: "id = ?", whereArgs: [id]);
  }

  Future close() async {
    Database dbUsuario = await db;
    dbUsuario.close();
  }
}
