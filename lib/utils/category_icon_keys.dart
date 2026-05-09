import 'package:flutter/material.dart';

IconData ledgerCategoryIconFromKey(String key) {
  switch (key) {
    case 'restaurant':
      return Icons.restaurant;
    case 'movie':
      return Icons.movie;
    case 'flight':
      return Icons.flight;
    case 'train':
      return Icons.train;
    case 'shopping_bag':
      return Icons.shopping_bag;
    case 'shopping_cart':
      return Icons.shopping_cart;
    case 'sell':
      return Icons.sell;
    case 'receipt_long':
      return Icons.receipt_long;
    case 'subscriptions':
      return Icons.subscriptions;
    case 'currency_exchange':
      return Icons.currency_exchange;
    case 'local_hospital':
      return Icons.local_hospital;
    case 'payments':
      return Icons.payments;
    case 'account_balance_wallet':
      return Icons.account_balance_wallet;
    case 'card_giftcard':
      return Icons.card_giftcard;
    default:
      return Icons.receipt_long;
  }
}

IconData ledgerCategoryOutlinedIconFromKey(String key) {
  switch (key) {
    case 'restaurant':
      return Icons.restaurant_outlined;
    case 'movie':
      return Icons.movie_outlined;
    case 'flight':
      return Icons.flight_outlined;
    case 'train':
      return Icons.train_outlined;
    case 'shopping_bag':
      return Icons.shopping_bag_outlined;
    case 'shopping_cart':
      return Icons.shopping_cart_outlined;
    case 'sell':
      return Icons.sell_outlined;
    case 'receipt_long':
      return Icons.receipt_long_outlined;
    case 'subscriptions':
      return Icons.subscriptions_outlined;
    case 'currency_exchange':
      return Icons.currency_exchange;
    case 'local_hospital':
      return Icons.local_hospital_outlined;
    case 'payments':
      return Icons.payments_outlined;
    case 'account_balance_wallet':
      return Icons.account_balance_wallet_outlined;
    case 'card_giftcard':
      return Icons.card_giftcard_outlined;
    default:
      return Icons.receipt_long_outlined;
  }
}
