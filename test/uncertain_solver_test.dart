import 'package:decimal/decimal.dart';
import 'package:uncertain_solver/src/util.dart';
import 'package:uncertain_solver/uncertain_solver.dart';
import 'package:test/test.dart';

void main() {
  group('EquationBrackets', () {

    test('Addition', () {
      final eq = EquationBracket(
          [
            EquationValue.fromUncertaintyPlusMinus(Decimal.fromInt(1), uncertaintyPlusMinus: Decimal.parse('0.001')),
            EquationValue.fromUncertaintyPlusMinus(Decimal.fromInt(1), uncertaintyPlusMinus: Decimal.parse('0.001')),
          ],
          operator: EquationOperator.add
      );

      expect(eq.value, equals(Decimal.fromInt(2)));
      expect(eq.uncertaintyPlusMinus, equals(Decimal.parse('0.002')));
    });
  });
}
