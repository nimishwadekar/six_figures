import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app_theme.dart';
import 'models/expense.dart';
import 'services/hive_service.dart';

/// Display currency for metrics and entry amounts (reference: CHF).
const String _kHomeCurrencyCode = 'CHF';

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
                    builder: (_) => const _SettingsScreen(),
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
            _HomeDashboardScreen(),
            _DailyLogScreen(),
            _WalletsRatesScreen(),
            _TagsScreen(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final selectedCategory = await Navigator.of(context).push<String>(
            MaterialPageRoute<String>(
              builder: (_) => const _SelectCategoryScreen(),
            ),
          );
          if (!context.mounted || selectedCategory == null) {
            return;
          }
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) =>
                  _AddExpenseScreen(initialCategory: selectedCategory),
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

class _HomeDashboardScreen extends StatelessWidget {
  const _HomeDashboardScreen();

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
                    child: _MetricCard(
                      label: 'Daily Average',
                      cents: averageDailyCents,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _MetricCard(label: 'Today', cents: todayCents),
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
                  child: _DaySection(
                    headerLabel: _dayHeaderLabel(day),
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

class _DailyLogScreen extends StatelessWidget {
  const _DailyLogScreen();

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
                _TonalCard(
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 8,
                    children: [
                      _FilterChip(
                        label: '${expenses.length} entries',
                        icon: Icons.receipt_long_rounded,
                      ),
                      const _FilterChip(
                        label: 'All Categories',
                        icon: Icons.sell_outlined,
                      ),
                      const _FilterChip(
                        label: 'All Currencies',
                        icon: Icons.payments_outlined,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                if (expenses.isEmpty)
                  _TonalCard(
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
                      child: _DaySection(
                        headerLabel: _dayHeaderLabel(day),
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

class _WalletsRatesScreen extends StatelessWidget {
  const _WalletsRatesScreen();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text('Wallets & Rates', style: theme.textTheme.headlineLarge),
        Text(
          'Manage your travel funds and live conversion rates.',
          style: theme.textTheme.bodyMedium,
        ),
        const SizedBox(height: 16),
        _TonalCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Estimated Total Balance',
                style: theme.textTheme.labelSmall,
              ),
              const SizedBox(height: 8),
              Text(
                '\$12,450.00',
                style: theme.textTheme.displayLarge?.copyWith(fontSize: 32),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.add_circle_outline),
                      label: const Text('NEW WALLET'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.sync),
                      label: const Text('REFRESH'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const _WalletTile(
          symbol: '€',
          name: 'Euro Wallet',
          rate: '1 EUR = 1.08 USD',
          amount: '€2,400.00',
          progress: 0.75,
        ),
        const SizedBox(height: 12),
        const _WalletTile(
          symbol: '¥',
          name: 'Yen Travel Fund',
          rate: '1 JPY = 0.0067 USD',
          amount: '¥150,000',
          progress: 0.40,
        ),
      ],
    );
  }
}

class _TagsScreen extends StatelessWidget {
  const _TagsScreen();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text('Manage Tags', style: theme.textTheme.headlineLarge),
        Text(
          'Organize your spending with custom labels',
          style: theme.textTheme.bodyMedium,
        ),
        const SizedBox(height: 16),
        Row(
          children: const [
            Expanded(
              child: _StatCard(label: 'MOST USED', value: 'Dining'),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _StatCard(label: 'TOTAL', value: '12 Tags'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _TonalCard(
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.palette_outlined),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'New tag name...',
                    border: InputBorder.none,
                  ),
                ),
              ),
              FilledButton(onPressed: () {}, child: const Text('ADD')),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const _TagTile(
          icon: Icons.restaurant,
          name: 'Dining Out',
          usage: 'Used 24 times',
        ),
        const SizedBox(height: 12),
        const _TagTile(
          icon: Icons.commute,
          name: 'Transport',
          usage: 'Used 18 times',
        ),
      ],
    );
  }
}

class _AddExpenseScreen extends StatefulWidget {
  const _AddExpenseScreen({required this.initialCategory, this.initialExpense});

  final String initialCategory;
  final Expense? initialExpense;

  @override
  State<_AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<_AddExpenseScreen> {
  final TextEditingController _amountController = TextEditingController(
    text: '',
  );
  final TextEditingController _nameController = TextEditingController(text: '');
  final TextEditingController _tagController = TextEditingController(text: '');

  late String _selectedCategory;
  late String _selectedCurrency;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    final initialExpense = widget.initialExpense;
    _selectedCategory = initialExpense?.category ?? widget.initialCategory;
    _selectedCurrency = initialExpense?.currency ?? 'CHF';
    final now = DateTime.now();
    final baseDate = initialExpense?.date ?? now;
    _selectedDate = DateTime(baseDate.year, baseDate.month, baseDate.day);
    _amountController.text = initialExpense == null
        ? ''
        : _formatRawAmount(initialExpense.amountCents);
    _nameController.text = initialExpense?.name ?? '';
    _tagController.text = initialExpense?.tag == 'General'
        ? ''
        : (initialExpense?.tag ?? '');
  }

  @override
  void dispose() {
    _amountController.dispose();
    _nameController.dispose();
    _tagController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Theme(
      data: theme.copyWith(
        colorScheme: colors.copyWith(surfaceTint: Colors.transparent),
      ),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(isIOS ? CupertinoIcons.xmark : Icons.close),
          ),
        ),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Center(
                child: Column(
                  children: [
                    SizedBox(
                      width: 220,
                      child: TextField(
                        controller: _amountController,
                        textAlign: TextAlign.center,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                          signed: false,
                        ),
                        style: theme.textTheme.displayLarge?.copyWith(
                          color: colors.primary,
                          fontSize: 44,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixText: 'CHF ',
                          hintText: '0.00',
                          hintStyle: theme.textTheme.displayLarge?.copyWith(
                            color: colors.onSurfaceVariant.withValues(
                              alpha: 0.45,
                            ),
                            fontSize: 44,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    FilledButton.tonal(
                      onPressed: () {},
                      child: Text(_selectedCurrency),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const _TonalCard(
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(Icons.account_balance_wallet),
                  title: Text('Euro Wallet'),
                  subtitle: Text('≈ \$158.24 USD'),
                  trailing: Icon(Icons.chevron_right),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _ActionCard(
                      icon: _iconForCategory(_selectedCategory),
                      label: 'CATEGORY',
                      value: _selectedCategory,
                      onTap: () {
                        Navigator.of(context)
                            .push<String>(
                              MaterialPageRoute<String>(
                                builder: (_) => const _SelectCategoryScreen(),
                              ),
                            )
                            .then((selectedCategory) {
                              if (!mounted || selectedCategory == null) {
                                return;
                              }
                              setState(
                                () => _selectedCategory = selectedCategory,
                              );
                            });
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _ActionCard(
                      icon: Icons.calendar_today,
                      label: 'DATE',
                      value: _selectedDateLabel(),
                      onTap: _pickDate,
                      useCategoryPalette: false,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _TonalCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('NAME', style: theme.textTheme.labelSmall),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _nameController,
                      minLines: 1,
                      maxLines: 2,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Name',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _TonalCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('PAYMENT METHOD', style: theme.textTheme.labelSmall),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _tagController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'e.g. Credit card',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: SafeArea(
          minimum: const EdgeInsets.all(20),
          child: FilledButton.icon(
            onPressed: _saveExpense,
            icon: const Icon(Icons.check_circle),
            label: const Text('Save Expense'),
          ),
        ),
      ),
    );
  }

  Future<void> _saveExpense() async {
    final amountInput = _amountController.text.trim();
    int amountCents;
    try {
      amountCents = Expense.parseAmountToCents(amountInput);
    } on FormatException {
      await _showAmountError();
      return;
    }
    if (amountCents == 0) {
      await _showAmountError();
      return;
    }

    final expense = Expense(
      date: _selectedDate,
      category: _selectedCategory,
      name: _nameController.text.trim(),
      currency: _selectedCurrency,
      amountCents: amountCents,
      tag: _tagController.text.trim().isEmpty
          ? 'General'
          : _tagController.text.trim(),
    );

    final existingKey = widget.initialExpense?.key;
    if (existingKey != null) {
      await HiveService.expensesBox.put(existingKey, expense);
    } else {
      await HiveService.expensesBox.add(expense);
    }

    if (!mounted) {
      return;
    }
    Navigator.of(context).pop();
  }

  Future<void> _showAmountError() async {
    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        content: const Text('Please enter an amount'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Ok'),
          ),
        ],
      ),
    );
  }

  String _selectedDateLabel() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    if (_selectedDate == today) {
      return 'Today';
    }
    return _formatDate(_selectedDate);
  }

  Future<void> _pickDate() async {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      barrierColor: Colors.black.withValues(alpha: 0.28),
      builder: (context, child) {
        final dpt = theme.datePickerTheme;
        return Theme(
          data: theme.copyWith(
            colorScheme: colors.copyWith(surfaceTint: Colors.transparent),
            dialogTheme: theme.dialogTheme.copyWith(
              backgroundColor: colors.surfaceContainerLowest,
              surfaceTintColor: Colors.transparent,
              elevation: 2,
            ),
            datePickerTheme: dpt.copyWith(
              backgroundColor: colors.surfaceContainerLowest,
              surfaceTintColor: Colors.transparent,
              elevation: 2,
              shadowColor: Colors.black.withValues(alpha: 0.06),
              headerBackgroundColor: colors.surfaceContainerLow,
              headerForegroundColor: colors.onSurface,
              weekdayStyle: theme.textTheme.labelMedium?.copyWith(
                color: colors.onSurfaceVariant,
              ),
              dayStyle: theme.textTheme.bodyLarge,
              dividerColor: colors.outlineVariant.withValues(alpha: 0.45),
              dayForegroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return colors.onPrimary;
                }
                if (states.contains(WidgetState.disabled)) {
                  return colors.onSurface.withValues(alpha: 0.38);
                }
                return colors.onSurface;
              }),
              dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return colors.primary;
                }
                return null;
              }),
              dayOverlayColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.pressed)) {
                  return colors.primary.withValues(alpha: 0.12);
                }
                if (states.contains(WidgetState.hovered)) {
                  return colors.primary.withValues(alpha: 0.08);
                }
                return null;
              }),
              todayForegroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return colors.onPrimary;
                }
                return colors.primary;
              }),
              todayBorder: BorderSide(
                color: colors.primary.withValues(alpha: 0.45),
              ),
              cancelButtonStyle: TextButton.styleFrom(
                foregroundColor: colors.onSurfaceVariant,
              ),
              confirmButtonStyle: TextButton.styleFrom(
                foregroundColor: colors.primary,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (!mounted || picked == null) {
      return;
    }
    setState(() {
      _selectedDate = DateTime(picked.year, picked.month, picked.day);
    });
  }
}

