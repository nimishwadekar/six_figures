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
    name: 'Transportation',
    position: 0,
    iconKey: 'train',
    colorArgb: 0xFFE65100,
  ),
  LedgerCategorySeed(
    name: 'Restaurants',
    position: 1,
    iconKey: 'restaurant',
    colorArgb: 0xFF00897B,
  ),
  LedgerCategorySeed(
    name: 'Accommodation',
    position: 2,
    iconKey: 'hotel',
    colorArgb: 0xFF6D4C41,
  ),
  LedgerCategorySeed(
    name: 'Groceries',
    position: 3,
    iconKey: 'shopping_cart',
    colorArgb: 0xFF1E88E5,
  ),
  LedgerCategorySeed(
    name: 'Shopping',
    position: 4,
    iconKey: 'shopping_bag',
    colorArgb: 0xFF2E7D32,
  ),
  LedgerCategorySeed(
    name: 'Activities',
    position: 5,
    iconKey: 'kayaking',
    colorArgb: 0xFF5C6BC0,
  ),
  LedgerCategorySeed(
    name: 'Drinks',
    position: 6,
    iconKey: 'local_bar',
    colorArgb: 0xFF1E88E5,
  ),
  LedgerCategorySeed(
    name: 'Coffee',
    position: 7,
    iconKey: 'coffee',
    colorArgb: 0xFF1E88E5,
  ),
  LedgerCategorySeed(
    name: 'Flights',
    position: 8,
    iconKey: 'flight',
    colorArgb: 0xFFE65100,
  ),
  LedgerCategorySeed(
    name: 'General',
    position: 9,
    iconKey: 'sell',
    colorArgb: 0xFFB0BEC5,
  ),
  LedgerCategorySeed(
    name: 'Fees & Charges',
    position: 10,
    iconKey: 'paid',
    colorArgb: 0xFF5C6BC0,
  ),
  LedgerCategorySeed(
    name: 'Sightseeing',
    position: 11,
    iconKey: 'museum',
    colorArgb: 0xFF5C6BC0,
  ),
  LedgerCategorySeed(
    name: 'Entertainment',
    position: 12,
    iconKey: 'movie',
    colorArgb: 0xFF5C6BC0,
  ),
  LedgerCategorySeed(
    name: 'Laundry',
    position: 13,
    iconKey: 'local_laundry_service',
    colorArgb: 0xFF00897B,
  ),
  LedgerCategorySeed(
    name: 'Exchange Fees',
    position: 14,
    iconKey: 'currency_exchange',
    colorArgb: 0xFF1E88E5,
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
