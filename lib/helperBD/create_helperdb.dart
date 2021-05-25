import 'package:emanuellemepoupe/repository/agenda_repository.dart';
import 'package:emanuellemepoupe/repository/despesa_repository.dart';
import 'package:emanuellemepoupe/repository/parcela_repository.dart';
import 'package:emanuellemepoupe/repository/pessoa_repository.dart';
import 'package:emanuellemepoupe/repository/receita_repository.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class CreateHelper {
  static final CreateHelper _instance = CreateHelper.internal();

  inicializaDadosFirebase() {
    DespesaRepository().selectListerneFirestore();
    ReceitaRepository().selectListerneFirestore();
    PessoaRepository().selectListerneFirestore();
    AgendaRepository().selectListerneFirestore();
    ParcelaRepository().selectListerneFirestore();
  }

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
        "despIntegrado BOLEAN,"
        "despPessoaIdVinculado TEXT"
        ")";

    final String sqlparcelas = "CREATE TABLE parcelas ("
        "parcelaId INT PRIMARY KEY,"
        "parcelaIdGlobal TEXT,"
        "parcelaNumero INT,"
        "parcelaQuatParc INT,"
        "parcelaValor TEXT,"
        "parcelaData TEXT,"
        "parcelaStatusPag BOLEAN,"
        "parcelaIntegrado BOLEAN,"
        "pacelaPessoaIdVinculado TEXT"
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
        "recIntegrado BOLEAN,"
        "recPessoaIdVinculado TEXT"
        ")";

    final String sqlpessoa = "CREATE TABLE pessoa ("
        "pessoaId INT PRIMARY KEY,"
        "pessoaIdGlobal TEXT,"
        "pessoaNome TEXT,"
        "pessoaCpf INT,"
        "pessoaDataNascimento TEXT,"
        "pessoaTelefone TEXT,"
        "pessoaEmail TEXT,"
        "pessoafotourl TEXT"
        ")";

    final String sqlagenda = "CREATE TABLE agenda ("
        "agenIdGlobal INT PRIMARY KEY,"
        "agenTitulo TEXT,"
        "agenDataInicio TEXT,"
        "agenHoraInico TEXT,"
        "agenHoraFim TEXT,"
        "agenDescricao TEXT,"
        "agenCor TEXT,"
        "agenDiaTodo BOLEAN,"
        "agenEventoAtivo BOLEAN,"
        "agenPessoaIdVinculado TEXT"
        ")";

    final String sqlusuario = "CREATE TABLE usuario ("
        "senha TEXT PRIMARY KEY,"
        "nome TEXT,"
        "email TEXT"
        ")";

    return await openDatabase(pastaBD, version: 1,
        onCreate: (Database db, int newerVersion) async {
      await db.execute(sql);
      await db.execute(sqlparcelas);
      await db.execute(sqlreceita);
      await db.execute(sqlpessoa);
      await db.execute(sqlagenda);
      await db.execute(sqlusuario);
      db.close();
    });
  }
}
