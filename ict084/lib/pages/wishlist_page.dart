import 'package:flutter/material.dart';
import 'product_detail_page.dart';

class WishlistPage extends StatelessWidget {
  final List<Map<String, dynamic>> wishlist;
  final Function(Map<String, dynamic>)? onRemove;
  final Function(Map<String, dynamic>)? onAddToCart;

  const WishlistPage({
    super.key,
    required this.wishlist,
    this.onRemove,
    this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Wishlist'),
        actions: [
          if (wishlist.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_sweep),
              onPressed: () {
                _showClearAllDialog(context);
              },
            ),
        ],
      ),
      body: wishlist.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 100,
                    color: Colors.grey.shade300,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Your wishlist is empty',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Add items you like to your wishlist',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade500,
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 15,
                      ),
                    ),
                    icon: const Icon(Icons.shopping_bag),
                    label: const Text('Start Shopping'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.blue.shade50,
                  child: Row(
                    children: [
                      const Icon(Icons.favorite, color: Colors.red),
                      const SizedBox(width: 10),
                      Text(
                        '${wishlist.length} ${wishlist.length == 1 ? 'item' : 'items'} in your wishlist',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: wishlist.length,
                    itemBuilder: (context, index) {
                      final product = wishlist[index];
                      return Dismissible(
                        key: Key(product['name']),
                        background: Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20),
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                          if (onRemove != null) {
                            onRemove!(product);
                          }
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text('${product['name']} removed from wishlist'),
                              action: SnackBarAction(
                                label: 'Undo',
                                onPressed: () {
                                  // Undo functionality
                                },
                              ),
                            ),
                          );
                        },
                        child: Card(
                          margin: const EdgeInsets.only(bottom: 16),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      ProductDetailPage(product: product),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      product['image'],
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          product['name'],
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          product['category'],
                                          style: TextStyle(
                                            color: Colors.grey.shade600,
                                            fontSize: 13,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Text(
                                              product['price'],
                                              style: const TextStyle(
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Container(
                                              padding: const EdgeInsets.symmetric(
                                                horizontal: 8,
                                                vertical: 4,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.green.shade50,
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              child: const Text(
                                                'In Stock',
                                                style: TextStyle(
                                                  color: Colors.green,
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      IconButton(
                                        icon: const Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                        ),
                                        onPressed: () {
                                          if (onRemove != null) {
                                            onRemove!(product);
                                          }
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  '${product['name']} removed'),
                                            ),
                                          );
                                        },
                                      ),
                                      const SizedBox(height: 8),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.add_shopping_cart,
                                          color: Colors.blue,
                                        ),
                                        onPressed: () {
                                          if (onAddToCart != null) {
                                            onAddToCart!(product);
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                if (wishlist.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, -5),
                        ),
                      ],
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        icon: const Icon(Icons.shopping_cart),
                        label: const Text(
                          'Add All to Cart',
                          style: TextStyle(fontSize: 16),
                        ),
                        onPressed: () {
                          if (onAddToCart != null) {
                            for (var product in wishlist) {
                              onAddToCart!(product);
                            }
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('All items added to cart'),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
              ],
            ),
    );
  }

  void _showClearAllDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Clear Wishlist'),
          content:
              const Text('Are you sure you want to remove all items from your wishlist?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
                if (onRemove != null) {
                  for (var product in List.from(wishlist)) {
                    onRemove!(product);
                  }
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Wishlist cleared')),
                );
              },
              child: const Text('Clear All'),
            ),
          ],
        );
      },
    );
  }
}