// Top-level navigation shell. Hosts the app bar, the bottom navigation bar
// and the floating action button, switching between the four primary
// screens (Home, Daily Log, Wallets, Tags) via an IndexedStack.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'screens/add_expense_screen.dart';
import 'screens/daily_log_screen.dart';
import 'screens/home_dashboard_screen.dart';
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
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final isIOS = theme.platform == TargetPlatform.iOS;

    return Scaffold(
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
            DailyLogScreen(),
            WalletsRatesScreen(),
            TagsScreen(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final selectedCategory = await Navigator.of(context).push<String>(
            MaterialPageRoute<String>(
              builder: (_) => const SelectCategoryScreen(),
            ),
          );
          if (!context.mounted || selectedCategory == null) {
            return;
          }
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) =>
                  AddExpenseScreen(initialCategory: selectedCategory),
            ),
          );
        },
        child: Icon(isIOS ? CupertinoIcons.add : Icons.add),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (value) => setState(() => _currentIndex = value),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.receipt_long_outlined),
            selectedIcon: Icon(Icons.receipt_long),
            label: 'Entries',
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
