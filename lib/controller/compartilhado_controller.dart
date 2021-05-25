import 'package:connectivity/connectivity.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter/material.dart';
import 'package:emanuellemepoupe/controller/despesa_controller.dart';
import 'package:emanuellemepoupe/model/despesa_model.dart';
part 'compartilhado_controller.g.dart';

class CompartilhadoController = _CompartilhadoControllerBase
    with _$CompartilhadoController;

abstract class _CompartilhadoControllerBase with Store {
  var despesaController = DespesaController();

  @observable
  var despesaModel = DespesaModel();

  // #region ValueNotifier

  final dataVencimento = ValueNotifier<DateTime>(DateTime.now());

  final numeroParcela = ValueNotifier<int>(0);

  final valor = ValueNotifier<String>("");

  final radioButton = ValueNotifier<bool>(false);

  final radioDinheiro = ValueNotifier<bool>(true);

  final radioDebito = ValueNotifier<bool>(true);

  final radioctransfer = ValueNotifier<bool>(true);

  final radioCredito = ValueNotifier<bool>(true);


  valideCheckRadio([dynamic check]) {
    if (check == null) check = false;
    if (check == false) {
      alteraradio(check);
      return "Selecione uma forma de pagamento!";
    }
    return null;
  }

  alteraradioEdicao([String forma, String tipo]) {
    if (forma == "Dinheiro") {
      radioDinheiro.value = false;
      radioDebito.value = true;
      radioctransfer.value = true;
      radioCredito.value = true;
      return "tipo";
    }

    if (forma == "Transferência") {
      radioDinheiro.value = true;
      radioDebito.value = true;
      radioctransfer.value = false;
      radioCredito.value = true;
      return "tipo";
    }

    if (forma == "Cartão" && tipo == "Crédito") {
      radioDinheiro.value = true;
      radioDebito.value = true;
      radioctransfer.value = true;
      radioCredito.value = false;
      return "tipo";
    }

    if (forma == "Cartão" && tipo == "Débito") {
      radioDinheiro.value = true;
      radioDebito.value = false;
      radioctransfer.value = true;
      radioCredito.value = true;
      return "tipo";
    }

    return null;
  }

  alteraradio(bool value) {
    radioButton.value = value;
  }

  alteraDataVenvimento(DateTime value) {
    dataVencimento.value = value;
  }

  inicializeNumeroParcela(int numero) {
    numeroParcela.value = numero;
  }

  decrementeNumeroParcela() {
    if (numeroParcela.value > 0 && numeroParcela.value <= 12)
      numeroParcela.value--;
  }

  incrementeNumeroParcela() {
    if (numeroParcela.value > -1 && numeroParcela.value < 12)
      numeroParcela.value++;
  }

// #endregion

  verifiqueConexao() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }
}
