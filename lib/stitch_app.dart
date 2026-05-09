// Top-level navigation shell. Hosts the app bar, the bottom navigation bar
// and the floating action button, switching primary screens via IndexedStack.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_theme.dart';
import 'screens/add_expense_screen.dart';
import 'screens/add_income_screen.dart';
import 'screens/daily_log_screen.dart';
import 'screens/home_dashboard_screen.dart';
import 'screens/income_dashboard_screen.dart';
import 'screens/select_category_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/tags_screen.dart';
import 'screens/wallets_rates_screen.dart';

class SereneLedgerShell extends StatefulWidget {
  const SereneLedgerShell({super.key});

  @override
  State<SereneLedgerShell> createState() => _SereneLedgerShellState();
}

class _SereneLedgerShellState extends State<SereneLedgerShell> {
  static const int _expenseTab = 0;
  static const int _incomeTab = 1;

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final isIOS = theme.platform == TargetPlatform.iOS;

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Zurich 2025',
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: colors.onSurface,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Icon(Icons.expand_more, color: colors.onSurface, size: 22),
              ],
            ),
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(
              isIOS ? CupertinoIcons.ellipsis_vertical : Icons.more_vert,
              color: colors.onSurface,
            ),
            onSelected: (value) {
              if (value == 'settings') {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => const SettingsScreen(),
                  ),
                );
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem<String>(value: 'settings', child: Text('Settings')),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: IndexedStack(
          index: _currentIndex,
          children: const [
            HomeDashboardScreen(),
            IncomeDashboardScreen(),
            DailyLogScreen(),
            WalletsRatesScreen(),
            TagsScreen(),
          ],
        ),
      ),
      floatingActionButton:
          (_currentIndex == _expenseTab || _currentIndex == _incomeTab)
              ? _LedgerFab(
                  label: _currentIndex == _expenseTab
                      ? '+ Add Expense'
                      : '+ Add Income',
                  onTap: () async {
                    final selectedCategory =
                        await Navigator.of(context).push<String>(
                      MaterialPageRoute<String>(
                        builder: (_) => SelectCategoryScreen(
                          mode: _currentIndex == _expenseTab
                              ? CategoryPickerMode.expense
                              : CategoryPickerMode.income,
                        ),
                      ),
                    );
                    if (!context.mounted || selectedCategory == null) {
                      return;
                    }
                    if (_currentIndex == _expenseTab) {
                      await Navigator.of(context).push<void>(
                        MaterialPageRoute<void>(
                          builder: (_) => AddExpenseScreen(
                            initialCategory: selectedCategory,
                          ),
                        ),
                      );
                    } else {
                      await Navigator.of(context).push<void>(
                        MaterialPageRoute<void>(
                          builder: (_) => AddIncomeScreen(
                            initialCategory: selectedCategory,
                          ),
                        ),
                      );
                    }
                  },
                  theme: theme,
                  colors: colors,
                )
              : null,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (value) => setState(() => _currentIndex = value),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.receipt_long_outlined),
            selectedIcon: Icon(Icons.receipt_long),
            label: 'Expense',
          ),
          NavigationDestination(
            icon: Icon(Icons.trending_up_outlined),
            selectedIcon: Icon(Icons.trending_up),
            label: 'Income',
          ),
          NavigationDestination(
            icon: Icon(Icons.bar_chart_outlined),
            selectedIcon: Icon(Icons.bar_chart),
            label: 'Stats',
          ),
          NavigationDestination(
            icon: Icon(Icons.map_outlined),
            selectedIcon: Icon(Icons.map),
            label: 'Map',
          ),
          NavigationDestination(
            icon: Icon(Icons.search_outlined),
            selectedIcon: Icon(Icons.search),
            label: 'Search',
          ),
        ],
      ),
    );
  }
}

class _LedgerFab extends StatelessWidget {
  const _LedgerFab({
    required this.label,
    required this.onTap,
    required this.theme,
    required this.colors,
  });

  final String label;
  final VoidCallback onTap;
  final ThemeData theme;
  final ColorScheme colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: AppPalette.sapphireAccent.withValues(alpha: 0.42),
            blurRadius: 20,
            spreadRadius: 1,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: colors.primary,
        borderRadius: BorderRadius.circular(28),
        elevation: 0,
        child: InkWell(
          borderRadius: BorderRadius.circular(28),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
            child: Text(
              label,
              style: theme.textTheme.titleSmall?.copyWith(
                color: colors.onPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
