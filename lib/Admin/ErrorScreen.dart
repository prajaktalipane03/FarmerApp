import 'package:flutter/material.dart';

// void main() {
//   runApp(const FoodlyAdminPanel());
// }

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AdminPanelPage(),
    );
  }
}

class AdminPanelPage extends StatelessWidget {
  final List<Map<String, String>> restaurants = [
    {
      'name': 'Italian Restaurant',
      'address': '333 O’Farrell St, San Francisco, CA 94102',
      'hours': '11:00 AM - 9:00 PM'
    },
    {
      'name': 'La Foods',
      'address': '333 O’Farrell St, San Francisco, CA 94102',
      'hours': '11:00 AM - 9:00 PM'
    },
    {
      'name': 'Lapisara Eatery',
      'address': '698 Post St, San Francisco, CA 94109',
      'hours': '11:00 AM - 9:00 PM'
    },
    {
      'name': 'Delicious Pizza Place',
      'address': '123 Main Street, Cityville, USA',
      'hours': '11:00 AM - 9:00 PM'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Foodly Admin Panel'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.power_settings_new),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              children: [
                _buildIconButton(Icons.restaurant, 'Restaurants'),
                _buildIconButton(Icons.local_shipping, 'Drivers'),
                _buildIconButton(Icons.shopping_cart, 'Orders'),
                _buildIconButton(Icons.category, 'Categories'),
                _buildIconButton(Icons.fastfood, 'Foods'),
                _buildIconButton(Icons.people, 'Users'),
                _buildIconButton(Icons.attach_money, 'Cashout'),
                _buildIconButton(Icons.more_horiz, 'More'),
              ],
            ),
          ),
          const TabBarContainer(),
          Expanded(
            child: ListView.builder(
              itemCount: restaurants.length,
              itemBuilder: (context, index) {
                final restaurant = restaurants[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage('assets/kfc_logo.png'), // Replace with your asset
                    ),
                    title: Text(restaurant['name']!),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Delivery time: ${restaurant['hours']}'),
                        Text(restaurant['address']!),
                      ],
                    ),
                    trailing: ElevatedButton(
                      onPressed: () {},
                      child: const Text('Open'),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, size: 32, color: Colors.teal),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}

class TabBarContainer extends StatelessWidget {
  const TabBarContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: Colors.grey[200],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          TabButton(label: 'Pending', isSelected: true),
          TabButton(label: 'Verified', isSelected: false),
          TabButton(label: 'Rejected', isSelected: false),
        ],
      ),
    );
  }
}

class TabButton extends StatelessWidget {
  final String label;
  final bool isSelected;

  const TabButton({
    required this.label,
    required this.isSelected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: isSelected ? Colors.white : Colors.teal, backgroundColor: isSelected ? Colors.teal : Colors.transparent,
      ),
      onPressed: () {},
      child: Text(label),
    );
  }
}