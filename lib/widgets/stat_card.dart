// StatCard: a compact card showing a small uppercase label above a
// larger value. Used for at-a-glance stats (e.g. "MOST USED", "TOTAL").

import 'package:flutter/material.dart';

import 'tonal_card.dart';

class StatCard extends StatelessWidget {
  const StatCard({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return TonalCard(
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
