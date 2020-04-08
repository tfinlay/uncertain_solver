import 'package:decimal/decimal.dart';
import 'package:meta/meta.dart';

import '../uncertain_solver.dart';

enum EquationOperator {
  add, subtract, multiply, divide
}

typedef MathFunction = Decimal Function (Decimal primaryValue, List<dynamic> secondaryArguments);

Decimal sum(Iterable<Decimal> values) => values.fold(Decimal.fromInt(0), (sumSoFar, value) => sumSoFar + value);

// ignore: missing_return
Decimal applyOperatorToGetValues(EquationOperator operator, {@required List<Decimal> values}) {
  switch (operator) {
    case EquationOperator.add:
      return sum(values);
    case EquationOperator.subtract:
      assert(values.length == 2);
      return values[0] - values[1];
    case EquationOperator.multiply:
      return values.fold(Decimal.fromInt(1), (productSoFar, value) => productSoFar * value);
    case EquationOperator.divide:
      assert(values.length == 2);
      return values[0] / values[1];
  }
}

// ignore: missing_return
Decimal applyOperatorToGetUncertaintyPercentage(EquationOperator operator, {@required List<EquationComponent> values}) {
  switch (operator) {
    case EquationOperator.multiply:
      return sum(values.map((e) => e.uncertaintyPercentage));
    case EquationOperator.divide:
      return sum(values.map((e) => e.uncertaintyPercentage));

    case EquationOperator.add:
      return sum(values.map((e) => e.uncertaintyPlusMinus)) / sum(values.map((e) => e.value));
    case EquationOperator.subtract:
      return sum(values.map((e) => e.uncertaintyPlusMinus)) / sum(values.map((e) => e.value));
  }
}