import 'package:flutter/material.dart';
import 'cart_page.dart';
import 'categories_page.dart';
import 'wishlist_page.dart';
import 'profile_page.dart';
import '../widgets/product_card.dart';
import '../widgets/category_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  int _selectedCategoryIndex = 0;

  final List<String> categories = [
    'All',
    'Electronics',
    'Fashion',
    'Home',
    'Sports',
    'Books',
  ];

  final List<Map<String, dynamic>> products = [
    {
      'name': 'Laptop',
      'price': '\$999',
      'category': 'Electronics',
      'image':
          'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=400',
    },
    {
      'name': 'Smartphone',
      'price': '\$699',
      'category': 'Electronics',
      'image':
          'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=400',
    },
    {
      'name': 'Headphones',
      'price': '\$199',
      'category': 'Electronics',
      'image':
          'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=400',
    },
    {
      'name': 'Smart Watch',
      'price': '\$299',
      'category': 'Fashion',
      'image':
          'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=400',
    },
    {
      'name': 'Sofa',
      'price': '\$499',
      'category': 'Home',
      'image':
          'https://images.unsplash.com/photo-1582582494704-05e1c4c12713?w=400',
    },
    {
      'name': 'Basketball',
      'price': '\$50',
      'category': 'Sports',
      'image':
          'https://www.canva.com/photos/MAF8v0mGXaQ-grey-fabric-sofa/',
    },
    {
      'name': 'Book: Flutter',
      'price': '\$30',
      'category': 'Books',
      'image':
          'https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?w=400',
    },
  ];

  final List<Map<String, dynamic>> cartProducts = [];
  final List<Map<String, dynamic>> wishlistProducts = [];

  void _addToCart(Map<String, dynamic> product) {
    setState(() {
      cartProducts.add(product);
    });
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Added to cart')));
  }

  void _addToWishlist(Map<String, dynamic> product) {
    setState(() {
      if (!wishlistProducts.contains(product)) wishlistProducts.add(product);
    });
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Added to wishlist')));
  }

  int get _cartCount => cartProducts.length;

  List<Map<String, dynamic>> get filteredProducts {
    if (_selectedCategoryIndex == 0) return products;
    return products
        .where((p) => p['category'] == categories[_selectedCategoryIndex])
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Store'),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) =>
                            CartPage(cartProducts: cartProducts)),
                  );
                },
              ),
              if (_cartCount > 0)
                Positioned(
                  right: 6,
                  top: 6,
                  child: CircleAvatar(
                    radius: 9,
                    backgroundColor: Colors.red,
                    child: Text(
                      '$_cartCount',
                      style:
                          const TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _buildHome(), // Home
          CategoriesPage(categories: categories), // Categories
          WishlistPage(wishlist: wishlistProducts), // Wishlist
          const ProfilePage(), // Profile
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (i) => setState(() => _selectedIndex = i),
        selectedItemColor: Colors.blue,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: 'Categories'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border), label: 'Wishlist'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.local_offer),
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text('Special Offers'),
              content: const Text('🎉 Get 20% off today only!'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHome() {
    return Column(
      children: [
        CategoryList(
          categories: categories,
          selectedIndex: _selectedCategoryIndex,
          onCategoryTap: (index) => setState(() {
            _selectedCategoryIndex = index;
          }),
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: filteredProducts.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.7,
            ),
            itemBuilder: (context, index) {
              final product = filteredProducts[index];
              return ProductCard(
                product: product,
                onAddToCart: () => _addToCart(product),
                onAddToWishlist: () => _addToWishlist(product),
              );
            },
          ),
        ),
      ],
    );
  }
}
