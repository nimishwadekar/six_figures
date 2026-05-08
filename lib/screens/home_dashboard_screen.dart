// Home dashboard tab. Shows summary metric cards (daily average, today's
// spend) and a reverse-chronological list of expenses grouped by day,
// reactively updated from the Hive box.

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/expense.dart';
import '../services/hive_service.dart';
import '../utils/date_format.dart';
import '../widgets/day_section.dart';
import '../widgets/metric_card.dart';

class HomeDashboardScreen extends StatelessWidget {
  const HomeDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ValueListenableBuilder<Box<Expense>>(
      valueListenable: HiveService.expensesBox.listenable(),
      builder: (context, box, _) {
        final expenses = box.values.toList()
          ..sort((a, b) => b.date.compareTo(a.date));
        final grouped = <DateTime, List<Expense>>{};
        for (final expense in expenses) {
          final key = DateTime(
            expense.date.year,
            expense.date.month,
            expense.date.day,
          );
          grouped.putIfAbsent(key, () => <Expense>[]).add(expense);
        }
        final dayKeys = grouped.keys.toList()..sort((a, b) => b.compareTo(a));

        final totalCents = expenses.fold<int>(
          0,
          (sum, expense) => sum + expense.amountCents,
        );
        final averageDailyCents = dayKeys.isEmpty
            ? 0
            : totalCents ~/ dayKeys.length;
        final now = DateTime.now();
        final todayKey = DateTime(now.year, now.month, now.day);
        final todayCents =
            grouped[todayKey]?.fold<int>(0, (s, e) => s + e.amountCents) ?? 0;

        return ListView(
          padding: const EdgeInsets.only(top: 12, bottom: 24),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: MetricCard(
                      label: 'Daily Average',
                      cents: averageDailyCents,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: MetricCard(label: 'Today', cents: todayCents),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            if (expenses.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'No expenses yet. Tap + to add your first entry.',
                  style: theme.textTheme.bodyLarge,
                ),
              )
            else
              ...dayKeys.map((day) {
                final dayExpenses = grouped[day]!;
                final totalForDay = dayExpenses.fold<int>(
                  0,
                  (sum, item) => sum + item.amountCents,
                );
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: DaySection(
                    headerLabel: dayHeaderLabel(day),
                    totalCents: totalForDay,
                    expenses: dayExpenses,
                  ),
                );
              }),
          ],
        );
      },
    );
  }
}
