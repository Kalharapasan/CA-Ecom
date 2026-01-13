import 'package:flutter/material.dart';

class WishlistPage extends StatelessWidget {
  final List<Map<String, dynamic>> wishlist;

  const WishlistPage({super.key, required this.wishlist});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wishlist')),
      body: wishlist.isEmpty
          ? const Center(child: Text('Your wishlist is empty'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: wishlist.length,
              itemBuilder: (context, index) {
                final product = wishlist[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: ListTile(
                    leading: Image.network(product['image'], width: 50),
                    title: Text(product['name']),
                    subtitle: Text(product['price']),
                    trailing: const Icon(Icons.favorite, color: Colors.red),
                  ),
                );
              },
            ),
    );
  }
}
