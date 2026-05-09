// SliverPersistentHeaderDelegate for ledger dashboard pinned strips:
// blurred glass tint behind Today's Total / Today's Income (configurable).

import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';

import '../app_theme.dart';
import '../constants.dart';
import 'currency_amount_typographic.dart';

class GlassMetricHeaderDelegate extends SliverPersistentHeaderDelegate {
  GlassMetricHeaderDelegate({
    required this.todayCents,
    this.summaryTitle = "Today's Total",
  });

  final int todayCents;
  final String summaryTitle;

  static const double _extent = 100;

  @override
  double get minExtent => _extent;

  @override
  double get maxExtent => _extent;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return SizedBox(
      height: _extent,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: ColoredBox(
            color: AppPalette.midnightGlassFill,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppPalette.midnightSurfaceBorder),
                  color: AppPalette.bg1,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          summaryTitle,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: colors.onSurface,
                          ),
                        ),
                      ),
                      CurrencyAmountTypographic(
                        cents: todayCents,
                        currencyCode: kHomeCurrencyCode,
                        wholeFontSize: 18,
                        fractionFontSize: 12,
                        mainAxisAlignment: MainAxisAlignment.end,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant GlassMetricHeaderDelegate oldDelegate) {
    return oldDelegate.todayCents != todayCents ||
        oldDelegate.summaryTitle != summaryTitle;
  }
}
