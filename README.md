A handy library for computing equations that contain uncertainties.

## Usage

A simple usage example, for calculating the mass of the energy converted from gravitational energy when a (10000000000000000 ± 10000000) kg mass is dropped (5 ± 0.1) metres.
Rearranging the equations `E = m_2 * c^2` and `E = m_1 * g * h` gives: `m_2 = (m_1 * g * h) / (c^2)`

```dart
import 'package:uncertain_solver/uncertain_solver.dart';
import 'package:decimal/decimal.dart';

main() {
      final m_1 = EquationValue.fromUncertaintyPlusMinus(Decimal.parse('10000000000000000'), uncertaintyPlusMinus: Decimal.parse('10000000'));
      final g = EquationValue(Decimal.parse('9.7988'), uncertaintyPercentage: Decimal.parse('0.7'));  // From: https://physics.stackexchange.com/a/93298
      final h = EquationValue.fromUncertaintyPlusMinus(Decimal.fromInt(5), uncertaintyPlusMinus: Decimal.parse('0.1'));
      final c = EquationValue(Decimal.parse('299792458'), uncertaintyPercentage: Decimal.fromInt(0));
    
      final m_2 = EquationBracket(
        [
            EquationBracket([m_1, g, h], operator: EquationOperator.multiply),
            EquationPower(c, power: 2)
        ],
        operator: EquationOperator.divide
      );
    
      print(m_2);
}
```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/tfinlay/uncertain_solver/issues
