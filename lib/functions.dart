import 'dart:math' show sqrt;

import 'package:decimal/decimal.dart';


Decimal square_root_imprecise(Decimal primaryValue, List<dynamic> secondaryArguments) {
  /// Square root function. WARNING: Precision is lost due to conversion from Decimal to Double!
  return Decimal.parse(sqrt(primaryValue.toDouble()).toString());
}