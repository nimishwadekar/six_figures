import 'package:hive/hive.dart';

part 'ledger_category.g.dart';

@HiveType(typeId: 2)
class LedgerCategory extends HiveObject {
  LedgerCategory({
    required this.name,
    required this.position,
    required this.iconKey,
    required this.colorArgb,
  });

  @HiveField(0)
  final String name;

  @HiveField(1)
  final int position;

  @HiveField(2)
  final String iconKey;

  @HiveField(3)
  final int colorArgb;
}
