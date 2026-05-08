// Category-to-visual mapping. Resolves a category label (case- and
// whitespace-insensitive) to its avatar background colour, foreground
// glyph colour, and filled/outlined Material icon.

import 'package:flutter/material.dart';

import '../app_theme.dart';

Color categoryIconBackground(String category) {
  switch (category.trim().toLowerCase()) {
    case 'transport':
    case 'travel':
    case 'commute':
      return AppPalette.categoryTransport;
    case 'restaurants':
    case 'restaurant':
    case 'dining':
    case 'food':
    case 'dessert':
    case 'ice cream':
    case 'lunch':
      return AppPalette.categoryFood;
    case 'drinks':
    case 'drink':
    case 'coffee':
    case 'icetea':
      return AppPalette.categoryDrinks;
    case 'shopping':
    case 'groceries':
      return AppPalette.categoryShopping;
    case 'fun':
      return AppPalette.categoryFun;
    case 'health':
      return AppPalette.categoryHealth;
    case 'utilities':
      return AppPalette.categoryUtilities;
    case 'housing':
      return AppPalette.categoryHousing;
    default:
      return AppPalette.categoryUnknown;
  }
}

Color categoryIconForeground(String category) {
  // The screenshot uses white glyphs over colored circles.
  return Colors.white;
}

IconData iconForCategory(String category) {
  switch (category.toLowerCase()) {
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
    case 'fun':
      return Icons.movie;
    case 'travel':
      return Icons.flight;
    case 'transport':
      return Icons.directions_bus_filled;
    case 'shopping':
      return Icons.shopping_bag;
    case 'health':
      return Icons.medical_services;
    case 'utilities':
      return Icons.bolt;
    case 'housing':
      return Icons.home;
    default:
      return Icons.receipt_long;
  }
}

IconData iconForCategoryOutlined(String category) {
  switch (category.toLowerCase()) {
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
    case 'fun':
      return Icons.movie_outlined;
    case 'travel':
      return Icons.flight_outlined;
    case 'transport':
      return Icons.directions_bus_outlined;
    case 'shopping':
      return Icons.shopping_bag_outlined;
    case 'health':
      return Icons.medical_services_outlined;
    case 'utilities':
      return Icons.bolt_outlined;
    case 'housing':
      return Icons.home_outlined;
    default:
      return Icons.receipt_long_outlined;
  }
}
