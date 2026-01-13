import 'package:flutter/material.dart';

class CategoriesPage extends StatelessWidget {
  final List<String> categories;

  const CategoriesPage({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Categories')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              leading: const Icon(Icons.category),
              title: Text(categories[index]),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content:
                          Text('Selected category: ${categories[index]}')),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
