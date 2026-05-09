// TonalCard: bordered rounded container used as the standard wrapper
// around grouped content throughout the app.

import 'package:flutter/material.dart';

import '../app_theme.dart';

class TonalCard extends StatelessWidget {
  const TonalCard({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppPalette.midnightSurfaceBorder),
        color: AppPalette.bg1,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: child,
      ),
    );
  }
}
