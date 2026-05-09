import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../models/ledger_category.dart';
import '../services/hive_service.dart';
import 'category_icon_keys.dart';

String _norm(String category) => category.trim().toLowerCase();

LedgerCategory? _findInBox(
  Box<LedgerCategory> Function() boxGetter,
  String category,
) {
  try {
    final box = boxGetter();
    for (final item in box.values) {
      if (_norm(item.name) == _norm(category)) {
        return item;
      }
    }
  } catch (_) {}
  return null;
}

LedgerCategory? _findAny(String category) {
  return _findInBox(() => HiveService.expenseCategoriesBox, category) ??
      _findInBox(() => HiveService.incomeCategoriesBox, category);
}

Color _currentBackground(String category) {
  switch (_norm(category)) {
    case 'food & drink':
      return const Color(0xFF00897B);
    case 'groceries':
      return const Color(0xFF1E88E5);
    case 'transport':
      return const Color(0xFFE65100);
    case 'shopping':
      return const Color(0xFF2E7D32);
    case 'bills':
      return const Color(0xFF6D4C41);
    case 'subscriptions':
    case 'entertainment':
    case 'gifts':
      return const Color(0xFF5C6BC0);
    case 'health':
      return const Color(0xFFC62828);
    case 'flights':
    case 'exchange fees':
      return const Color(0xFF1E88E5);
    case 'other':
      return const Color(0xFFB0BEC5);
    case 'salary':
      return const Color(0xFF00897B);
    case 'other income':
      return const Color(0xFFFFB300);
    default:
      return const Color(0xFFB0BEC5);
  }
}

IconData _currentIcon(String category) {
  switch (_norm(category)) {
    case 'food & drink':
      return Icons.restaurant;
    case 'groceries':
      return Icons.shopping_cart;
    case 'transport':
      return Icons.train;
    case 'shopping':
      return Icons.shopping_bag;
    case 'bills':
      return Icons.receipt_long;
    case 'subscriptions':
      return Icons.subscriptions;
    case 'entertainment':
      return Icons.movie;
    case 'health':
      return Icons.local_hospital;
    case 'gifts':
      return Icons.card_giftcard;
    case 'flights':
      return Icons.flight;
    case 'exchange fees':
      return Icons.currency_exchange;
    case 'other':
      return Icons.sell;
    case 'other income':
      return Icons.payments;
    case 'salary':
      return Icons.account_balance_wallet;
    default:
      return Icons.receipt_long;
  }
}

IconData _currentIconOutlined(String category) {
  switch (_norm(category)) {
    case 'food & drink':
      return Icons.restaurant_outlined;
    case 'groceries':
      return Icons.shopping_cart_outlined;
    case 'transport':
      return Icons.train_outlined;
    case 'shopping':
      return Icons.shopping_bag_outlined;
    case 'bills':
      return Icons.receipt_long_outlined;
    case 'subscriptions':
      return Icons.subscriptions_outlined;
    case 'entertainment':
      return Icons.movie_outlined;
    case 'health':
      return Icons.local_hospital_outlined;
    case 'gifts':
      return Icons.card_giftcard_outlined;
    case 'flights':
      return Icons.flight_outlined;
    case 'exchange fees':
      return Icons.currency_exchange;
    case 'other':
      return Icons.sell_outlined;
    case 'other income':
      return Icons.payments_outlined;
    case 'salary':
      return Icons.account_balance_wallet_outlined;
    default:
      return Icons.receipt_long_outlined;
  }
}

Color categoryIconBackground(String category) {
  final dynamicCategory = _findAny(category);
  if (dynamicCategory != null) {
    return Color(dynamicCategory.colorArgb);
  }
  return _currentBackground(category);
}

Color categoryIconForeground(String category) => Colors.white;

IconData iconForCategory(String category) {
  final dynamicCategory = _findAny(category);
  if (dynamicCategory != null) {
    return ledgerCategoryIconFromKey(dynamicCategory.iconKey);
  }
  return _currentIcon(category);
}

IconData expenseIconForCategory(String category) {
  final dynamicCategory =
      _findInBox(() => HiveService.expenseCategoriesBox, category);
  if (dynamicCategory != null) {
    return ledgerCategoryIconFromKey(dynamicCategory.iconKey);
  }
  return iconForCategory(category);
}

IconData incomeIconForCategory(String category) {
  final dynamicCategory =
      _findInBox(() => HiveService.incomeCategoriesBox, category);
  if (dynamicCategory != null) {
    return ledgerCategoryIconFromKey(dynamicCategory.iconKey);
  }
  return iconForCategory(category);
}

IconData iconForCategoryOutlined(String category) {
  final dynamicCategory = _findAny(category);
  if (dynamicCategory != null) {
    return ledgerCategoryOutlinedIconFromKey(dynamicCategory.iconKey);
  }
  return _currentIconOutlined(category);
}

Color expenseCategoryIconBackground(String category) {
  final dynamicCategory =
      _findInBox(() => HiveService.expenseCategoriesBox, category);
  if (dynamicCategory != null) {
    return Color(dynamicCategory.colorArgb);
  }
  return categoryIconBackground(category);
}

Color incomeCategoryIconBackground(String category) {
  final dynamicCategory = _findInBox(() => HiveService.incomeCategoriesBox, category);
  if (dynamicCategory != null) {
    return Color(dynamicCategory.colorArgb);
  }
  return categoryIconBackground(category);
}

IconData expenseIconForCategoryOutlined(String category) {
  final dynamicCategory =
      _findInBox(() => HiveService.expenseCategoriesBox, category);
  if (dynamicCategory != null) {
    return ledgerCategoryOutlinedIconFromKey(dynamicCategory.iconKey);
  }
  return iconForCategoryOutlined(category);
}

IconData incomeIconForCategoryOutlined(String category) {
  final dynamicCategory =
      _findInBox(() => HiveService.incomeCategoriesBox, category);
  if (dynamicCategory != null) {
    return ledgerCategoryOutlinedIconFromKey(dynamicCategory.iconKey);
  }
  return iconForCategoryOutlined(category);
}
