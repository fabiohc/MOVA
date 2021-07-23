import 'package:emanuellemepoupe/model/carteira_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class CarteiraHelper {
  static final CarteiraHelper _instance = CarteiraHelper.internal();

  CarteiraHelper.internal();

  factory CarteiraHelper() => _instance;

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
      //await db.execute(sql);
      /*await db.execute(sqlparcelas);
      await db.execute(sqlreceita);*/
    });
  }

  Future<List> selectAll() async {
    Database dbReceita = await db;

    String sql = "SELECT "+
        "[data], " +
        "[valor]," +
        "[numParcela]," +
        "[parcelaQuatParc]," +
        "[statusPg]," +
        "[tipo]     " +
        "FROM   (SELECT   " +
        "[d].[despData] AS [data],  " +
        "[d].[despValor] AS [valor]," +
        "0 AS [numParcela],         " +
        "0 AS [parcelaQuatParc],    " +
        "[d].[despesaStatusPag] AS [statusPg]," +
        "'despesa' AS [tipo]" +
        " FROM   [despesa] [d]      " +
        " WHERE  [d].[despNumeroParcelas] = 0" +
        " UNION " +
        " SELECT                            " +
        "[r].[recData] AS [data],   " +
        "[r].[recValor] AS [valor], " +
        "0 AS [numParcela],         " +
        "0 AS [parcelaQuatParc],    " +
        "[r].[recStatusPag] AS [statusPg]," +
        "'receita' AS [tipo]  " +
        " FROM   [receita] [r]        " +
        " WHERE  [r].[recNumeroParcelas] = 0" +
        " UNION  " +
        " SELECT " +
        "[p].[parcelaData] AS [data],    " +
        "[p].[parcelaValor] AS [valor],  " +
        "[p].[parcelaNumero] AS [numParcela]," +
        "[p].[parcelaQuatParc] AS [parcelaQuatParc],  " +
        "[p].[parcelaStatusPag] AS [statusPg]," +
        "'parcelarec' AS [tipo]" +
        " FROM   [parcelas] [p]        " +
        " WHERE  [parcelaIdGlobal] LIKE '%rec%' " +
        " UNION     " +
        " SELECT    " +
        "[p].[parcelaData] AS [data],    " +
        "[p].[parcelaValor] AS [valor],  " +
        "[p].[parcelaNumero] AS [numParcela]," +
        "[p].[parcelaQuatParc] AS [parcelaQuatParc]," +
        "[p].[parcelaStatusPag] AS [statusPg], " +
        "'parceladesp' AS [tipo] " +
        "		FROM   [parcelas] [p]" +
        "		WHERE  [parcelaIdGlobal] LIKE '%desp%') AS consulta" +
        " ORDER  BY [data] desc;";

    List list = await dbReceita.rawQuery(sql);
    List<CarteiraModel> listaReceitas = [];
    for (Map m in list) {
      listaReceitas.add(CarteiraModel.fromMap(m));
    }
    return listaReceitas;
  }
}
