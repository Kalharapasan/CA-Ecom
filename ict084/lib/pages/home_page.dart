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

  // Products with BOTH asset and network images
  // The app will try asset image first, then fallback to network image
  final List<Map<String, dynamic>> products = [
    {
      'name': 'Laptop',
      'price': '\$999',
      'category': 'Electronics',
      'assetImage': 'assets/images/products/laptop.jpg',
      'networkImage': 'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=400',
    },
    {
      'name': 'Smartphone',
      'price': '\$699',
      'category': 'Electronics',
      'assetImage': 'assets/images/products/smartphone.jpg',
      'networkImage': 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=400',
    },
    {
      'name': 'Headphones',
      'price': '\$199',
      'category': 'Electronics',
      'assetImage': 'assets/images/products/headphones.jpg',
      'networkImage': 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=400',
    },
    {
      'name': 'Smart Watch',
      'price': '\$299',
      'category': 'Fashion',
      'assetImage': 'assets/images/products/smartwatch.jpg',
      'networkImage': 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=400',
    },
    {
      'name': 'Camera',
      'price': '\$799',
      'category': 'Electronics',
      'assetImage': 'assets/images/products/camera.jpg',
      'networkImage': 'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?w=400',
    },
    {
      'name': 'Sofa',
      'price': '\$499',
      'category': 'Home',
      'assetImage': 'assets/images/products/sofa.jpg',
      'networkImage': 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=400',
    },
    {
      'name': 'Running Shoes',
      'price': '\$129',
      'category': 'Fashion',
      'assetImage': 'assets/images/products/shoes.jpg',
      'networkImage': 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=400',
    },
    {
      'name': 'Basketball',
      'price': '\$50',
      'category': 'Sports',
      'assetImage': 'assets/images/products/basketball.jpg',
      'networkImage': 'https://images.unsplash.com/photo-1546519638-68e109498ffc?w=400',
    },
    {
      'name': 'Coffee Maker',
      'price': '\$89',
      'category': 'Home',
      'assetImage': 'assets/images/products/coffee_maker.jpg',
      'networkImage': 'https://images.unsplash.com/photo-1517668808822-9ebb02f2a0e6?w=400',
    },
    {
      'name': 'Book: Flutter',
      'price': '\$30',
      'category': 'Books',
      'assetImage': 'assets/images/products/book_flutter.jpg',
      'networkImage': 'https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?w=400',
    },
    {
      'name': 'Yoga Mat',
      'price': '\$35',
      'category': 'Sports',
      'assetImage': 'assets/images/products/yoga_mat.jpg',
      'networkImage': 'https://images.unsplash.com/photo-1601925260368-ae2f83cf8b7f?w=400',
    },
    {
      'name': 'Backpack',
      'price': '\$79',
      'category': 'Fashion',
      'assetImage': 'assets/images/products/backpack.jpg',
      'networkImage': 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=400',
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
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _addToWishlist(Map<String, dynamic> product) {
    setState(() {
      if (!wishlistProducts.contains(product)) {
        wishlistProducts.add(product);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${product['name']} added to wishlist'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Already in wishlist'),
            behavior: SnackBarBehavior.floating,
          ),
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
              title: Row(
                children: [
                  const Icon(Icons.shopping_bag, color: Colors.blue),
                  const SizedBox(width: 8),
                  const Text('ShopHub'),
                ],
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.search),
                  tooltip: 'Search',
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
                      tooltip: 'Cart',
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
                        right: 8,
                        top: 8,
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
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
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
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Refreshed'),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildPromoBanner(),
                const SizedBox(height: 10),
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
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton.icon(
                        icon: const Icon(Icons.arrow_forward, size: 18),
                        label: const Text('See All'),
                        onPressed: () {
                          setState(() {
                            _selectedCategoryIndex = 0;
                          });
                        },
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
            child: SizedBox(height: 80),
          ),
        ],
      ),
    );
  }

  Widget _buildPromoBanner() {
    return Container(
      margin: const EdgeInsets.all(16),
      height: 180,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue.shade400,
            Colors.blue.shade600,
            Colors.blue.shade800,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -30,
            top: -30,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            left: -20,
            bottom: -20,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    '🔥 HOT DEAL',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Special Offer!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
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
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                  icon: const Icon(Icons.shopping_cart),
                  label: const Text(
                    'Shop Now',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    setState(() {
                      _selectedCategoryIndex = 1;
                    });
                  },
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Row(
          children: [
            Icon(Icons.local_offer, color: Colors.orange),
            SizedBox(width: 10),
            Text('Special Offers'),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildOfferItem(
                '🎉 20% off on Electronics',
                'Valid till Jan 31, 2025',
                Colors.blue,
              ),
              const SizedBox(height: 12),
              _buildOfferItem(
                '🎁 Buy 2 Get 1 Free',
                'On all Books',
                Colors.green,
              ),
              const SizedBox(height: 12),
              _buildOfferItem(
                '🚚 Free Delivery',
                'On orders over \$50',
                Colors.orange,
              ),
              const SizedBox(height: 12),
              _buildOfferItem(
                '⭐ Flash Sale',
                'Up to 50% off on Fashion',
                Colors.purple,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Happy shopping! 🛍️')),
              );
            },
            child: const Text('Shop Now'),
          ),
        ],
      ),
    );
  }

  Widget _buildOfferItem(String title, String subtitle, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 40,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}