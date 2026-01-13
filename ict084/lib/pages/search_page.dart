import 'package:flutter/material.dart';
import '../widgets/product_card.dart';
import 'product_detail_page.dart';

class SearchPage extends StatefulWidget {
  final List<Map<String, dynamic>> allProducts;

  const SearchPage({super.key, required this.allProducts});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _filteredProducts = [];
  String _selectedCategory = 'All';
  String _sortBy = 'Name';
  double _minPrice = 0;
  double _maxPrice = 1000;

  @override
  void initState() {
    super.initState();
    _filteredProducts = widget.allProducts;
  }

  void _filterProducts(String query) {
    setState(() {
      _filteredProducts = widget.allProducts.where((product) {
        final matchesQuery =
            product['name'].toLowerCase().contains(query.toLowerCase());
        final matchesCategory = _selectedCategory == 'All' ||
            product['category'] == _selectedCategory;

        // Extract price value
        final priceStr = product['price'].replaceAll('\$', '').replaceAll(',', '');
        final price = double.tryParse(priceStr) ?? 0;
        final matchesPrice = price >= _minPrice && price <= _maxPrice;

        return matchesQuery && matchesCategory && matchesPrice;
      }).toList();

      // Sort products
      if (_sortBy == 'Name') {
        _filteredProducts.sort((a, b) => a['name'].compareTo(b['name']));
      } else if (_sortBy == 'Price: Low to High') {
        _filteredProducts.sort((a, b) {
          final priceA = double.tryParse(
                  a['price'].replaceAll('\$', '').replaceAll(',', '')) ??
              0;
          final priceB = double.tryParse(
                  b['price'].replaceAll('\$', '').replaceAll(',', '')) ??
              0;
          return priceA.compareTo(priceB);
        });
      } else if (_sortBy == 'Price: High to Low') {
        _filteredProducts.sort((a, b) {
          final priceA = double.tryParse(
                  a['price'].replaceAll('\$', '').replaceAll(',', '')) ??
              0;
          final priceB = double.tryParse(
                  b['price'].replaceAll('\$', '').replaceAll(',', '')) ??
              0;
          return priceB.compareTo(priceA);
        });
      }
    });
  }

  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Filters',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Category',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    children: [
                      'All',
                      'Electronics',
                      'Fashion',
                      'Home',
                      'Sports',
                      'Books'
                    ].map((category) {
                      return FilterChip(
                        label: Text(category),
                        selected: _selectedCategory == category,
                        onSelected: (selected) {
                          setModalState(() {
                            _selectedCategory = category;
                          });
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Sort By',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: _sortBy,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    items: ['Name', 'Price: Low to High', 'Price: High to Low']
                        .map((sort) => DropdownMenuItem(
                              value: sort,
                              child: Text(sort),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setModalState(() {
                        _sortBy = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Price Range',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  RangeSlider(
                    values: RangeValues(_minPrice, _maxPrice),
                    min: 0,
                    max: 1000,
                    divisions: 20,
                    labels: RangeLabels(
                      '\$${_minPrice.round()}',
                      '\$${_maxPrice.round()}',
                    ),
                    onChanged: (values) {
                      setModalState(() {
                        _minPrice = values.start;
                        _maxPrice = values.end;
                      });
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('\$${_minPrice.round()}'),
                      Text('\$${_maxPrice.round()}'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: () {
                        setState(() {
                          _selectedCategory = _selectedCategory;
                          _sortBy = _sortBy;
                          _minPrice = _minPrice;
                          _maxPrice = _maxPrice;
                        });
                        _filterProducts(_searchController.text);
                        Navigator.pop(context);
                      },
                      child: const Text('Apply Filters'),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for products...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          _filterProducts('');
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: _filterProducts,
            ),
          ),
          if (_selectedCategory != 'All' || _sortBy != 'Name')
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  if (_selectedCategory != 'All')
                    Chip(
                      label: Text(_selectedCategory),
                      deleteIcon: const Icon(Icons.close, size: 18),
                      onDeleted: () {
                        setState(() {
                          _selectedCategory = 'All';
                        });
                        _filterProducts(_searchController.text);
                      },
                    ),
                  if (_sortBy != 'Name')
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Chip(
                        label: Text(_sortBy),
                        deleteIcon: const Icon(Icons.close, size: 18),
                        onDeleted: () {
                          setState(() {
                            _sortBy = 'Name';
                          });
                          _filterProducts(_searchController.text);
                        },
                      ),
                    ),
                ],
              ),
            ),
          Expanded(
            child: _filteredProducts.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 80,
                          color: Colors.grey.shade300,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No products found',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _filteredProducts.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.7,
                    ),
                    itemBuilder: (context, index) {
                      final product = _filteredProducts[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  ProductDetailPage(product: product),
                            ),
                          );
                        },
                        child: ProductCard(
                          product: product,
                          onAddToCart: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Added to cart')),
                            );
                          },
                          onAddToWishlist: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Added to wishlist')),
                            );
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}