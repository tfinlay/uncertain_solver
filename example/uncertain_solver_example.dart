import 'package:decimal/decimal.dart';
import 'package:uncertain_solver/src/util.dart';
import 'package:uncertain_solver/uncertain_solver.dart';

Decimal D(String v) => Decimal.parse(v);
Decimal Di(int v) => Decimal.fromInt(v);

void main() {
  final m_1 = EquationValue.fromUncertaintyPlusMinus(Decimal.parse('10000000000000000'), uncertaintyPlusMinus: Decimal.parse('10000000'));
  final g = EquationValue(Decimal.parse('9.7988'), uncertaintyPercentage: Decimal.parse('0.7'));  // From: https://physics.stackexchange.com/a/93298
  final h = EquationValue.fromUncertaintyPlusMinus(Decimal.fromInt(5), uncertaintyPlusMinus: Decimal.parse('0.1'));
  final c = EquationValue(Decimal.parse('299792458'), uncertaintyPercentage: Decimal.fromInt(0));

  final m_2 = EquationBracket(
      [
        EquationBracket([m_1, g, h], operator: EquationOperator.multiply),
        PowerComponent(c, power: 2)
      ],
      operator: EquationOperator.divide
  );

  print(m_2);
}
