// Singleton-style facade around Hive: handles one-time initialisation,
// adapter registration, and exposes the open Expense and Income boxes used
// throughout the app for persistence.

import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/foundation.dart';

import '../data/default_ledger_categories.dart';
import '../models/expense.dart';
import '../models/income.dart';
import '../models/ledger_category.dart';

class HiveService {
  HiveService._();

  static const String expensesBoxName = 'expensesBox';
  static const String incomeBoxName = 'incomebox';
  static const String expenseCategoriesBoxName = 'expenseCategoriesBox';
  static const String incomeCategoriesBoxName = 'incomeCategoriesBox';

  static bool _initialized = false;

  static Future<void> init() async {
    if (_initialized) {
      return;
    }

    await Hive.initFlutter();
    Hive.registerAdapter(ExpenseAdapter());
    Hive.registerAdapter(IncomeAdapter());
    Hive.registerAdapter(LedgerCategoryAdapter());
    await Hive.openBox<Expense>(expensesBoxName);
    await Hive.openBox<Income>(incomeBoxName);
    await Hive.openBox<LedgerCategory>(expenseCategoriesBoxName);
    await Hive.openBox<LedgerCategory>(incomeCategoriesBoxName);
    await _seedCategoriesIfNeeded();
    await debugSeed();
    _initialized = true;
  }

  static Box<Expense> get expensesBox => Hive.box<Expense>(expensesBoxName);

  static Box<Income> get incomeBox => Hive.box<Income>(incomeBoxName);

  static Box<LedgerCategory> get expenseCategoriesBox =>
      Hive.box<LedgerCategory>(expenseCategoriesBoxName);

  static Box<LedgerCategory> get incomeCategoriesBox =>
      Hive.box<LedgerCategory>(incomeCategoriesBoxName);

  static Future<void> _seedCategoriesIfNeeded() async {
    if (expenseCategoriesBox.isEmpty) {
      await expenseCategoriesBox.addAll(
        kDefaultExpenseCategories.map((seed) => seed.toLedgerCategory()),
      );
    }
    if (incomeCategoriesBox.isEmpty) {
      await incomeCategoriesBox.addAll(
        kDefaultIncomeCategories.map((seed) => seed.toLedgerCategory()),
      );
    }
  }

  static Future<void> debugSeed() async {
    if (!kDebugMode) {
      return;
    }
    if (expensesBox.isNotEmpty || incomeBox.isNotEmpty) {
      return;
    }

    final now = DateTime.now();
    await expensesBox.addAll([
      Expense(
        date: now.subtract(const Duration(days: 4)),
        category: 'Groceries',
        name: 'Weekly groceries',
        currency: 'CHF',
        amountCents: 8425,
        tag: 'Household',
      ),
      Expense(
        date: now.subtract(const Duration(days: 3)),
        category: 'Transport',
        name: 'Metro card top-up',
        currency: 'CHF',
        amountCents: 2500,
        tag: 'Commute',
      ),
      Expense(
        date: now.subtract(const Duration(days: 2)),
        category: 'Food & Drink',
        name: 'Lunch with team',
        currency: 'CHF',
        amountCents: 1890,
        tag: 'Food',
      ),
      Expense(
        date: now.subtract(const Duration(days: 1)),
        category: 'Food & Drink',
        name: 'Cafe latte',
        currency: 'CHF',
        amountCents: 620,
        tag: 'Cafe',
      ),
      Expense(
        date: now,
        category: 'Entertainment',
        name: 'Movie ticket',
        currency: 'CHF',
        amountCents: 1450,
        tag: 'Leisure',
      ),
    ]);

    await incomeBox.add(
      Income(
        date: now.subtract(const Duration(days: 2)),
        category: 'Salary',
        name: 'Monthly salary',
        currency: 'CHF',
        amountCents: 420000,
        tag: 'Paycheck',
      ),
    );
  }
}
