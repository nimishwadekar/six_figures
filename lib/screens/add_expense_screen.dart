// Add/edit expense form. Captures amount, category, date, name and
// payment-method tag, validates the amount input, and writes the result
// to the Hive expense box (creating a new entry or updating the one
// passed in via initialExpense).

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/expense.dart';
import '../services/hive_service.dart';
import '../utils/amount_format.dart';
import '../utils/category_icons.dart';
import '../utils/date_format.dart';
import '../widgets/action_card.dart';
import '../widgets/tonal_card.dart';
import 'select_category_screen.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({
    super.key,
    required this.initialCategory,
    this.initialExpense,
  });

  final String initialCategory;
  final Expense? initialExpense;

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
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
        : formatRawAmount(initialExpense.amountCents);
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
              const TonalCard(
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
                    child: ActionCard(
                      icon: iconForCategory(_selectedCategory),
                      label: 'CATEGORY',
                      value: _selectedCategory,
                      onTap: () {
                        Navigator.of(context)
                            .push<String>(
                              MaterialPageRoute<String>(
                                builder: (_) => const SelectCategoryScreen(),
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
                    child: ActionCard(
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
              TonalCard(
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
              TonalCard(
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
    return formatDate(_selectedDate);
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
