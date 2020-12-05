import 'package:emanuellemepoupe/controller/util.dart';
import 'package:emanuellemepoupe/helperBD/carteira_helperdb.dart';
import 'package:emanuellemepoupe/helperBD/parcela_helperdb.dart';
import 'package:emanuellemepoupe/model/carteira_model.dart';
import 'package:mobx/mobx.dart';
part 'carteira_controller.g.dart';

class CarteiraController = _CarteiraControllerBase with _$CarteiraController;
var parcelaHelper = ParcelaHelper();
var carteiraHelper = CarteiraHelper();
var util = Util();

abstract class _CarteiraControllerBase with Store {
  @observable
  obtentaListaCompleta() async {
    List lista = await carteiraHelper.selectAll();
    return lista;
  }

  @observable
  obtentaListaDeParcelas(String id) async {
    var lista = await parcelaHelper.selectAll();
    return lista;
  }

 
   double obtentaSoma(List<CarteiraModel> listaCarteira, String mesAno, String tipo) {
    var soma = util.obtenhaSomaValorPorTipo(
        listaCarteira, mesAno.toString(), tipo);
    return soma;
  }


}
