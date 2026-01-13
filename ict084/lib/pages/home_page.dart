import 'package:flutter/material.dart';
import 'cart_page.dart';
import 'categories_page.dart';
import 'wishlist_page.dart';
import 'profile_page.dart';
import 'search_page.dart';
import 'product_detail_page.dart';
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
          'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=400',
    },
    {
      'name': 'Basketball',
      'price': '\$50',
      'category': 'Sports',
      'image':
          'https://images.unsplash.com/photo-1546519638-68e109498ffc?w=400',
    },
    {
      'name': 'Book: Flutter',
      'price': '\$30',
      'category': 'Books',
      'image':
          'https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?w=400',
    },
    {
      'name': 'Camera',
      'price': '\$799',
      'category': 'Electronics',
      'image':
          'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?w=400',
    },
    {
      'name': 'Running Shoes',
      'price': '\$129',
      'category': 'Fashion',
      'image':
          'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=400',
    },
    {
      'name': 'Coffee Maker',
      'price': '\$89',
      'category': 'Home',
      'image':
          'https://images.unsplash.com/photo-1517668808822-9ebb02f2a0e6?w=400',
    },
  ];

  final List<Map<String, dynamic>> cartProducts = [];
  final List<Map<String, dynamic>> wishlistProducts = [];

  void _addToCart(Map<String, dynamic> product) {
    setState(() {
      cartProducts.add(product);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product['name']} added to cart'),
        action: SnackBarAction(
          label: 'View',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => CartPage(cartProducts: cartProducts)),
            );
          },
        ),
      ),
    );
  }

  void _addToWishlist(Map<String, dynamic> product) {
    setState(() {
      if (!wishlistProducts.contains(product)) {
        wishlistProducts.add(product);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${product['name']} added to wishlist')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Already in wishlist')),
        );
      }
    });
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
      appBar: _selectedIndex == 0
          ? AppBar(
              title: const Text('ShopHub'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SearchPage(allProducts: products),
                      ),
                    );
                  },
                ),
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
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 18,
                            minHeight: 18,
                          ),
                          child: Text(
                            '$_cartCount',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            )
          : null,
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _buildHome(),
          CategoriesPage(categories: categories),
          WishlistPage(
            wishlist: wishlistProducts,
            onRemove: (product) {
              setState(() {
                wishlistProducts.remove(product);
              });
            },
            onAddToCart: (product) {
              _addToCart(product);
            },
          ),
          ProfilePage(
            onLogout: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Logged out successfully')),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (i) => setState(() => _selectedIndex = i),
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton.extended(
              icon: const Icon(Icons.local_offer),
              label: const Text('Offers'),
              onPressed: () {
                _showOffersDialog();
              },
            )
          : null,
    );
  }

  Widget _buildHome() {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 1));
        setState(() {});
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Refreshed')),
        );
      },
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildPromoBanner(),
                CategoryList(
                  categories: categories,
                  selectedIndex: _selectedCategoryIndex,
                  onCategoryTap: (index) => setState(() {
                    _selectedCategoryIndex = index;
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Featured Products',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _selectedCategoryIndex = 0;
                          });
                        },
                        child: const Text('See All'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.7,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final product = filteredProducts[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProductDetailPage(product: product),
                        ),
                      );
                    },
                    child: ProductCard(
                      product: product,
                      onAddToCart: () => _addToCart(product),
                      onAddToWishlist: () => _addToWishlist(product),
                    ),
                  );
                },
                childCount: filteredProducts.length,
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildPromoBanner() {
    return Container(
      margin: const EdgeInsets.all(16),
      height: 160,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade400, Colors.blue.shade700],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            top: -20,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Special Offer!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Get 20% off on all electronics',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      _selectedCategoryIndex = 1; // Electronics
                    });
                  },
                  child: const Text('Shop Now'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showOffersDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.local_offer, color: Colors.blue),
            SizedBox(width: 10),
            Text('Special Offers'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOfferItem('🎉 20% off on Electronics', 'Valid till Jan 20'),
            const SizedBox(height: 12),
            _buildOfferItem('🎁 Buy 2 Get 1 Free on Books', 'Limited time'),
            const SizedBox(height: 12),
            _buildOfferItem('🚚 Free delivery on orders over \$50', 'Always'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Happy shopping!')),
              );
            },
            child: const Text('Shop Now'),
          ),
        ],
      ),
    );
  }

  Widget _buildOfferItem(String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}