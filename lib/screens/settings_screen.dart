// Settings screen. Surfaces the current account and user preferences
// (default currency, dark mode toggle).

import 'package:flutter/material.dart';

import '../widgets/settings_row.dart';
import '../widgets/tonal_card.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

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
            const TonalCard(
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
            const TonalCard(
              child: SettingsRow(
                icon: Icons.payments,
                title: 'Default Currency',
                subtitle: 'USD - US Dollar',
              ),
            ),
            const SizedBox(height: 8),
            TonalCard(
              child: SettingsRow(
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
