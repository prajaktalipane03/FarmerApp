import 'package:flutter/material.dart';

// Define the CartItem model
class CartItem {
  final String title;
  final String image;
  final String price;
  int quantity;

  CartItem({
    required this.title,
    required this.image,
    required this.price,
    this.quantity = 1,
  });
}

class CartProvider extends ChangeNotifier {
  List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  // Add item to cart
  void addToCart(CartItem item) {
    _cartItems.add(item);
    notifyListeners();
  }

  // Remove item from cart
  void removeFromCart(CartItem item) {
    _cartItems.remove(item);
    notifyListeners();
  }

  // Update quantity of an item in cart
  void updateQuantity(CartItem item, int newQuantity) {
    item.quantity = newQuantity;
    notifyListeners();
  }
}
