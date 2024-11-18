import 'package:farmer/constants/uidata.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../common/app_style.dart';
import '../../common/reusable_text.dart';
import '../../constants/constants.dart';

// Example supplier data


class AllFastestSupplier extends StatelessWidget {
  const AllFastestSupplier({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.3,
        backgroundColor: kOffWhite,
        title: ReusableText(
          text: "All Fastest Suppliers Closer to you",
          style: appStyle(16, kDark, FontWeight.w600),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: products.length,
        itemBuilder: (context, index) {
          var supply = products[index];
          return SupplierCard(
            title: supply['title']!,
            time: supply['time']!,
            imageUrl: supply['imageUrl']!,
            rating: supply['ratingCount']!,
            price: supply['price']!,
            Deliverytime: supply['Deliverytime']!,
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
  final String price;
  final String Deliverytime;

  const SupplierCard({
    required this.title,
    required this.time,
    required this.imageUrl,
    required this.rating,
    required this.price,
    required this.Deliverytime,
    super.key,
  });

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
        child: Stack(
          children: [
            // Main content section
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image section
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    imageUrl,
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
                        text: title,
                        style: appStyle(14, kDark, FontWeight.w600),
                      ),
                      SizedBox(height: 4.h),

                      // Delivery time
                      ReusableText(
                        text: "Delivery time: $Deliverytime",
                        style: appStyle(12, kDark, FontWeight.w400),
                      ),
                      SizedBox(height: 8.h),

                      // Address or additional info (Here it's 'time', which can be supplier name)
                      Text(
                        time,
                        overflow: TextOverflow.ellipsis,
                        style: appStyle(12, kDark, FontWeight.w400),
                      ),
                      SizedBox(height: 8.h),

                      // Rating section
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: 16,
                            color: Colors.orange,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            rating,
                            style: appStyle(12, kDark, FontWeight.w400),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Price section at the bottom-right
            Positioned(
              bottom: 40.h, // Positioned above the cart button
              right: 8.w,
              child: Container(
                width: 60.w,
                height: 30.h,
                decoration: BoxDecoration(
                  color: kPrimary,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Center(
                  child: ReusableText(
                    text: "₹$price/kg",
                    style: appStyle(12, kLightWhite, FontWeight.bold),
                  ),
                ),
              ),
            ),

            // Cart icon button at the bottom-right
            Positioned(
              bottom: 8.h,
              right: 8.w,
              child: GestureDetector(
                onTap: () {
                  // Action when cart button is tapped (e.g., add to cart)
                },
                child: Icon(
                  Icons.add_shopping_cart,
                  size: 24, // Increased the size of the icon for better visibility
                  color: kSecondary, // Color of the cart icon
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
