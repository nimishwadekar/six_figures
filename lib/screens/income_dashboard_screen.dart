// Income tab: Today's Income glass header plus day-grouped income list from incomebox.

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/income.dart';
import '../services/hive_service.dart';
import '../utils/date_format.dart';
import '../widgets/glass_metric_header_delegate.dart';
import '../widgets/income_day_section.dart';

class IncomeDashboardScreen extends StatelessWidget {
  const IncomeDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ValueListenableBuilder<Box<Income>>(
      valueListenable: HiveService.incomeBox.listenable(),
      builder: (context, box, _) {
        final incomes = box.values.toList()
          ..sort((a, b) => b.date.compareTo(a.date));
        final grouped = <DateTime, List<Income>>{};
        for (final income in incomes) {
          final key = DateTime(
            income.date.year,
            income.date.month,
            income.date.day,
          );
          grouped.putIfAbsent(key, () => <Income>[]).add(income);
        }
        final dayKeys = grouped.keys.toList()..sort((a, b) => b.compareTo(a));

        final now = DateTime.now();
        final monthCents = incomes
            .where(
              (income) =>
                  income.date.year == now.year && income.date.month == now.month,
            )
            .fold<int>(0, (sum, income) => sum + income.amountCents);

        return CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: GlassMetricHeaderDelegate(
                todayCents: monthCents,
                summaryTitle: "This Month's Income",
              ),
            ),
            if (incomes.isEmpty)
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    'No income logged yet. Tap + to add an entry.',
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
                      final dayItems = grouped[day]!;
                      final totalForDay = dayItems.fold<int>(
                        0,
                        (sum, item) => sum + item.amountCents,
                      );
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: IncomeDaySection(
                          headerLabel: dayHeaderLabel(day),
                          totalCents: totalForDay,
                          incomes: dayItems,
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
