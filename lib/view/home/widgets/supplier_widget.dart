import 'package:farmer/constants/constants.dart';
import 'package:farmer/constants/uidata.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:farmer/constants/uidata.dart';

class SupplierWidget extends StatelessWidget {
  const SupplierWidget({
    super.key,
    required this.image,
    required this.logo,
    required this.title,
    required this.time,
    required this.rating,
    this.onTab,
  });

final String image;
  final String logo;
  final String title;
  final String time;
  final String rating;
  final void Function()? onTab;

  @override
  Widget build(BuildContext context) {
    // Get the screen width for responsive sizing
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTab,
      child: Padding(
        padding: EdgeInsets.only(right: 25.w),
        child: Container(
          width: width * 0.75,
          height: 192.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: kLightWhite,
          ),
          child: Column(
            children: [
              // Image and Logo Row
              Padding(
                padding: EdgeInsets.all(8.w),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: SizedBox(
                        height: 112.h,
                        width: width * 0.8,
                        child: Image.asset('imageUrl',
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
