import 'package:flutter/material.dart';

class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({super.key});

  final List<Map<String, dynamic>> _orders = const [
    {
      'orderId': '#ORD-2024-001',
      'date': 'Jan 10, 2025',
      'items': 3,
      'total': '\$1,497',
      'status': 'Delivered',
      'statusColor': Colors.green,
      'products': [
        {'name': 'Laptop', 'quantity': 1, 'price': '\$999'},
        {'name': 'Headphones', 'quantity': 2, 'price': '\$199'},
      ],
    },
    {
      'orderId': '#ORD-2024-002',
      'date': 'Jan 8, 2025',
      'items': 2,
      'total': '\$798',
      'status': 'In Transit',
      'statusColor': Colors.orange,
      'products': [
        {'name': 'Smartphone', 'quantity': 1, 'price': '\$699'},
        {'name': 'Smart Watch', 'quantity': 1, 'price': '\$299'},
      ],
    },
    {
      'orderId': '#ORD-2024-003',
      'date': 'Jan 5, 2025',
      'items': 1,
      'total': '\$499',
      'status': 'Processing',
      'statusColor': Colors.blue,
      'products': [
        {'name': 'Sofa', 'quantity': 1, 'price': '\$499'},
      ],
    },
    {
      'orderId': '#ORD-2024-004',
      'date': 'Dec 28, 2024',
      'items': 2,
      'total': '\$80',
      'status': 'Delivered',
      'statusColor': Colors.green,
      'products': [
        {'name': 'Basketball', 'quantity': 1, 'price': '\$50'},
        {'name': 'Book: Flutter', 'quantity': 1, 'price': '\$30'},
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order History'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _orders.length,
        itemBuilder: (context, index) {
          final order = _orders[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: InkWell(
              onTap: () {
                _showOrderDetails(context, order);
              },
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          order['orderId'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: (order['statusColor'] as Color).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            order['status'],
                            style: TextStyle(
                              color: order['statusColor'],
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.calendar_today,
                            size: 16, color: Colors.grey.shade600),
                        const SizedBox(width: 8),
                        Text(
                          order['date'],
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Icon(Icons.shopping_bag,
                            size: 16, color: Colors.grey.shade600),
                        const SizedBox(width: 8),
                        Text(
                          '${order['items']} items',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Divider(),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total Amount',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          order['total'],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (order['status'] == 'Delivered')
                          TextButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Reorder functionality')),
                              );
                            },
                            child: const Text('Reorder'),
                          ),
                        TextButton.icon(
                          icon: const Icon(Icons.remove_red_eye, size: 18),
                          label: const Text('View Details'),
                          onPressed: () {
                            _showOrderDetails(context, order);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showOrderDetails(BuildContext context, Map<String, dynamic> order) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.7,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          expand: false,
          builder: (context, scrollController) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Order Details',
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
                  _buildInfoRow('Order ID', order['orderId']),
                  _buildInfoRow('Date', order['date']),
                  _buildInfoRow('Status', order['status']),
                  _buildInfoRow('Total', order['total']),
                  const SizedBox(height: 20),
                  const Text(
                    'Items',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount:
                          (order['products'] as List<Map<String, dynamic>>)
                              .length,
                      itemBuilder: (context, index) {
                        final product = (order['products']
                            as List<Map<String, dynamic>>)[index];
                        return Card(
                          child: ListTile(
                            title: Text(product['name']),
                            subtitle: Text('Quantity: ${product['quantity']}'),
                            trailing: Text(
                              product['price'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (order['status'] == 'In Transit' ||
                      order['status'] == 'Processing')
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Track order functionality')),
                          );
                        },
                        child: const Text('Track Order'),
                      ),
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}