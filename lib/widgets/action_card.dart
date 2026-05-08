// ActionCard: a tappable card with an icon, label and value, used in
// the Add/Edit Expense form for selecting category and date. Picks
// avatar colours from the category palette unless useCategoryPalette is
// disabled.

import 'package:flutter/material.dart';

import '../utils/category_icons.dart';
import 'tonal_card.dart';

class ActionCard extends StatelessWidget {
  const ActionCard({
    super.key,
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
        ? categoryIconBackground(value)
        : colors.surfaceContainerHigh;
    final avatarFg = useCategoryPalette
        ? categoryIconForeground(value)
        : colors.onSurfaceVariant;

    return TonalCard(
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
