// Home dashboard tab. Today's Total pinned beneath blurglass strip followed by expenses grouped per calendar day.

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/expense.dart';
import '../services/hive_service.dart';
import '../utils/date_format.dart';
import '../widgets/day_section.dart';
import '../widgets/glass_metric_header_delegate.dart';

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

        final now = DateTime.now();
        final todayKey = DateTime(now.year, now.month, now.day);
        final todayCents =
            grouped[todayKey]?.fold<int>(0, (s, e) => s + e.amountCents) ?? 0;

        return CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: GlassMetricHeaderDelegate(todayCents: todayCents),
            ),
            if (expenses.isEmpty)
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    'No expenses yet. Tap + to add your first entry.',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              )
              else ...[
                const SliverToBoxAdapter(child: SizedBox(height: 8)),
                SliverPadding(
                  padding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 100),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final day = dayKeys[index];
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
                      },
                      childCount: dayKeys.length,
                    ),
                  ),
                ),
              ],
          ],
        );
      },
    );
  }
}
