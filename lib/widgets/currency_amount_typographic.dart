// CurrencyAmountTypographic: renders a monetary amount as a
// muted currency code followed by a bold whole part and a smaller
// fractional part. Reused everywhere the app shows money.

import 'package:flutter/material.dart';

/// Reference-style amount: grey code + bold whole + smaller fraction.
class CurrencyAmountTypographic extends StatelessWidget {
  const CurrencyAmountTypographic({
    super.key,
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
