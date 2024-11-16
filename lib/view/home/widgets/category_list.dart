import 'package:farmer/controllers/category_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:farmer/constants/constants.dart'; // Make sure your constants are here (e.g., kPrimary, kDark, etc.)
import 'package:farmer/constants/uidata.dart'; // Make sure you import your categories list here
import 'package:farmer/common/reusable_text.dart'; // Import ReusableText widget
import 'package:farmer/common/app_style.dart';
import 'package:get/get.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());
    // Get screen width for responsive layout
    double width = MediaQuery.of(context).size.width;

    return Container(
      height: 80.h,
      padding: EdgeInsets.only(left: 15.w, top: 10.h),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(categories.length, (i) {
          var category = categories[i];
          return GestureDetector(
            onTap:(){
              if(controller.categoryValue == category['_id']){
                controller.updateCategory = '';
                controller.updateTitle = '';
              }
              else{
                controller.updateCategory = category['_id'];
                controller.updateTitle = category['title'];
              }
            },
            child: Obx(()=>Container(
              margin: EdgeInsets.only(right: 20.w),
              padding: EdgeInsets.only(top: 8.h),
              width: width * 0.19, // Responsive width based on screen width
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: controller.categoryValue == category['_id'] ? kPrimaryLight: kOffWhite, width: .5.w),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 35.h,
                    child: Image.asset(
                      category['imageUrl'], // Ensure the key exists in the data
                      fit: BoxFit.contain,
                    ),
                  ),
                  ReusableText(
                    text: category['title'], // Ensure the key exists in the data
                    style: appStyle(13, kDark, FontWeight.normal),
                  ),
                ],
              ),
            ),
            ));
        }),
      ),
    );
  }
}
