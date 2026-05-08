// AppFilterChip: a non-interactive Material Chip with a leading icon,
// used for the read-only filter summaries in the Daily Log header.
// Named with the App- prefix to avoid clashing with Flutter's
// FilterChip.

import 'package:flutter/material.dart';

class AppFilterChip extends StatelessWidget {
  const AppFilterChip({super.key, required this.label, required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Chip(avatar: Icon(icon, size: 16), label: Text(label));
  }
}
