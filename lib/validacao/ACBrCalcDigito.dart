import "string_extensions.dart";

enum ACBrCalcDigFormula { frModulo11, frModulo10, frModulo10PIS }


class ACBrCalcDigito {
  int fsMultIni = 2;
  int fsMultFim = 9;
  int fsMultAtu = 0;
  ACBrCalcDigFormula fsFormulaDigito = ACBrCalcDigFormula.frModulo11;
  String fsDocto = '';
  int fsDigitoFinal = 0;
  int fsSomaDigitos = 0;
  int fsModuloFinal = 2;
  ACBrCalcDigito() {
    fsMultAtu = 0;
  }
  String get documento => fsDocto;
  set documento(String x) {
    fsDocto = x;
  }

  int get multiplicadorInicial => fsMultIni;
  set multiplicadorInicial(int x) {
    fsMultIni = x;
  }

  int get multiplicadorFinal => fsMultFim;
  set multiplicadorFinal(int x) {
    fsMultFim = x;
  }

  calculoPadrao() {
    fsMultIni = 2;
    fsMultFim = 9;
    fsMultAtu = 0;
    fsFormulaDigito = ACBrCalcDigFormula.frModulo11;
  }

  calcular() {
    int N, base, tamanho, valorCalc;
    String valorCalcSTR;

    fsSomaDigitos = 0;
    fsDigitoFinal = 0;
    fsModuloFinal = 0;

    if ((fsMultAtu >= fsMultIni) && (fsMultAtu <= fsMultFim))
      base = fsMultAtu;
    else
      base = fsMultIni;
    tamanho = fsDocto.length;

    //{ Calculando a Soma dos digitos de traz para diante, multiplicadas por BASE }
    for (var A = 0; A < tamanho; A++) {
      N = (fsDocto[tamanho - A - 1]).toIntDef(0);
      valorCalc = (N * base);

      if ((fsFormulaDigito == ACBrCalcDigFormula.frModulo10) &&
          (valorCalc > 9)) {
        valorCalcSTR = valorCalc.toString();
        valorCalc = (valorCalcSTR[1]).toInt() + (valorCalcSTR[2]).toInt();
      }

      fsSomaDigitos = fsSomaDigitos + valorCalc;

      if (fsMultIni > fsMultFim) {
        base--;
        if (base < fsMultFim) base = fsMultIni;
      } else {
        base++;
        if (base > fsMultFim) base = fsMultIni;
      }
    }

    switch (fsFormulaDigito) {
      case ACBrCalcDigFormula.frModulo11:
        {
          fsModuloFinal = fsSomaDigitos % 11;

          if (fsModuloFinal < 2)
            fsDigitoFinal = 0;
          else
            fsDigitoFinal = 11 - fsModuloFinal;
          break;
        }

      case ACBrCalcDigFormula.frModulo10PIS:
        {
          fsModuloFinal = (fsSomaDigitos % 11);
          fsDigitoFinal = 11 - fsModuloFinal;

          if (fsDigitoFinal >= 10) fsDigitoFinal = 0;
          break;
        }

      case ACBrCalcDigFormula.frModulo10:
        {
          fsModuloFinal = (fsSomaDigitos % 10);
          fsDigitoFinal = 10 - fsModuloFinal;

          if (fsDigitoFinal >= 10) fsDigitoFinal = 0;
          break;
        }
      default:
        {
          throw 'ACBrCalcDigFormula inválido';
        }
    }
  }
}

class ACBrValidador {}