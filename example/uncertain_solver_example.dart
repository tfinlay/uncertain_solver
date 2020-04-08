import 'package:decimal/decimal.dart';
import 'package:uncertain_solver/src/util.dart';
import 'package:uncertain_solver/uncertain_solver.dart';

Decimal D(String v) => Decimal.parse(v);
Decimal Di(int v) => Decimal.fromInt(v);

void main() {
  final m = EquationValue.fromUncertaintyPlusMinus(D('0.189'), uncertaintyPlusMinus: D('0.002'));
  final g = EquationValue.fromUncertaintyPlusMinus(D('9.81'), uncertaintyPlusMinus: D('0.01'));
  final R = EquationValue.fromUncertaintyPlusMinus(D('0.015'), uncertaintyPlusMinus: D('0.001'));

  final alpha_1 = EquationValue.fromUncertaintyPlusMinus(D('0.2349'), uncertaintyPlusMinus: D('0.0001'));
  final alpha_2 = EquationValue.fromUncertaintyPlusMinus(D('-0.06873'), uncertaintyPlusMinus: D('0.00001'));

  final I_1 = EquationBracket(
      [
        EquationBracket([m, g, R], operator: EquationOperator.multiply),
        EquationBracket([alpha_1, alpha_2], operator: EquationOperator.subtract)
      ],
      operator: EquationOperator.divide
  );

  print("($m * $g * $R) / ($alpha_1 - $alpha_2)");

  print(I_1);
}