class _SelectCategoryScreen extends StatelessWidget {
  const _SelectCategoryScreen();

  @override
  Widget build(BuildContext context) {
    final categories = const [
      (Icons.restaurant, 'Restaurants'),
      (Icons.flight, 'Travel'),
      (Icons.shopping_bag, 'Shopping'),
      (Icons.commute, 'Transport'),
      (Icons.local_bar, 'Drinks'),
      (Icons.icecream, 'Dessert'),
      (Icons.coffee, 'Coffee'),
      (Icons.movie, 'Fun'),
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Select Category')),
      body: SafeArea(
        child: GridView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.2,
          ),
          itemBuilder: (context, index) {
            final (icon, label) = categories[index];
            return _TonalCard(
              child: InkWell(
                onTap: () => Navigator.of(context).pop(label),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 22,
                      backgroundColor: _categoryIconBackground(label),
                      child: Icon(icon, color: _categoryIconForeground(label)),
                    ),
                    const SizedBox(height: 8),
                    Text(label),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _SettingsScreen extends StatelessWidget {
  const _SettingsScreen();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text('Account', style: theme.textTheme.headlineMedium),
            const SizedBox(height: 8),
            const _TonalCard(
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(child: Icon(Icons.person)),
                title: Text('Julian Thorne'),
                subtitle: Text('julian.thorne@serene.io'),
                trailing: Icon(Icons.chevron_right),
              ),
            ),
            const SizedBox(height: 16),
            Text('Preferences', style: theme.textTheme.headlineMedium),
            const SizedBox(height: 8),
            const _TonalCard(
              child: _SettingsRow(
                icon: Icons.payments,
                title: 'Default Currency',
                subtitle: 'USD - US Dollar',
              ),
            ),
            const SizedBox(height: 8),
            _TonalCard(
              child: _SettingsRow(
                icon: Icons.dark_mode,
                title: 'Dark Mode',
                subtitle: 'Current: Light Mode',
                trailing: Switch(value: false, onChanged: (_) {}),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsRow extends StatelessWidget {
  const _SettingsRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.trailing,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: trailing ?? const Icon(Icons.chevron_right),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({required this.label, required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Chip(avatar: Icon(icon, size: 16), label: Text(label));
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({required this.label, required this.cents});

  final String label;
  final int cents;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: AppPalette.bg1,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 12,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(
                  label,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Icon(Icons.expand_more, size: 18, color: colors.onSurfaceVariant),
            ],
          ),
          const SizedBox(height: 8),
          _CurrencyAmountTypographic(
            cents: cents,
            currencyCode: _kHomeCurrencyCode,
            wholeFontSize: 26,
            fractionFontSize: 15,
          ),
        ],
      ),
    );
  }
}

/// Reference-style amount: grey code + bold whole + smaller fraction.
class _CurrencyAmountTypographic extends StatelessWidget {
  const _CurrencyAmountTypographic({
    required this.cents,
    required this.currencyCode,
    this.wholeFontSize = 22,
    this.fractionFontSize = 14,
    this.mainAxisAlignment = MainAxisAlignment.center,
  });

  final int cents;
  final String currencyCode;
  final double wholeFontSize;
  final double fractionFontSize;
  final MainAxisAlignment mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final isNegative = cents < 0;
    final absolute = cents.abs();
    final whole = absolute ~/ 100;
    final frac = (absolute % 100).toString().padLeft(2, '0');
    final prefix = isNegative ? '-' : '';

    return Row(
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          '$currencyCode ',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colors.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          '$prefix$whole',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: wholeFontSize,
            color: colors.onSurface,
            height: 1,
          ),
        ),
        Text(
          '.$frac',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: fractionFontSize,
            color: colors.onSurface,
            height: 1,
          ),
        ),
      ],
    );
  }
}

