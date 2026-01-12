import 'package:flutter/material.dart';

void main() {
  runApp(const EcommerceApp());
}

class EcommerceApp extends StatelessWidget {
  const EcommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  int _selectedCategoryIndex = 0;
  int _cartCount = 0;

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
      'image':
          'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=400',
      'rating': 4.5,
    },
    {
      'name': 'Smartphone',
      'price': '\$699',
      'image':
          'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=400',
      'rating': 4.8,
    },
    {
      'name': 'Headphones',
      'price': '\$199',
      'image':
          'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=400',
      'rating': 4.3,
    },
    {
      'name': 'Smart Watch',
      'price': '\$299',
      'image':
          'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=400',
      'rating': 4.6,
    },
    {
      'name': 'Camera',
      'price': '\$1299',
      'image':
          'https://images.unsplash.com/photo-1526170375885-4d8ecf77b99f?w=400',
      'rating': 4.7,
    },
    {
      'name': 'Tablet',
      'price': '\$499',
      'image':
          'https://images.unsplash.com/photo-1561154464-82e9adf32764?w=400',
      'rating': 4.4,
    },
  ];

  void _addToCart() {
    setState(() => _cartCount++);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Added to cart')),
    );
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
                      builder: (_) => CartPage(cartCount: _cartCount),
                    ),
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
                      style: const TextStyle(
                          color: Colors.white, fontSize: 10),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),


      body: _selectedIndex == 0 ? _buildHome() : _buildComingSoon(),
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
        
        SizedBox(
          height: 60,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(10),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedCategoryIndex == index
                        ? Colors.blue
                        : Colors.grey.shade200,
                    foregroundColor: _selectedCategoryIndex == index
                        ? Colors.white
                        : Colors.black,
                  ),
                  onPressed: () {
                    setState(() => _selectedCategoryIndex = index);
                  },
                  child: Text(categories[index]),
                ),
              );
            },
          ),
        ),

   
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: products.length,
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 0.7,
            ),
            itemBuilder: (context, index) {
              return _buildProductCard(products[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 5),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(
                product['image'],
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Text(product['name'],
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(product['price'],
                    style: const TextStyle(color: Colors.blue)),
                IconButton(
                  icon: const Icon(Icons.add_shopping_cart),
                  onPressed: _addToCart,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComingSoon() {
    return const Center(
      child: Text(
        'Coming Soon 🚧',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}



class CartPage extends StatelessWidget {
  final int cartCount;

  const CartPage({super.key, required this.cartCount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Cart')),
      body: Center(
        child: Text(
          'Items in Cart: $cartCount',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
