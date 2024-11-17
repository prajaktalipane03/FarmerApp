// import 'package:flutter/material.dart';
//
// class CartScreen extends StatefulWidget {
//   @override
//   _CartScreenState createState() => _CartScreenState();
// }
//
// class _CartScreenState extends State<CartScreen> {
//   List<Map<String, dynamic>> cartItems = [
//     {"name": "Product 1", "price": 500, "quantity": 2},
//     {"name": "Product 2", "price": 300, "quantity": 1},
//     {"name": "Product 3", "price": 150, "quantity": 3},
//   ];
//
//   int getTotalPrice() {
//     return cartItems.fold<int>(
//       0,
//           (sum, item) => sum + ((item["price"] * item["quantity"]).toInt()),
//     );
//   }
//
//   void increaseQuantity(int index) {
//     setState(() {
//       cartItems[index]["quantity"]++;
//     });
//   }
//
//   void decreaseQuantity(int index) {
//     setState(() {
//       if (cartItems[index]["quantity"] > 1) {
//         cartItems[index]["quantity"]--;
//       }
//     });
//   }
//
//   void removeItem(int index) {
//     setState(() {
//       cartItems.removeAt(index);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Your Cart"),
//         backgroundColor: Colors.blue,
//       ),
//       body: cartItems.isEmpty
//           ? Center(
//         child: Text(
//           "Your cart is empty",
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//       )
//           : Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: cartItems.length,
//               itemBuilder: (context, index) {
//                 var item = cartItems[index];
//                 return Card(
//                   margin: EdgeInsets.all(8.0),
//                   child: ListTile(
//                     leading: CircleAvatar(
//                       child: Text(
//                         item["name"][0],
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                     title: Text(item["name"]),
//                     subtitle: Text("₹${item["price"]} x ${item["quantity"]}"),
//                     trailing: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         IconButton(
//                           icon: Icon(Icons.remove),
//                           onPressed: () => decreaseQuantity(index),
//                         ),
//                         Text("${item["quantity"]}"),
//                         IconButton(
//                           icon: Icon(Icons.add),
//                           onPressed: () => increaseQuantity(index),
//                         ),
//                         IconButton(
//                           icon: Icon(Icons.delete, color: Colors.red),
//                           onPressed: () => removeItem(index),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.all(16.0),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.5),
//                   blurRadius: 5,
//                   offset: Offset(0, -2),
//                 ),
//               ],
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   "Total: ₹${getTotalPrice()}",
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                   ),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     // Handle checkout functionality here
//                   },
//                   child: Text("Checkout"),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.blue,
//                     padding: EdgeInsets.symmetric(
//                         horizontal: 20, vertical: 12),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//
//
//
//
//
// // import 'package:flutter/material.dart';
// //
// // class CartPage extends StatelessWidget {
// //   final List<Map<String, dynamic>> cartItems = [
// //     {
// //       "title": "Samsung Galaxy M13",
// //       "price": 12999,
// //       "imageUrl": "assets/images/phone.jpg",
// //       "quantity": 1,
// //     },
// //     {
// //       "title": "Sony Headphones",
// //       "price": 2999,
// //       "imageUrl": "assets/images/headphones.jpg",
// //       "quantity": 1,
// //     },
// //     {
// //       "title": "Puma Shoes",
// //       "price": 3499,
// //       "imageUrl": "assets/images/shoes.jpg",
// //       "quantity": 1,
// //     },
// //   ];
// //
// //   CartPage({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text("My Cart"),
// //         backgroundColor: Colors.blue,
// //       ),
// //       body: Column(
// //         children: [
// //           Expanded(
// //             child: ListView.builder(
// //               itemCount: cartItems.length,
// //               itemBuilder: (context, index) {
// //                 var item = cartItems[index];
// //                 return CartItemCard(
// //                   title: item["title"],
// //                   price: item["price"],
// //                   imageUrl: item["imageUrl"],
// //                   quantity: item["quantity"],
// //                   onQuantityChanged: (newQuantity) {
// //                     // Logic for updating quantity
// //                     item["quantity"] = newQuantity;
// //                   },
// //                 );
// //               },
// //             ),
// //           ),
// //           TotalPriceSection(
// //             cartItems: cartItems,
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
// //
// // class CartItemCard extends StatelessWidget {
// //   final String title;
// //   final int price;
// //   final String imageUrl;
// //   final int quantity;
// //   final ValueChanged<int> onQuantityChanged;
// //
// //   const CartItemCard({
// //     required this.title,
// //     required this.price,
// //     required this.imageUrl,
// //     required this.quantity,
// //     required this.onQuantityChanged,
// //     super.key,
// //   });
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Card(
// //       margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
// //       shape: RoundedRectangleBorder(
// //         borderRadius: BorderRadius.circular(10),
// //       ),
// //       child: Padding(
// //         padding: const EdgeInsets.all(10),
// //         child: Row(
// //           children: [
// //             Image.asset(
// //               imageUrl,
// //               height: 80,
// //               width: 80,
// //               fit: BoxFit.cover,
// //               errorBuilder: (context, error, stackTrace) => const Icon(
// //                 Icons.broken_image,
// //                 size: 80,
// //                 color: Colors.grey,
// //               ),
// //             ),
// //             const SizedBox(width: 12),
// //             Expanded(
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Text(
// //                     title,
// //                     style: const TextStyle(
// //                       fontSize: 16,
// //                       fontWeight: FontWeight.bold,
// //                     ),
// //                   ),
// //                   const SizedBox(height: 5),
// //                   Text(
// //                     "₹$price",
// //                     style: const TextStyle(
// //                       fontSize: 16,
// //                       color: Colors.green,
// //                       fontWeight: FontWeight.bold,
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //             Row(
// //               children: [
// //                 IconButton(
// //                   onPressed: () {
// //                     if (quantity > 1) {
// //                       onQuantityChanged(quantity - 1);
// //                     }
// //                   },
// //                   icon: const Icon(Icons.remove_circle),
// //                 ),
// //                 Text(
// //                   "$quantity",
// //                   style: const TextStyle(fontSize: 16),
// //                 ),
// //                 IconButton(
// //                   onPressed: () {
// //                     onQuantityChanged(quantity + 1);
// //                   },
// //                   icon: const Icon(Icons.add_circle),
// //                 ),
// //               ],
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
// // class TotalPriceSection extends StatelessWidget {
// //   final List<Map<String, dynamic>> cartItems;
// //
// //   const TotalPriceSection({required this.cartItems, super.key});
// //
// //   int getTotalPrice() {
// //     return cartItems.fold(
// //       0,
// //           (sum, item) => sum + (item["price"] * item["quantity"]),
// //     );
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       padding: const EdgeInsets.all(16),
// //       color: Colors.white,
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Text(
// //             "Total Price: ₹${getTotalPrice()}",
// //             style: const TextStyle(
// //               fontSize: 20,
// //               fontWeight: FontWeight.bold,
// //             ),
// //           ),
// //           const SizedBox(height: 10),
// //           ElevatedButton(
// //             onPressed: () {
// //               // Logic for checkout
// //               ScaffoldMessenger.of(context).showSnackBar(
// //                 const SnackBar(content: Text("Proceeding to checkout...")),
// //               );
// //             },
// //             style: ElevatedButton.styleFrom(
// //               backgroundColor: Colors.blue,
// //               minimumSize: const Size(double.infinity, 50),
// //               shape: RoundedRectangleBorder(
// //                 borderRadius: BorderRadius.circular(10),
// //               ),
// //             ),
// //             child: const Text(
// //               "Checkout",
// //               style: TextStyle(fontSize: 18),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
// //
// //
//
//
//
// // import 'dart:math';
// //
// // import 'package:farmer/constants/constants.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';
// //
// // import '../../common/custom_container.dart';
// //
// // class CartPage extends StatelessWidget{
// //   const CartPage({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     // TODO: implement build
// //     return Scaffold(
// //       backgroundColor: kPrimary,
// //       appBar: PreferredSize(
// //         preferredSize: Size.fromHeight(130.h), child: Container(height: 130),
// //       ),
// //       body:SafeArea(child: CustomContainer(containerContent: Container()),
// //       ),
// //     );
// //   }
// // }