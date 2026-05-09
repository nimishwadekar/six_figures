// Category-to-visual mapping. Uses Hive-backed category metadata first,
// then falls back to legacy name-based mappings.

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../app_theme.dart';
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

Color _legacyBackground(String category) {
  switch (_norm(category)) {
    case 'transportation':
    case 'transport':
    case 'travel':
    case 'commute':
    case 'flights':
    case 'flight':
      return AppPalette.categoryTransport;
    case 'restaurants':
    case 'restaurant':
    case 'dining':
    case 'food':
    case 'dessert':
    case 'ice cream':
    case 'lunch':
    case 'laundry':
      return AppPalette.categoryFood;
    case 'drinks':
    case 'drink':
    case 'coffee':
    case 'icetea':
    case 'groceries':
    case 'grocery':
    case 'exchange fees':
      return AppPalette.categoryDrinks;
    case 'shopping':
      return AppPalette.categoryShopping;
    case 'activities':
    case 'sightseeing':
    case 'entertainment':
    case 'fun':
    case 'fees & charges':
    case 'fees and charges':
    case 'gifts':
      return AppPalette.categoryFun;
    case 'health':
      return AppPalette.categoryHealth;
    case 'utilities':
      return AppPalette.categoryUtilities;
    case 'housing':
    case 'accommodation':
      return AppPalette.categoryHousing;
    case 'salary':
      return AppPalette.categoryFood;
    case 'other income':
      return AppPalette.categoryUtilities;
    case 'general':
      return AppPalette.categoryUnknown;
    default:
      return AppPalette.categoryUnknown;
  }
}

IconData _legacyIcon(String category) {
  switch (_norm(category)) {
    case 'restaurants':
    case 'restaurant':
    case 'dining':
    case 'food':
      return Icons.restaurant;
    case 'dessert':
      return Icons.icecream;
    case 'drinks':
    case 'drink':
      return Icons.local_bar;
    case 'coffee':
      return Icons.coffee;
    case 'entertainment':
    case 'fun':
      return Icons.movie;
    case 'travel':
    case 'flights':
    case 'flight':
      return Icons.flight;
    case 'transportation':
    case 'transport':
    case 'commute':
      return Icons.train;
    case 'shopping':
      return Icons.shopping_bag;
    case 'groceries':
    case 'grocery':
      return Icons.shopping_cart;
    case 'activities':
      return Icons.kayaking;
    case 'sightseeing':
      return Icons.museum;
    case 'accommodation':
      return Icons.hotel;
    case 'general':
      return Icons.sell;
    case 'fees & charges':
    case 'fees and charges':
      return Icons.paid;
    case 'exchange fees':
      return Icons.currency_exchange;
    case 'laundry':
      return Icons.local_laundry_service;
    case 'health':
      return Icons.medical_services;
    case 'utilities':
      return Icons.bolt;
    case 'housing':
      return Icons.home;
    case 'other income':
      return Icons.payments;
    case 'salary':
      return Icons.account_balance_wallet;
    case 'gifts':
      return Icons.card_giftcard;
    default:
      return Icons.receipt_long;
  }
}

IconData _legacyIconOutlined(String category) {
  switch (_norm(category)) {
    case 'restaurants':
    case 'restaurant':
    case 'dining':
    case 'food':
      return Icons.restaurant_outlined;
    case 'dessert':
      return Icons.cake_outlined;
    case 'drinks':
    case 'drink':
      return Icons.local_bar_outlined;
    case 'coffee':
      return Icons.coffee_outlined;
    case 'entertainment':
    case 'fun':
      return Icons.movie_outlined;
    case 'travel':
    case 'flights':
    case 'flight':
      return Icons.flight_outlined;
    case 'transportation':
    case 'transport':
    case 'commute':
      return Icons.train_outlined;
    case 'shopping':
      return Icons.shopping_bag_outlined;
    case 'groceries':
    case 'grocery':
      return Icons.shopping_cart_outlined;
    case 'activities':
      return Icons.kayaking_outlined;
    case 'sightseeing':
      return Icons.museum_outlined;
    case 'accommodation':
      return Icons.hotel_outlined;
    case 'general':
      return Icons.sell_outlined;
    case 'fees & charges':
    case 'fees and charges':
      return Icons.paid_outlined;
    case 'exchange fees':
      return Icons.currency_exchange;
    case 'laundry':
      return Icons.local_laundry_service_outlined;
    case 'health':
      return Icons.medical_services_outlined;
    case 'utilities':
      return Icons.bolt_outlined;
    case 'housing':
      return Icons.home_outlined;
    case 'other income':
      return Icons.payments_outlined;
    case 'salary':
      return Icons.account_balance_wallet_outlined;
    case 'gifts':
      return Icons.card_giftcard_outlined;
    default:
      return Icons.receipt_long_outlined;
  }
}

Color categoryIconBackground(String category) {
  final dynamicCategory = _findAny(category);
  if (dynamicCategory != null) {
    return Color(dynamicCategory.colorArgb);
  }
  return _legacyBackground(category);
}

Color categoryIconForeground(String category) => Colors.white;

IconData iconForCategory(String category) {
  final dynamicCategory = _findAny(category);
  if (dynamicCategory != null) {
    return ledgerCategoryIconFromKey(dynamicCategory.iconKey);
  }
  return _legacyIcon(category);
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
  return _legacyIconOutlined(category);
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
