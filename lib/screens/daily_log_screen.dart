// Daily Log tab. Provides a header with Local/Home toggle, summary
// filter chips (entry count, categories, currencies), and the same
// day-grouped expense list as the home dashboard.

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/expense.dart';
import '../services/hive_service.dart';
import '../utils/date_format.dart';
import '../widgets/app_filter_chip.dart';
import '../widgets/day_section.dart';
import '../widgets/tonal_card.dart';

class DailyLogScreen extends StatelessWidget {
  const DailyLogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return LayoutBuilder(
      builder: (context, constraints) {
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

            final dayKeys = grouped.keys.toList()
              ..sort((a, b) => b.compareTo(a));

            return ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Daily Log', style: theme.textTheme.headlineLarge),
                    SegmentedButton<int>(
                      segments: const [
                        ButtonSegment(value: 0, label: Text('Local')),
                        ButtonSegment(value: 1, label: Text('Home')),
                      ],
                      selected: const {0},
                      onSelectionChanged: (_) {},
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TonalCard(
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 8,
                    children: [
                      AppFilterChip(
                        label: '${expenses.length} entries',
                        icon: Icons.receipt_long_rounded,
                      ),
                      const AppFilterChip(
                        label: 'All Categories',
                        icon: Icons.sell_outlined,
                      ),
                      const AppFilterChip(
                        label: 'All Currencies',
                        icon: Icons.payments_outlined,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                if (expenses.isEmpty)
                  TonalCard(
                    child: Text(
                      'No expenses logged yet. Tap + to add one.',
                      style: theme.textTheme.bodyLarge,
                    ),
                  )
                else
                  ...dayKeys.map((day) {
                    final dayExpenses = grouped[day]!;
                    final totalCents = dayExpenses.fold<int>(
                      0,
                      (sum, item) => sum + item.amountCents,
                    );
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: DaySection(
                        headerLabel: dayHeaderLabel(day),
                        totalCents: totalCents,
                        expenses: dayExpenses,
                      ),
                    );
                  }),
              ],
            );
          },
        );
      },
    );
  }
}
