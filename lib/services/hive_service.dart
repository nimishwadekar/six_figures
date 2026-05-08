// Singleton-style facade around Hive: handles one-time initialisation,
// adapter registration, and exposes the open Expense box used throughout
// the app for persistence.

import 'package:hive_flutter/hive_flutter.dart';

import '../models/expense.dart';

class HiveService {
  HiveService._();

  static const String expensesBoxName = 'expensesBox';
  static bool _initialized = false;

  static Future<void> init() async {
    if (_initialized) {
      return;
    }

    await Hive.initFlutter();
    Hive.registerAdapter(ExpenseAdapter());
    await Hive.openBox<Expense>(expensesBoxName);
    _initialized = true;
  }

  static Box<Expense> get expensesBox => Hive.box<Expense>(expensesBoxName);
}
