import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:farmer/constants/constants.dart';
import 'package:farmer/view/cart/cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          if (cartProvider.cartItems.isEmpty) {
            return const Center(child: Text('No items in the cart'));
          }
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cartProvider.cartItems.length,
                  itemBuilder: (context, index) {
                    final cartItem = cartProvider.cartItems[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      child: ListTile(
                        leading: Image.asset(
                          cartItem.image,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        title: Text(cartItem.title),
                        subtitle: Text('₹ ${cartItem.price} x ${cartItem.quantity}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            cartProvider.removeFromCart(cartItem);
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
              // Expose the checkout button at the bottom
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimary,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  onPressed: () {
                    double totalAmount = 0.0;
                    for (var item in cartProvider.cartItems) {
                      totalAmount += double.parse(item.price) * item.quantity;
                    }
                    debugPrint('Proceed to checkout with total: ₹$totalAmount');
                  },
                  child: Consumer<CartProvider>(
                    builder: (context, cartProvider, _) {
                      double totalAmount = 0.0;
                      for (var item in cartProvider.cartItems) {
                        totalAmount +=
                            double.parse(item.price) * item.quantity;
                      }
                      return Text(
                        'Checkout (₹${totalAmount.toStringAsFixed(2)})',
                        style: const TextStyle(fontSize: 16, color: Colors.black),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
