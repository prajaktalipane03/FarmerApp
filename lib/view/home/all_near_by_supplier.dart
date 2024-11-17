import 'package:flutter/material.dart';

import '../../common/app_style.dart';
import '../../common/reusable_text.dart';
import '../../constants/constants.dart';

// Example supplier data
List<Map<String, String>> supplier = [
  {
    "title": "Lapisara Eatery",
    "time": "6:00am - 9:00pm",
    "imageUrl": "assets/supplier/bhushan.jpg",
    "ratingCount": "6765",
  },
  {
    "title": "Burger King",
    "time": "6:00am - 9:00pm",
    "imageUrl": "assets/supplier/prajakta.jpg",
    "ratingCount": "3278",
  },
  {
    "title": "La Foods",
    "time": "6:00am - 9:00pm",
    "imageUrl": "assets/supplier/shradha.jpg",
    "ratingCount": "5666",
  },
  {
    "title": "Italian Restaurant",
    "time": "6:00am - 9:00pm",
    "imageUrl": "assets/supplier/vaibhav.jpg",
    "ratingCount": "3454",
  },
];

class AllNearBySupplier extends StatelessWidget {
  const AllNearBySupplier({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.3,
        backgroundColor: kOffWhite,
        title: ReusableText(
          text: "All Nearby Suppliers",
          style: appStyle(16, kDark, FontWeight.w600),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: supplier.length,
        itemBuilder: (context, index) {
          var supply = supplier[index];
          return SupplierCard(
            title: supply['title']!,
            time: supply['time']!,
            imageUrl: supply['imageUrl']!,
            rating: supply['ratingCount']!,
          );
        },
      ),
    );
  }
}

class SupplierCard extends StatelessWidget {
  final String title;
  final String time;
  final String imageUrl;
  final String rating;

  const SupplierCard({
    required this.title,
    required this.time,
    required this.imageUrl,
    required this.rating,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: Image.asset(
              imageUrl,
              height: 200, // Adjust height for images
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 200,
                  color: Colors.grey.shade200,
                  child: const Center(
                    child: Icon(Icons.broken_image, size: 50, color: Colors.grey),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.star, size: 16, color: Colors.orange),
                    const SizedBox(width: 4),
                    Text(
                      rating,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}






// import 'package:farmer/common/app_style.dart';
// import 'package:farmer/common/reusable_text.dart';
// import 'package:flutter/material.dart';
//
// import '../../constants/constants.dart';
//
// class AllNearBySupplier extends StatelessWidget{
//   const AllNearBySupplier ({super.key});
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0.3,
//         backgroundColor: kOffWhite,
//         title: ReusableText(text:"All Near by Suppliers",
//           style: appStyle(13, kDark, FontWeight.w600),),
//       ),
//       body: const Center(
//         child: Text("All Near by Suppliers"),
//       ),
//     );
//   }
// }