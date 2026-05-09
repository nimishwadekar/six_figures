import 'package:flutter/material.dart';

IconData ledgerCategoryIconFromKey(String key) {
  switch (key) {
    case 'restaurant':
      return Icons.restaurant;
    case 'icecream':
      return Icons.icecream;
    case 'local_bar':
      return Icons.local_bar;
    case 'coffee':
      return Icons.coffee;
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
    case 'kayaking':
      return Icons.kayaking;
    case 'museum':
      return Icons.museum;
    case 'hotel':
      return Icons.hotel;
    case 'sell':
      return Icons.sell;
    case 'paid':
      return Icons.paid;
    case 'currency_exchange':
      return Icons.currency_exchange;
    case 'local_laundry_service':
      return Icons.local_laundry_service;
    case 'medical_services':
      return Icons.medical_services;
    case 'bolt':
      return Icons.bolt;
    case 'home':
      return Icons.home;
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
    case 'icecream':
      return Icons.cake_outlined;
    case 'local_bar':
      return Icons.local_bar_outlined;
    case 'coffee':
      return Icons.coffee_outlined;
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
    case 'kayaking':
      return Icons.kayaking_outlined;
    case 'museum':
      return Icons.museum_outlined;
    case 'hotel':
      return Icons.hotel_outlined;
    case 'sell':
      return Icons.sell_outlined;
    case 'paid':
      return Icons.paid_outlined;
    case 'currency_exchange':
      return Icons.currency_exchange;
    case 'local_laundry_service':
      return Icons.local_laundry_service_outlined;
    case 'medical_services':
      return Icons.medical_services_outlined;
    case 'bolt':
      return Icons.bolt_outlined;
    case 'home':
      return Icons.home_outlined;
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
