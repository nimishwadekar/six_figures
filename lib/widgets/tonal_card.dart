// TonalCard: a rounded, lightly bordered, soft-shadowed Material card
// used as the standard container around grouped content throughout the
// app.

import 'package:flutter/material.dart';

class TonalCard extends StatelessWidget {
  const TonalCard({super.key, required this.child});

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
