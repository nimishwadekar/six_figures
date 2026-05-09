// Hive-persisted Income model — same field layout as [Expense] but stored
// in the `incomebox` Hive box. The generated adapter lives in income.g.dart.

import 'package:hive/hive.dart';

part 'income.g.dart';

@HiveType(typeId: 1)
class Income extends HiveObject {
  Income({
    required this.date,
    required this.category,
    required this.name,
    required this.currency,
    required this.amountCents,
    required this.tag,
  });

  @HiveField(0)
  final DateTime date;

  @HiveField(1)
  final String category;

  @HiveField(2)
  final String name;

  @HiveField(3)
  final String currency;

  @HiveField(4)
  final int amountCents;

  @HiveField(5)
  final String tag;

  String get amountDisplay {
    final isNegative = amountCents < 0;
    final absolute = amountCents.abs();
    final units = absolute ~/ 100;
    final cents = (absolute % 100).toString().padLeft(2, '0');
    return '${isNegative ? '-' : ''}$units.$cents';
  }

  static int parseAmountToCents(String input) {
    final normalized = input.trim().replaceAll(',', '');
    final pattern = RegExp(r'^-?\d+(\.\d{1,2})?$');
    if (!pattern.hasMatch(normalized)) {
      throw const FormatException('Amount must have at most 2 decimal places');
    }

    final negative = normalized.startsWith('-');
    final parts = normalized.replaceFirst('-', '').split('.');
    final whole = int.parse(parts[0]);
    final fraction = parts.length == 2 ? parts[1].padRight(2, '0') : '00';
    final cents = whole * 100 + int.parse(fraction);
    return negative ? -cents : cents;
  }
}
