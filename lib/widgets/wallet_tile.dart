// WalletTile: a single wallet row showing the currency symbol, name,
// conversion rate, balance and a usage progress bar. Used on the
// Wallets & Rates screen.

import 'package:flutter/material.dart';

import 'tonal_card.dart';

class WalletTile extends StatelessWidget {
  const WalletTile({
    super.key,
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
    return TonalCard(
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
