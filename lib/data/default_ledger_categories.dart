import '../models/ledger_category.dart';

class LedgerCategorySeed {
  const LedgerCategorySeed({
    required this.name,
    required this.position,
    required this.iconKey,
    required this.colorArgb,
  });

  final String name;
  final int position;
  final String iconKey;
  final int colorArgb;

  LedgerCategory toLedgerCategory() {
    return LedgerCategory(
      name: name,
      position: position,
      iconKey: iconKey,
      colorArgb: colorArgb,
    );
  }
}

const List<LedgerCategorySeed> kDefaultExpenseCategories = [
  LedgerCategorySeed(
    name: 'Food & Drink',
    position: 0,
    iconKey: 'restaurant',
    colorArgb: 0xFF00897B,
  ),
  LedgerCategorySeed(
    name: 'Groceries',
    position: 1,
    iconKey: 'shopping_cart',
    colorArgb: 0xFF1E88E5,
  ),
  LedgerCategorySeed(
    name: 'Transport',
    position: 2,
    iconKey: 'train',
    colorArgb: 0xFFE65100,
  ),
  LedgerCategorySeed(
    name: 'Shopping',
    position: 3,
    iconKey: 'shopping_bag',
    colorArgb: 0xFF2E7D32,
  ),
  LedgerCategorySeed(
    name: 'Bills',
    position: 4,
    iconKey: 'receipt_long',
    colorArgb: 0xFF6D4C41,
  ),
  LedgerCategorySeed(
    name: 'Subscriptions',
    position: 5,
    iconKey: 'subscriptions',
    colorArgb: 0xFF5C6BC0,
  ),
  LedgerCategorySeed(
    name: 'Entertainment',
    position: 6,
    iconKey: 'movie',
    colorArgb: 0xFF5C6BC0,
  ),
  LedgerCategorySeed(
    name: 'Health',
    position: 7,
    iconKey: 'local_hospital',
    colorArgb: 0xFFC62828,
  ),
  LedgerCategorySeed(
    name: 'Gifts',
    position: 8,
    iconKey: 'card_giftcard',
    colorArgb: 0xFF5C6BC0,
  ),
  LedgerCategorySeed(
    name: 'Flights',
    position: 9,
    iconKey: 'flight',
    colorArgb: 0xFFE65100,
  ),
  LedgerCategorySeed(
    name: 'Exchange Fees',
    position: 10,
    iconKey: 'currency_exchange',
    colorArgb: 0xFF1E88E5,
  ),
  LedgerCategorySeed(
    name: 'Other',
    position: 11,
    iconKey: 'sell',
    colorArgb: 0xFFB0BEC5,
  ),
];

const List<LedgerCategorySeed> kDefaultIncomeCategories = [
  LedgerCategorySeed(
    name: 'Other Income',
    position: 0,
    iconKey: 'payments',
    colorArgb: 0xFFFFB300,
  ),
  LedgerCategorySeed(
    name: 'Salary',
    position: 1,
    iconKey: 'account_balance_wallet',
    colorArgb: 0xFF00897B,
  ),
  LedgerCategorySeed(
    name: 'Gifts',
    position: 2,
    iconKey: 'card_giftcard',
    colorArgb: 0xFF5C6BC0,
  ),
];
