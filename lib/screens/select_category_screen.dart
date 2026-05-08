// Modal category picker. Presents a 2-column grid of category tiles and
// returns the chosen category label via Navigator.pop.

import 'package:flutter/material.dart';

import '../utils/category_icons.dart';
import '../widgets/tonal_card.dart';

class SelectCategoryScreen extends StatelessWidget {
  const SelectCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = const [
      (Icons.restaurant, 'Restaurants'),
      (Icons.flight, 'Travel'),
      (Icons.shopping_bag, 'Shopping'),
      (Icons.commute, 'Transport'),
      (Icons.local_bar, 'Drinks'),
      (Icons.icecream, 'Dessert'),
      (Icons.coffee, 'Coffee'),
      (Icons.movie, 'Fun'),
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Select Category')),
      body: SafeArea(
        child: GridView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.2,
          ),
          itemBuilder: (context, index) {
            final (icon, label) = categories[index];
            return TonalCard(
              child: InkWell(
                onTap: () => Navigator.of(context).pop(label),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 22,
                      backgroundColor: categoryIconBackground(label),
                      child: Icon(icon, color: categoryIconForeground(label)),
                    ),
                    const SizedBox(height: 8),
                    Text(label),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
