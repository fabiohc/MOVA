import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class CreateHelper {
  static final CreateHelper _instance = CreateHelper.internal();

  CreateHelper.internal();

  factory CreateHelper() => _instance;
  Database _db;

Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return db;
  }

  Future<Database> initDb() async { 
     Database db = await _db;
    final pasta = await getDatabasesPath();
    final pastaBD = join(pasta, "emanuelle.db");

    final String sql = "CREATE TABLE despesa ("
        "despId INT PRIMARY KEY,"
        "despIdGlobal TEXT,"
        "despServico TEXT,"
        "despValor DOUBLE,"
        "despData TEXT,"
        "despFormaPagamento TEXT,"
        "despTipoCartao TEXT,"
        "despNumeroParcelas INT,"
        "despObservacao TEXT,"
        "despesaStatusPag BOLEAN,"
        "despIntegrado BOLEAN"
        ")";

    final String sqlparcelas = "CREATE TABLE parcelas ("
        "parcelaId INT PRIMARY KEY,"
        "parcelaIdGlobal TEXT,"
        "parcelaNumero INT,"
        "parcelaQuatParc INT,"
        "parcelaValor TEXT,"
        "parcelaData TEXT,"
        "parcelaStatusPag BOLEAN,"
        "parcelaIntegrado BOLEAN"
        ")";

    final String sqlreceita = "CREATE TABLE receita ("
        "recId INT PRIMARY KEY,"
        "recIdGlobal TEXT,"
        "recServico TEXT,"
        "recValor DOUBLE,"
        "recData TEXT,"
        "recFormaPagamento TEXT,"
        "recTipoCartao TEXT,"
        "recObservacao TEXT,"
        "recNumeroParcelas INT,"
        "recStatusPag BOLEAN,"
        "recIntegrado BOLEAN"
        ")";

    return await openDatabase(pastaBD, version: 1,
        onCreate: (Database db, int newerVersion) async {
      await db.execute(sql);
      await db.execute(sqlparcelas);
      await db.execute(sqlreceita);
      db.close();
    });
  }
}
