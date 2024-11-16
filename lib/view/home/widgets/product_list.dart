import 'package:farmer/common/custom_appbar.dart';
import 'package:farmer/constants/constants.dart';
import 'package:farmer/constants/uidata.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductList extends StatelessWidget{
  const ProductList ({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 210.h,
      padding: EdgeInsets.only(left: 12.w,top: 10.h),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(products.length, (i){
          var product = products[i];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 200.h,
              width: 150.w,
              color: kPrimary,
            ),
          );
        }),
      ),
    );
  }
}