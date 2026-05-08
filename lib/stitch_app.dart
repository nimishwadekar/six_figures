import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'models/expense.dart';
import 'services/hive_service.dart';

class SereneLedgerShell extends StatefulWidget {
  const SereneLedgerShell({super.key});

  @override
  State<SereneLedgerShell> createState() => _SereneLedgerShellState();
}

class _SereneLedgerShellState extends State<SereneLedgerShell> {
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final isIOS = theme.platform == TargetPlatform.iOS;

    return Scaffold(
      backgroundColor: colors.surface,
      appBar: AppBar(
        backgroundColor: colors.surface.withValues(alpha: 0.94),
        title: Text(
          'ExpenseTracker',
          style: theme.textTheme.headlineMedium?.copyWith(
            color: colors.primary,
            fontWeight: FontWeight.w800,
          ),
        ),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            isIOS ? CupertinoIcons.person_crop_circle : Icons.account_circle,
            color: colors.primary,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => const _SettingsScreen(),
                ),
              );
            },
            icon: Icon(
              isIOS ? CupertinoIcons.settings : Icons.settings,
              color: colors.primary,
            ),
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
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => const _AddExpenseScreen(),
            ),
          );
        },
        backgroundColor: colors.primary,
        child: Icon(isIOS ? CupertinoIcons.add : Icons.add),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (value) => setState(() => _currentIndex = value),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.grid_view_rounded), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.receipt_long_rounded), label: 'Log'),
          NavigationDestination(
            icon: Icon(Icons.account_balance_wallet_rounded),
            label: 'Wallets',
          ),
          NavigationDestination(icon: Icon(Icons.sell_rounded), label: 'Tags'),
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

        final totalCents = expenses.fold<int>(
          0,
          (sum, expense) => sum + expense.amountCents,
        );

        return ListView(
          padding: const EdgeInsets.all(20),
          children: [
            _TonalCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'TOTAL SPENDING',
                    style: theme.textTheme.labelSmall,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${_formatCents(totalCents)}',
                    style: theme.textTheme.displayLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${expenses.length} expense${expenses.length == 1 ? '' : 's'} logged',
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            if (expenses.isEmpty)
              _TonalCard(
                child: Text(
                  'No expenses yet. Tap + to add your first entry.',
                  style: theme.textTheme.bodyLarge,
                ),
              )
            else
              ...expenses.map(
                (expense) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _TonalCard(
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(expense.name, style: theme.textTheme.bodyLarge),
                      subtitle: Text(
                        '${expense.category} • ${expense.tag} • ${expense.currency}',
                        style: theme.textTheme.bodyMedium,
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${expense.currency} ${expense.amountDisplay}',
                            style: theme.textTheme.titleSmall,
                          ),
                          Text(
                            _formatDate(expense.date),
                            style: theme.textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
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
        final compact = constraints.maxWidth <= 384;
        final cardPadding = compact ? 16.0 : 20.0;

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
                children: const [
                  _FilterChip(label: 'Oct 20 - Oct 24', icon: Icons.calendar_today_rounded),
                  _FilterChip(label: 'All Categories', icon: Icons.sell_outlined),
                  _FilterChip(label: 'USD', icon: Icons.payments_outlined),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _DaySection(
              title: 'TODAY',
              total: '-\$84.20',
              items: [
                _ExpenseItem(
                  icon: Icons.restaurant,
                  title: 'The Alchemist Bar',
                  tag: 'Dining',
                  amount: '-\$84.20',
                  converted: '80.00 EUR',
                ),
              ],
              cardPadding: cardPadding,
            ),
            const SizedBox(height: 16),
            _DaySection(
              title: 'YESTERDAY',
              total: '-\$12.50',
              items: [
                _ExpenseItem(
                  icon: Icons.commute,
                  title: 'Uber Central London',
                  tag: 'Travel',
                  amount: '-\$12.50',
                  converted: '10.00 GBP',
                ),
              ],
              cardPadding: cardPadding,
            ),
          ],
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
        Text('Manage your travel funds and live conversion rates.', style: theme.textTheme.bodyMedium),
        const SizedBox(height: 16),
        _TonalCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Estimated Total Balance', style: theme.textTheme.labelSmall),
              const SizedBox(height: 8),
              Text('\$12,450.00', style: theme.textTheme.displayLarge?.copyWith(fontSize: 32)),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: FilledButton.icon(onPressed: () {}, icon: const Icon(Icons.add_circle_outline), label: const Text('NEW WALLET'))),
                  const SizedBox(width: 8),
                  Expanded(child: OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.sync), label: const Text('REFRESH'))),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const _WalletTile(symbol: '€', name: 'Euro Wallet', rate: '1 EUR = 1.08 USD', amount: '€2,400.00', progress: 0.75),
        const SizedBox(height: 12),
        const _WalletTile(symbol: '¥', name: 'Yen Travel Fund', rate: '1 JPY = 0.0067 USD', amount: '¥150,000', progress: 0.40),
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
        Text('Organize your spending with custom labels', style: theme.textTheme.bodyMedium),
        const SizedBox(height: 16),
        Row(
          children: const [
            Expanded(child: _StatCard(label: 'MOST USED', value: 'Dining')),
            SizedBox(width: 12),
            Expanded(child: _StatCard(label: 'TOTAL', value: '12 Tags')),
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
              const Expanded(child: TextField(decoration: InputDecoration(hintText: 'New tag name...', border: InputBorder.none))),
              FilledButton(onPressed: () {}, child: const Text('ADD')),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const _TagTile(icon: Icons.restaurant, name: 'Dining Out', usage: 'Used 24 times'),
        const SizedBox(height: 12),
        const _TagTile(icon: Icons.commute, name: 'Transport', usage: 'Used 18 times'),
      ],
    );
  }
}

