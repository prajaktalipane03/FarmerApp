import 'package:farmer/constants/uidata.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NearBySuppliers extends StatelessWidget {
  const NearBySuppliers({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220.h, // Increase height for a rectangular appearance
      padding: EdgeInsets.only(left: 12.w, top: 10.h),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: supplier.length,
        itemBuilder: (context, index) {
          var supply = supplier[index];
          return SupplierWidget(
            image: supply['imageUrl'],
            logo: supply['logoUrl'],
            title: supply['title'],
            time: supply['time'],
            rating: supply['ratingCount'],
          );
        },
      ),
    );
  }
}

class SupplierWidget extends StatelessWidget {
  final String image;
  final String logo;
  final String title;
  final String time;
  final String rating;

  const SupplierWidget({
    required this.image,
    required this.logo,
    required this.title,
    required this.time,
    required this.rating,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250.w, // Increased width for a rectangular appearance
      margin: EdgeInsets.symmetric(horizontal: 8.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Image.asset(
              image,
              height: 120.h, // Adjust image height to maintain aspect ratio
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  time,
                  style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                ),
                SizedBox(height: 5.h),
                Row(
                  children: [
                    Icon(Icons.star, size: 14.sp, color: Colors.orange),
                    SizedBox(width: 5.w),
                    Text(
                      rating,
                      style: TextStyle(fontSize: 12.sp),
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

// Example supplier data

