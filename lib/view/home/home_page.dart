import 'dart:math';

import 'package:farmer/common/custom_appbar.dart';
import 'package:farmer/common/custom_container.dart';
import 'package:farmer/common/heading.dart';
import 'package:farmer/constants/constants.dart';
import 'package:farmer/view/home/all_faster_supplier.dart';
import 'package:farmer/view/home/all_near_by_supplier.dart';
import 'package:farmer/view/home/widgets/category_list.dart';
import 'package:farmer/view/home/widgets/nearby_supplier_list.dart';
import 'package:farmer/view/home/widgets/product_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


class HomePage extends StatelessWidget{
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: kPrimary,
      appBar: PreferredSize(
       preferredSize: Size.fromHeight(130.h),
       child: const CustomAppBar()),

      body:SafeArea(
        child: CustomContainer(containerContent: Column(
          children: [
            const CategoryList(),

            Heading(text: "Nearby Suppliers",
            onTap: () {
            Get.to(() => const AllNearBySupplier(),
              transition: Transition.cupertino,
              duration: const Duration(milliseconds: 900));
            },
            ),
             const NearBySuppliers(),
            Heading(text: "Fastest Supplier closer to you",
              onTap: (){
                Get.to(()=>const AllFastestSupplier(),
                    transition: Transition.cupertino,
                    duration: const Duration(milliseconds: 900));
              },
            ),
            const ProductList(),
          ],
        )),
      ),
    );
  }
}