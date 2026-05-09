// Category picker styled like the design reference with categories loaded
// from Hive-backed expense/income category stores.

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../app_theme.dart';
import '../models/ledger_category.dart';
import '../services/hive_service.dart';
import '../utils/category_icon_keys.dart';

enum CategoryPickerMode { expense, income, both }

class SelectCategoryScreen extends StatelessWidget {
  const SelectCategoryScreen({
    super.key,
    this.mode = CategoryPickerMode.both,
  });

  final CategoryPickerMode mode;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    return ValueListenableBuilder<Box<LedgerCategory>>(
      valueListenable: HiveService.expenseCategoriesBox.listenable(),
      builder: (context, expenseBox, _) {
        final expenseItems = expenseBox.values.toList()
          ..sort((a, b) => a.position.compareTo(b.position));
        return ValueListenableBuilder<Box<LedgerCategory>>(
          valueListenable: HiveService.incomeCategoriesBox.listenable(),
          builder: (context, incomeBox, _) {
            final incomeItems = incomeBox.values.toList()
              ..sort((a, b) => a.position.compareTo(b.position));
            final showExpense =
                mode == CategoryPickerMode.expense || mode == CategoryPickerMode.both;
            final showIncome =
                mode == CategoryPickerMode.income || mode == CategoryPickerMode.both;
            final visibleExpenseItems = showExpense ? expenseItems : const <LedgerCategory>[];
            final visibleIncomeItems = showIncome ? incomeItems : const <LedgerCategory>[];
            return Scaffold(
              backgroundColor: colors.surface,
              body: SafeArea(
                child: CustomScrollView(
                  slivers: [
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 16, 0),
                      sliver: SliverToBoxAdapter(
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () => Navigator.of(context).maybePop(),
                              tooltip:
                                  MaterialLocalizations.of(context).closeButtonTooltip,
                            ),
                            Expanded(
                              child: Text(
                                'Pick a Category',
                                textAlign: TextAlign.center,
                                style: theme.textTheme.headlineMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            const SizedBox(width: 48),
                          ],
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      sliver: SliverToBoxAdapter(
                        child: Row(
                          children: [
                            Expanded(
                              child: FilledButton.tonal(
                                onPressed: () {},
                                style: FilledButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 12,
                                  ),
                                  shape: const StadiumBorder(),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.sort,
                                      size: 20,
                                      color: colors.onSecondaryContainer,
                                    ),
                                    const SizedBox(width: 8),
                                    Flexible(
                                      child: Text(
                                        'Change Order',
                                        style: theme.textTheme.labelLarge?.copyWith(
                                          color: colors.onSecondaryContainer,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: FilledButton.tonal(
                                onPressed: () {},
                                style: FilledButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 12,
                                  ),
                                  shape: const StadiumBorder(),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.edit_outlined,
                                      size: 20,
                                      color: colors.onSecondaryContainer,
                                    ),
                                    const SizedBox(width: 8),
                                    Flexible(
                                      child: Text(
                                        'Edit Categories',
                                        style: theme.textTheme.labelLarge?.copyWith(
                                          color: colors.onSecondaryContainer,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (visibleExpenseItems.isNotEmpty) ...[
                      SliverPadding(
                        padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
                        sliver: SliverToBoxAdapter(
                          child: Text(
                            'Expenses',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        sliver: SliverGrid(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 12 * AppUiScale.element,
                            crossAxisSpacing: 12 * AppUiScale.element,
                            childAspectRatio: 0.9,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (context, index) =>
                                _CategoryTile(category: visibleExpenseItems[index]),
                            childCount: visibleExpenseItems.length,
                          ),
                        ),
                      ),
                    ],
                    if (visibleIncomeItems.isNotEmpty) ...[
                      SliverPadding(
                        padding: const EdgeInsets.fromLTRB(20, 28, 20, 12),
                        sliver: SliverToBoxAdapter(
                          child: Text(
                            'Income',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
                        sliver: SliverGrid(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 12 * AppUiScale.element,
                            crossAxisSpacing: 12 * AppUiScale.element,
                            childAspectRatio: 0.9,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (context, index) =>
                                _CategoryTile(category: visibleIncomeItems[index]),
                            childCount: visibleIncomeItems.length,
                          ),
                        ),
                      ),
                    ],
                    if (visibleExpenseItems.isEmpty && visibleIncomeItems.isEmpty)
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(32),
                            child: Text(
                              'No categories configured yet',
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: colors.onSurfaceVariant,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _CategoryTile extends StatelessWidget {
  const _CategoryTile({required this.category});

  final LedgerCategory category;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final radius = BorderRadius.circular(18 * AppUiScale.element);

    return Material(
      color: colors.surfaceContainerLowest,
      shape: RoundedRectangleBorder(
        borderRadius: radius,
        side: BorderSide(
          color: colors.outlineVariant.withValues(alpha: 0.18),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => Navigator.of(context).pop(category.name),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 8 * AppUiScale.element,
            vertical: 8 * AppUiScale.element,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 22 * AppUiScale.element,
                backgroundColor: Color(category.colorArgb),
                child: Icon(
                  ledgerCategoryIconFromKey(category.iconKey),
                  color: Colors.white,
                  size: 24 * AppUiScale.element,
                ),
              ),
              SizedBox(height: 6 * AppUiScale.element),
              Text(
                category.name,
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppPalette.onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
