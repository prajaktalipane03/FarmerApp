class CartModel {
  final String title;
  final String image;
  final String price;
  int quantity;

  CartModel({
    required this.title,
    required this.image,
    required this.price,
    this.quantity = 1,
  });
}