class _AddExpenseScreen extends StatefulWidget {
  const _AddExpenseScreen();

  @override
  State<_AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<_AddExpenseScreen> {
  final TextEditingController _amountController = TextEditingController(
    text: '145.50',
  );
  final TextEditingController _nameController = TextEditingController(
    text: 'Lunch at Le Comptoir',
  );
  final TextEditingController _tagController = TextEditingController(
    text: 'Paris Trip',
  );

  final String _selectedCategory = 'Dining';
  final String _selectedCurrency = 'EUR';

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

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(isIOS ? CupertinoIcons.xmark : Icons.close),
        ),
        title: const Text('Add Expense'),
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
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        prefixText: '€',
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
                    icon: Icons.restaurant,
                    label: 'CATEGORY',
                    value: _selectedCategory,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => const _SelectCategoryScreen(),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: _ActionCard(
                    icon: Icons.calendar_today,
                    label: 'DATE',
                    value: 'Today',
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
                      hintText: 'Expense name...',
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
                  Text('TAG', style: theme.textTheme.labelSmall),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _tagController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Tag',
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
    );
  }

  Future<void> _saveExpense() async {
    final amountCents = Expense.parseAmountToCents(_amountController.text);

    final expense = Expense(
      date: DateTime.now(),
      category: _selectedCategory,
      name: _nameController.text.trim().isEmpty
          ? 'Untitled Expense'
          : _nameController.text.trim(),
      currency: _selectedCurrency,
      amountCents: amountCents,
      tag: _tagController.text.trim().isEmpty ? 'General' : _tagController.text.trim(),
    );

    await HiveService.expensesBox.add(expense);

    if (!mounted) {
      return;
    }
    Navigator.of(context).pop();
  }
}

class _SelectCategoryScreen extends StatelessWidget {
  const _SelectCategoryScreen();

  @override
  Widget build(BuildContext context) {
    final categories = const [
      (Icons.restaurant, 'Food'),
      (Icons.flight, 'Travel'),
      (Icons.shopping_bag, 'Shopping'),
      (Icons.medical_services, 'Health'),
      (Icons.event_repeat, 'Subscriptions'),
      (Icons.home, 'Housing'),
      (Icons.bolt, 'Utilities'),
      (Icons.movie, 'Entertainment'),
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
                onTap: () => Navigator.of(context).pop(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(radius: 22, child: Icon(icon)),
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
            const _TonalCard(child: _SettingsRow(icon: Icons.payments, title: 'Default Currency', subtitle: 'USD - US Dollar')),
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
          border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.3)),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0A006A6A),
              blurRadius: 20,
              offset: Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(20),
        child: child,
      ),
    );
  }
}

class _ExpenseItem {
  const _ExpenseItem({
    required this.icon,
    required this.title,
    required this.tag,
    required this.amount,
    required this.converted,
  });

  final IconData icon;
  final String title;
  final String tag;
  final String amount;
  final String converted;
}

class _DaySection extends StatelessWidget {
  const _DaySection({
    required this.title,
    required this.total,
    required this.items,
    required this.cardPadding,
  });

  final String title;
  final String total;
  final List<_ExpenseItem> items;
  final double cardPadding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: theme.textTheme.labelSmall?.copyWith(color: colors.secondary)),
            Text(total, style: theme.textTheme.labelSmall?.copyWith(color: colors.onSurfaceVariant)),
          ],
        ),
        const SizedBox(height: 8),
        ...items.map(
          (item) => _TonalCard(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: cardPadding / 8),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: colors.secondaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(item.icon, color: colors.onSecondaryContainer),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.title, style: theme.textTheme.bodyLarge),
                        const SizedBox(height: 2),
                        Text(item.tag, style: theme.textTheme.labelSmall),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(item.amount, style: theme.textTheme.titleSmall),
                      Text(item.converted, style: theme.textTheme.bodyMedium),
                    ],
                  ),
                ],
              ),
            ),
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
            child: Text(symbol, style: Theme.of(context).textTheme.headlineMedium),
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
              SizedBox(width: 80, child: LinearProgressIndicator(value: progress)),
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
  const _TagTile({
    required this.icon,
    required this.name,
    required this.usage,
  });

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
            IconButton(onPressed: () {}, icon: const Icon(Icons.delete_outline)),
          ] else ...[
            IconButton(onPressed: () {}, icon: const Icon(Icons.edit_outlined)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.delete_outline)),
          ],
        ],
      ),
    );
  }
}

String _formatCents(int cents) {
  final isNegative = cents < 0;
  final absolute = cents.abs();
  final units = absolute ~/ 100;
  final decimal = (absolute % 100).toString().padLeft(2, '0');
  return '${isNegative ? '-' : ''}$units.$decimal';
}

String _formatDate(DateTime date) {
  final month = date.month.toString().padLeft(2, '0');
  final day = date.day.toString().padLeft(2, '0');
  return '${date.year}-$month-$day';
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.icon,
    required this.label,
    required this.value,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final String value;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return _TonalCard(
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            CircleAvatar(child: Icon(icon)),
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
