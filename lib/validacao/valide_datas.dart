import 'package:intl/intl.dart';

class ValideDatas {
  validedata(data) {
    try {
      DateFormat inputFormat = DateFormat("dd/MM/yyyy");
      DateTime dataConvertida = inputFormat.parseLoose(data);

      if (dataConvertida.year > DateTime.now().year)
        return "Data invalida! Insira uma data correta.";
      print(DateTime.now().year.toString());

      if (dataConvertida.month > 12) return "Mês informado invalido";

      if (dataConvertida.day >
          DateTime(DateTime.now().year, DateTime.now().month, 0).day)
        return "Dia informado invalido";

      return null;
    } catch (e) {
      return "Data com fomato invalido!";
    }
  }
}
