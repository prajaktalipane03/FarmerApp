import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../common/app_style.dart';
import '../../common/reusable_text.dart';
import '../../constants/constants.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

List<dynamic> supplier = [
  {
    "_id": "6530ebbcc9e72013e5b65933",
    "title": "Prajakta Lipane",
    "time": "6:00am - 9:00pm",
    "imageUrl": "assets/supplier/bhushan.jpg", // Image URL for slider
    "rating": 5,
    "ratingCount": "6765",
    "coords": {
      "address": "Shindhurwadha Farm, Ajeet Seed,Chh Sambhaji Nagar",
    }
  },
  {
    "_id": "6530ea6bc9e72013e5b6592d",
    "title": "Sharddha Pawar",
    "time": "6:00am - 9:00pm",
    "imageUrl": "assets/supplier/prajakta.jpg", // Image URL for slider
    "rating": 5,
    "ratingCount": "3278",
    "coords": {
      "address": "Pimpri Raja,Chh Sambhaji Nagar",
    }
  },
  {
    "_id": "6530eb66c9e72013e5b65931",
    "title": "Chaitanya Sapkale",
    "time": "6:00am - 9:00pm",
    "imageUrl": "assets/supplier/shradha.jpg", // Image URL for slider
    "rating": 5,
    "ratingCount": "5666",
    "coords": {
      "address": "Kanchanwadi,Chh Sanbhaji Nagar",
    }
  },
  {
    "_id": "6530eb23c9e72013e5b6592f",
    "title": "Italian Restaurant",
    "time": "6:00am - 9:00pm",
    "imageUrl": "assets/supplier/vaibhav.jpg", // Image URL for slider
    "rating": 5,
    "ratingCount": "3278",
    "coords": {
      "address": "Pandharpur,Chh Sambhaji Nagar",
    }
  }
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
          return RestaurantTile(
            supplier: supply,
          );
        },
      ),
    );
  }
}

class RestaurantTile extends StatelessWidget {
  const RestaurantTile({super.key, this.supplier});
  final dynamic supplier;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        decoration: BoxDecoration(
          color: kGrayLight,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image section
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                supplier['imageUrl'] ?? 'assets/supplier/default.jpg',
                height: 100.h, // Fixed height for the image
                width: 100.w, // Fixed width for the image
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 12.w),

            // Information section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title of the supplier
                  ReusableText(
                    text: supplier['title'] ?? 'No Title',
                    style: appStyle(14, kDark, FontWeight.w600),
                  ),
                  SizedBox(height: 4.h),

                  // Delivery time
                  ReusableText(
                    text: "Delivery time: ${supplier['time'] ?? 'N/A'}",
                    style: appStyle(12, kDark, FontWeight.w400),
                  ),
                  SizedBox(height: 8.h),

                  // Address
                  Text(
                    supplier['coords']['address'] ?? 'No Address',
                    overflow: TextOverflow.ellipsis,
                    style: appStyle(12, kDark, FontWeight.w400),
                  ),
                  SizedBox(height: 8.h),

                  // Rating and Icon
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        size: 16,
                        color: Colors.orange,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        supplier['ratingCount'] ?? '0',
                        style: appStyle(12, kDark, FontWeight.w400),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Status section (Open/Closed)
            Positioned(
              right: 5.w,
              top: 5.h,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 10.w),
                decoration: BoxDecoration(
                  color: supplier['isAvailable'] == true || supplier['isAvailable'] == null
                      ? kPrimary
                      : kSecondaryLight,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ReusableText(
                  text: supplier['isAvailable'] == true || supplier['isAvailable'] == null
                      ? "Open"
                      : "Closed",
                  style: appStyle(12, kLightWhite, FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