class _TonalCard extends StatelessWidget {
  const _TonalCard({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Card(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: colors.outlineVariant.withValues(alpha: 0.18),
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0A000000),
              blurRadius: 14,
              offset: Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.all(20),
        child: child,
      ),
    );
  }
}

String? _effectivePaymentTag(Expense expense) {
  final t = expense.tag.trim();
  if (t.isEmpty || t.toLowerCase() == 'general') {
    return null;
  }
  return t;
}

String? _entrySubtitle(Expense expense) {
  final pay = _effectivePaymentTag(expense);
  if (expense.name.trim().isEmpty) {
    return pay;
  }
  if (pay != null) {
    return '${expense.category} • $pay';
  }
  return expense.category;
}

class _DaySection extends StatelessWidget {
  const _DaySection({
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
              _CurrencyAmountTypographic(
                cents: totalCents,
                currencyCode: _kHomeCurrencyCode,
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
                          builder: (_) => _AddExpenseScreen(
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
                            backgroundColor: _categoryIconBackground(
                              expenses[i].category,
                            ),
                            child: Icon(
                              _iconForCategoryOutlined(expenses[i].category),
                              color: _categoryIconForeground(
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
                                if (_entrySubtitle(expenses[i]) != null) ...[
                                  const SizedBox(height: 2),
                                  Text(
                                    _entrySubtitle(expenses[i])!,
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: colors.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                          _CurrencyAmountTypographic(
                            cents: expenses[i].amountCents,
                            currencyCode: _kHomeCurrencyCode,
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

class _WalletTile extends StatelessWidget {
  const _WalletTile({
    required this.symbol,
    required this.name,
    required this.rate,
    required this.amount,
    required this.progress,
  });

  final String symbol;
  final String name;
  final String rate;
  final String amount;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return _TonalCard(
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              symbol,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: Theme.of(context).textTheme.bodyLarge),
                Text(rate, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(amount, style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(height: 6),
              SizedBox(
                width: 80,
                child: LinearProgressIndicator(value: progress),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return _TonalCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.labelSmall),
          const SizedBox(height: 4),
          Text(value, style: Theme.of(context).textTheme.headlineMedium),
        ],
      ),
    );
  }
}

class _TagTile extends StatelessWidget {
  const _TagTile({required this.icon, required this.name, required this.usage});

  final IconData icon;
  final String name;
  final String usage;

  @override
  Widget build(BuildContext context) {
    return _TonalCard(
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondaryContainer,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: Theme.of(context).textTheme.bodyLarge),
                Text(usage, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
          if (!kIsWeb) ...[
            IconButton(onPressed: () {}, icon: const Icon(Icons.edit_outlined)),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.delete_outline),
            ),
          ] else ...[
            IconButton(onPressed: () {}, icon: const Icon(Icons.edit_outlined)),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.delete_outline),
            ),
          ],
        ],
      ),
    );
  }
}

String _formatDate(DateTime date) {
  final month = date.month.toString().padLeft(2, '0');
  final day = date.day.toString().padLeft(2, '0');
  return '${date.year}-$month-$day';
}

String _dayOrdinalSuffix(int d) {
  if (d >= 11 && d <= 13) {
    return 'th';
  }
  switch (d % 10) {
    case 1:
      return 'st';
    case 2:
      return 'nd';
    case 3:
      return 'rd';
    default:
      return 'th';
  }
}

String _dayHeaderLabel(DateTime day) {
  const weekdays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];
  const monthsShort = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  return '${weekdays[day.weekday - 1]}, '
      '${day.day}${_dayOrdinalSuffix(day.day)} ${monthsShort[day.month - 1]}';
}

String _formatRawAmount(int cents) {
  final absolute = cents.abs();
  final units = absolute ~/ 100;
  final decimal = (absolute % 100).toString().padLeft(2, '0');
  return '$units.$decimal';
}

Color _categoryIconBackground(String category) {
  switch (category.trim().toLowerCase()) {
    case 'transport':
    case 'travel':
    case 'commute':
      return AppPalette.categoryTransport;
    case 'restaurants':
    case 'restaurant':
    case 'dining':
    case 'food':
    case 'dessert':
    case 'ice cream':
    case 'lunch':
      return AppPalette.categoryFood;
    case 'drinks':
    case 'drink':
    case 'coffee':
    case 'icetea':
      return AppPalette.categoryDrinks;
    case 'shopping':
    case 'groceries':
      return AppPalette.categoryShopping;
    case 'fun':
      return AppPalette.categoryFun;
    case 'health':
      return AppPalette.categoryHealth;
    case 'utilities':
      return AppPalette.categoryUtilities;
    case 'housing':
      return AppPalette.categoryHousing;
    default:
      return AppPalette.categoryUnknown;
  }
}

Color _categoryIconForeground(String category) {
  // The screenshot uses white glyphs over colored circles.
  return Colors.white;
}

IconData _iconForCategory(String category) {
  switch (category.toLowerCase()) {
    case 'restaurants':
    case 'restaurant':
    case 'dining':
    case 'food':
      return Icons.restaurant;
    case 'dessert':
      return Icons.icecream;
    case 'drinks':
    case 'drink':
      return Icons.local_bar;
    case 'coffee':
      return Icons.coffee;
    case 'fun':
      return Icons.movie;
    case 'travel':
      return Icons.flight;
    case 'transport':
      return Icons.directions_bus_filled;
    case 'shopping':
      return Icons.shopping_bag;
    case 'health':
      return Icons.medical_services;
    case 'utilities':
      return Icons.bolt;
    case 'housing':
      return Icons.home;
    default:
      return Icons.receipt_long;
  }
}

IconData _iconForCategoryOutlined(String category) {
  switch (category.toLowerCase()) {
    case 'restaurants':
    case 'restaurant':
    case 'dining':
    case 'food':
      return Icons.restaurant_outlined;
    case 'dessert':
      return Icons.cake_outlined;
    case 'drinks':
    case 'drink':
      return Icons.local_bar_outlined;
    case 'coffee':
      return Icons.coffee_outlined;
    case 'fun':
      return Icons.movie_outlined;
    case 'travel':
      return Icons.flight_outlined;
    case 'transport':
      return Icons.directions_bus_outlined;
    case 'shopping':
      return Icons.shopping_bag_outlined;
    case 'health':
      return Icons.medical_services_outlined;
    case 'utilities':
      return Icons.bolt_outlined;
    case 'housing':
      return Icons.home_outlined;
    default:
      return Icons.receipt_long_outlined;
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.icon,
    required this.label,
    required this.value,
    this.onTap,
    this.useCategoryPalette = true,
  });

  final IconData icon;
  final String label;
  final String value;
  final VoidCallback? onTap;
  final bool useCategoryPalette;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final avatarBg = useCategoryPalette
        ? _categoryIconBackground(value)
        : colors.surfaceContainerHigh;
    final avatarFg = useCategoryPalette
        ? _categoryIconForeground(value)
        : colors.onSurfaceVariant;

    return _TonalCard(
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            CircleAvatar(
              backgroundColor: avatarBg,
              child: Icon(icon, color: avatarFg),
            ),
            const SizedBox(height: 8),
            Text(label, style: Theme.of(context).textTheme.labelSmall),
            const SizedBox(height: 4),
            Text(value, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
