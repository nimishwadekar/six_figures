// MetricCard: the small summary card on the home dashboard that pairs
// a label with a typographic currency amount (e.g. "Daily Average",
// "Today").

import 'package:flutter/material.dart';

import '../app_theme.dart';
import '../constants.dart';
import 'currency_amount_typographic.dart';

class MetricCard extends StatelessWidget {
  const MetricCard({super.key, required this.label, required this.cents});

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
          CurrencyAmountTypographic(
            cents: cents,
            currencyCode: kHomeCurrencyCode,
            wholeFontSize: 26,
            fractionFontSize: 15,
          ),
        ],
      ),
    );
  }
}
