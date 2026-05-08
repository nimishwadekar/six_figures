// TagTile: a tag row for the Tags screen showing the tag icon, name,
// usage count and edit/delete affordances.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'tonal_card.dart';

class TagTile extends StatelessWidget {
  const TagTile({
    super.key,
    required this.icon,
    required this.name,
    required this.usage,
  });

  final IconData icon;
  final String name;
  final String usage;

  @override
  Widget build(BuildContext context) {
    return TonalCard(
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondaryContainer,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: Theme.of(context).textTheme.bodyLarge),
                Text(usage, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
          if (!kIsWeb) ...[
            IconButton(onPressed: () {}, icon: const Icon(Icons.edit_outlined)),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.delete_outline),
            ),
          ] else ...[
            IconButton(onPressed: () {}, icon: const Icon(Icons.edit_outlined)),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.delete_outline),
            ),
          ],
        ],
      ),
    );
  }
}
