// Amount formatting helpers. Converts an integer-cents amount into the
// raw "units.fraction" string used to seed the amount text field when
// editing an existing expense.

String formatRawAmount(int cents) {
  final absolute = cents.abs();
  final units = absolute ~/ 100;
  final decimal = (absolute % 100).toString().padLeft(2, '0');
  return '$units.$decimal';
}
