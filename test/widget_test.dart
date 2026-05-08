// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

import 'package:six_figures/models/expense.dart';
import 'package:six_figures/main.dart';
import 'package:six_figures/services/hive_service.dart';

void main() {
  setUpAll(() async {
    final tempDir = await Directory.systemTemp.createTemp('six_figures_test_');
    Hive.init(tempDir.path);
    Hive.registerAdapter(ExpenseAdapter());
    await Hive.openBox<Expense>(HiveService.expensesBoxName);
  });

  tearDownAll(() async {
    await Hive.close();
  });

  testWidgets('App renders with Hive-backed home', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.text('Daily Log'), findsOneWidget);
  });
}
