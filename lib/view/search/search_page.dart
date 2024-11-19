import 'package:farmer/constants/constants.dart';
import 'package:farmer/constants/uidata.dart';
import 'package:farmer/view/cart/product_Detail.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String query = "";

  @override
  Widget build(BuildContext context) {
    // Filter products based on the search query
    final filteredProducts = products
        .where((product) =>
        product['title']!.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Top Search Bar
          Padding(
            padding: const EdgeInsets.only(top: 40.0, left: 16.0, right: 16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    query = value; // Update the search query
                  });
                },
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 15),
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  hintText: 'Search for products',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Product Listing or Animated Placeholder
          Expanded(
            child: query.isEmpty
                ? Center(
              child: Lottie.asset(
                'assets/anime/search.json', // Replace with your animation file
                width: 300,
                height: 300,
                fit: BoxFit.contain,
              ),
            )
                : filteredProducts.isNotEmpty
                ? ListView.builder(
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final product = filteredProducts[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: ListTile(
                    leading: Image.asset(
                      product['imageUrl']!,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(product['title']!),
                    subtitle: Text("Price: ₹${product['price']}"),
                    trailing: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailPage(
                              title: product['title']!,
                              image: product['imageUrl']!,
                              price: product['price']!,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      child: const Text("Add To Cart"),
                    ),
                  ),
                );
              },
            )
                : const Center(
              child: Text(
                "No products found",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ),
          ),
        ],
      ),

    );
  }
}
