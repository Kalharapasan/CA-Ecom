import 'package:flutter/material.dart';
import 'order_history_page.dart';
import 'settings_page.dart';

class ProfilePage extends StatelessWidget {
  final VoidCallback? onLogout;

  const ProfilePage({super.key, this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.blue.shade400,
                      Colors.blue.shade700,
                    ],
                  ),
                ),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 40),
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                          'https://images.unsplash.com/photo-1502767089025-6572583495b4?w=400',
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Pasan Kalhara',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'kalharap84@gmail.com',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  _buildStatsCard(),
                  const SizedBox(height: 20),
                  _buildMenuSection(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCard() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildStatItem(Icons.shopping_bag, '12', 'Orders'),
            Container(width: 1, height: 40, color: Colors.grey.shade300),
            _buildStatItem(Icons.favorite, '8', 'Wishlist'),
            Container(width: 1, height: 40, color: Colors.grey.shade300),
            _buildStatItem(Icons.star, '4.8', 'Rating'),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.blue, size: 28),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildMenuSection(BuildContext context) {
    return Column(
      children: [
        _buildMenuItem(
          context,
          icon: Icons.history,
          title: 'Order History',
          subtitle: 'View your past orders',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const OrderHistoryPage()),
            );
          },
        ),
        _buildMenuItem(
          context,
          icon: Icons.location_on,
          title: 'Addresses',
          subtitle: 'Manage your delivery addresses',
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Address management')),
            );
          },
        ),
        _buildMenuItem(
          context,
          icon: Icons.payment,
          title: 'Payment Methods',
          subtitle: 'Manage your payment options',
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Payment methods')),
            );
          },
        ),
        _buildMenuItem(
          context,
          icon: Icons.notifications,
          title: 'Notifications',
          subtitle: 'View all notifications',
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Notifications')),
            );
          },
        ),
        _buildMenuItem(
          context,
          icon: Icons.settings,
          title: 'Settings',
          subtitle: 'App preferences and settings',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SettingsPage()),
            );
          },
        ),
        _buildMenuItem(
          context,
          icon: Icons.help,
          title: 'Help & Support',
          subtitle: 'Get help with your orders',
          onTap: () {
            _showHelpDialog(context);
          },
        ),
        _buildMenuItem(
          context,
          icon: Icons.info,
          title: 'About',
          subtitle: 'App version and information',
          onTap: () {
            _showAboutDialog(context);
          },
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: const Icon(Icons.logout),
            label: const Text('Logout', style: TextStyle(fontSize: 16)),
            onPressed: () {
              _showLogoutDialog(context);
            },
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.blue),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
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
                if (onLogout != null) {
                  onLogout!();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Logged out successfully')),
                  );
                }
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Help & Support'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHelpOption(Icons.email, 'Email', 'support@shophub.com'),
              const SizedBox(height: 12),
              _buildHelpOption(Icons.phone, 'Phone', '+1 234 567 8900'),
              const SizedBox(height: 12),
              _buildHelpOption(Icons.chat, 'Live Chat', 'Available 24/7'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildHelpOption(IconData icon, String title, String subtitle) {
    return Row(
      children: [
        Icon(icon, color: Colors.blue),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('About ShopHub'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ShopHub',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              SizedBox(height: 8),
              Text('Version 1.0.0'),
              SizedBox(height: 16),
              Text(
                'Your one-stop destination for online shopping. Browse thousands of products and enjoy seamless shopping experience.',
              ),
              SizedBox(height: 16),
              Text(
                '© 2025 ShopHub. All rights reserved.',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}