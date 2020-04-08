import 'package:decimal/decimal.dart';
import 'package:meta/meta.dart';
import 'package:uncertain_solver/src/util.dart';


@immutable
abstract class EquationComponent {
  Decimal get value;
  Decimal get uncertaintyPercentage;
  Decimal get uncertaintyPlusMinus => value * uncertaintyPercentage;

  @override
  String toString() => '<$runtimeType $value ± $uncertaintyPlusMinus (%𝛿 = $uncertaintyPercentage)>';
}

class EquationValue extends EquationComponent {
  @override
  final Decimal value;

  @override
  final Decimal uncertaintyPercentage;

  EquationValue(
    this.value,
  {
    @required this.uncertaintyPercentage
  }) : assert(value != null), assert(uncertaintyPercentage != null);

  EquationValue.fromUncertaintyPlusMinus(
    this.value,
  {
    @required Decimal uncertaintyPlusMinus
  }) : assert(value != null), assert(uncertaintyPlusMinus != null), uncertaintyPercentage = uncertaintyPlusMinus / value;

}

class EquationBracket extends EquationComponent {
  final List<EquationComponent> values;
  final EquationOperator operator;

  @override
  Decimal get value => applyOperatorToGetValues(operator, values: values.map((e) => e.value).toList());

  @override
  Decimal get uncertaintyPercentage => applyOperatorToGetUncertaintyPercentage(operator, values: values);

  EquationBracket(
    this.values,
  {
    @required this.operator
  }) : assert(values != null), assert(operator != null);
}

class PowerComponent extends EquationComponent {
  /// Although this can be done with a FunctionComponent, this way minimises errors when working with powers of positive integers.
  final int power;
  final EquationComponent argument;
  
  final EquationBracket _bracket;
  
  @override
  Decimal get value => _bracket.value;
  
  @override
  Decimal get uncertaintyPercentage => _bracket.uncertaintyPercentage;
  
  @override
  Decimal get uncertaintyPlusMinus => _bracket.uncertaintyPlusMinus;
  
  PowerComponent(
      this.argument,
  {
    @required this.power,
  }
  ) : assert(argument != null), assert(power != null), assert(power > 0, "Only positiver integer powers are allowed. For other values, use a FunctionComponent"), _bracket = EquationBracket(
    List.filled(power, argument),
    operator: EquationOperator.multiply
  );
}

class FunctionComponent extends EquationComponent {
  /// A generic EquationComponent that adds function support (e.g. sin, cos, tan, sqrt, ...)
  final EquationFunction function;
  final EquationComponent primaryArgument;
  final List<dynamic> secondaryArguments;

  @override
  Decimal get value => function(primaryArgument.value, secondaryArguments);

  /// Uses the brute-force method.
  @override
  Decimal get uncertaintyPlusMinus => function(
      primaryArgument.value + primaryArgument.uncertaintyPlusMinus,
      secondaryArguments
  ) - function(primaryArgument.value, secondaryArguments);

  @override
  Decimal get uncertaintyPercentage => uncertaintyPlusMinus / value;

  FunctionComponent(
      this.function,
  {
    @required this.primaryArgument,
    this.secondaryArguments = const []
  }
  ) : assert(function != null), assert(primaryArgument != null), assert(secondaryArguments != null);
}