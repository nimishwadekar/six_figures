// DaySection: a sticky-style header showing a day label and its total,
// followed by a list of expense rows for that day. Tapping a row opens
// AddExpenseScreen pre-filled for editing.

import 'package:flutter/material.dart';

import '../app_theme.dart';
import '../constants.dart';
import '../models/expense.dart';
import '../screens/add_expense_screen.dart';
import '../utils/category_icons.dart';
import '../utils/expense_helpers.dart';
import 'currency_amount_typographic.dart';

class DaySection extends StatelessWidget {
  const DaySection({
    super.key,
    required this.headerLabel,
    required this.totalCents,
    required this.expenses,
  });

  final String headerLabel;
  final int totalCents;
  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          color: AppPalette.bg2,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  headerLabel,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colors.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              CurrencyAmountTypographic(
                cents: totalCents,
                currencyCode: kHomeCurrencyCode,
                wholeFontSize: 17,
                fractionFontSize: 12,
                mainAxisAlignment: MainAxisAlignment.end,
              ),
            ],
          ),
        ),
        ColoredBox(
          color: AppPalette.bg2,
          child: Column(
            children: [
              for (var i = 0; i < expenses.length; i++) ...[
                Material(
                  key: ValueKey<Object?>(
                    expenses[i].key ??
                        '${expenses[i].date.millisecondsSinceEpoch}_'
                        '${expenses[i].amountCents}_'
                        '${expenses[i].category}_'
                        '${expenses[i].name}',
                  ),
                  color: AppPalette.bg1,
                  surfaceTintColor: Colors.transparent,
                  child: InkWell(
                    // Avoid persistent M3 focus/hover overlay (looks "stuck" pressed).
                    canRequestFocus: false,
                    overlayColor: WidgetStateProperty.resolveWith((states) {
                      if (states.contains(WidgetState.pressed)) {
                        return colors.primary.withValues(alpha: 0.08);
                      }
                      return null;
                    }),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => AddExpenseScreen(
                            initialCategory: expenses[i].category,
                            initialExpense: expenses[i],
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: categoryIconBackground(
                              expenses[i].category,
                            ),
                            child: Icon(
                              iconForCategoryOutlined(expenses[i].category),
                              color: categoryIconForeground(
                                expenses[i].category,
                              ),
                              size: 22,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  expenses[i].name.trim().isEmpty
                                      ? expenses[i].category
                                      : expenses[i].name,
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                if (entrySubtitle(expenses[i]) != null) ...[
                                  const SizedBox(height: 2),
                                  Text(
                                    entrySubtitle(expenses[i])!,
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: colors.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                          CurrencyAmountTypographic(
                            cents: expenses[i].amountCents,
                            currencyCode: kHomeCurrencyCode,
                            wholeFontSize: 18,
                            fractionFontSize: 12,
                            mainAxisAlignment: MainAxisAlignment.end,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (i < expenses.length - 1)
                  Divider(
                    height: 1,
                    indent: 16,
                    endIndent: 16,
                    color: colors.outlineVariant.withValues(alpha: 0.6),
                  ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
