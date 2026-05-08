// Tags management tab. Shows usage stats, a quick-add input for new
// tags, and tiles for each existing tag with edit/delete actions.

import 'package:flutter/material.dart';

import '../widgets/stat_card.dart';
import '../widgets/tag_tile.dart';
import '../widgets/tonal_card.dart';

class TagsScreen extends StatelessWidget {
  const TagsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text('Manage Tags', style: theme.textTheme.headlineLarge),
        Text(
          'Organize your spending with custom labels',
          style: theme.textTheme.bodyMedium,
        ),
        const SizedBox(height: 16),
        Row(
          children: const [
            Expanded(
              child: StatCard(label: 'MOST USED', value: 'Dining'),
            ),
            SizedBox(width: 12),
            Expanded(
              child: StatCard(label: 'TOTAL', value: '12 Tags'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        TonalCard(
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.palette_outlined),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'New tag name...',
                    border: InputBorder.none,
                  ),
                ),
              ),
              FilledButton(onPressed: () {}, child: const Text('ADD')),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const TagTile(
          icon: Icons.restaurant,
          name: 'Dining Out',
          usage: 'Used 24 times',
        ),
        const SizedBox(height: 12),
        const TagTile(
          icon: Icons.commute,
          name: 'Transport',
          usage: 'Used 18 times',
        ),
      ],
    );
  }
}
