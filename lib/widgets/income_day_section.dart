// IncomeDaySection: same layout as DaySection for expenses, but binds to
// [Income] and [AddIncomeScreen].

import 'package:flutter/material.dart';

import '../app_theme.dart';
import '../constants.dart';
import '../models/income.dart';
import '../screens/add_income_screen.dart';
import '../utils/category_icons.dart';
import '../utils/income_helpers.dart';
import 'currency_amount_typographic.dart';

class IncomeDaySection extends StatelessWidget {
  const IncomeDaySection({
    super.key,
    required this.headerLabel,
    required this.totalCents,
    required this.incomes,
  });

  final String headerLabel;
  final int totalCents;
  final List<Income> incomes;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: AppPalette.midnightSurfaceBorder,
                width: 1,
              ),
            ),
          ),
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
                wholeFontSize: 15,
                fractionFontSize: 10,
                mainAxisAlignment: MainAxisAlignment.end,
                monospace: true,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppPalette.midnightSurfaceBorder),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: ColoredBox(
              color: AppPalette.bg1,
              child: Column(
                children: [
                  for (var i = 0; i < incomes.length; i++) ...[
                    Material(
                      key: ValueKey<Object?>(
                        incomes[i].key ??
                            '${incomes[i].date.millisecondsSinceEpoch}_'
                            '${incomes[i].amountCents}_'
                            '${incomes[i].category}_'
                            '${incomes[i].name}',
                      ),
                      color: Colors.transparent,
                      child: InkWell(
                        canRequestFocus: false,
                        overlayColor: WidgetStateProperty.resolveWith((states) {
                          if (states.contains(WidgetState.pressed)) {
                            return colors.primary.withValues(alpha: 0.12);
                          }
                          return null;
                        }),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (_) => AddIncomeScreen(
                                initialCategory: incomes[i].category,
                                initialIncome: incomes[i],
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          child: Row(
                            children: [
                              _IncomeCategorySquare(
                                  category: incomes[i].category),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      incomes[i].name.trim().isEmpty
                                          ? incomes[i].category
                                          : incomes[i].name,
                                      style: theme.textTheme.titleMedium
                                          ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: colors.onSurface,
                                      ),
                                    ),
                                    if (incomeEntrySubtitle(incomes[i]) !=
                                        null) ...[
                                      const SizedBox(height: 2),
                                      Text(
                                        incomeEntrySubtitle(incomes[i])!,
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(
                                          color: AppPalette.onSurfaceMuted,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                              CurrencyAmountTypographic(
                                cents: incomes[i].amountCents,
                                currencyCode: kHomeCurrencyCode,
                                wholeFontSize: 16,
                                fractionFontSize: 11,
                                mainAxisAlignment: MainAxisAlignment.end,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (i < incomes.length - 1)
                      Divider(
                        height: 1,
                        indent: 16,
                        endIndent: 16,
                        color: AppPalette.midnightSurfaceBorder
                            .withValues(alpha: 0.8),
                      ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _IncomeCategorySquare extends StatelessWidget {
  const _IncomeCategorySquare({required this.category});

  final String category;

  @override
  Widget build(BuildContext context) {
    final accent = incomeCategoryIconBackground(category);
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.22),
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.center,
      child: Icon(
        incomeIconForCategoryOutlined(category),
        color: accent,
        size: 20,
      ),
    );
  }
}
