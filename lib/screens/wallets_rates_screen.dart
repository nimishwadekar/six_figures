// Wallets & Rates tab. Displays the estimated total balance, controls
// for creating/refreshing wallets, and a list of per-currency wallet
// tiles with conversion rates and progress bars.

import 'package:flutter/material.dart';

import '../widgets/tonal_card.dart';
import '../widgets/wallet_tile.dart';

class WalletsRatesScreen extends StatelessWidget {
  const WalletsRatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 110),
      children: [
        Text('Wallets & Rates', style: theme.textTheme.headlineLarge),
        Text(
          'Manage your travel funds and live conversion rates.',
          style: theme.textTheme.bodyMedium,
        ),
        const SizedBox(height: 16),
        TonalCard(
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
                style: theme.textTheme.displayLarge?.copyWith(fontSize: 26),
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
        const WalletTile(
          symbol: '€',
          name: 'Euro Wallet',
          rate: '1 EUR = 1.08 USD',
          amount: '€2,400.00',
          progress: 0.75,
        ),
        const SizedBox(height: 12),
        const WalletTile(
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
