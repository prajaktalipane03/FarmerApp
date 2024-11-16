import 'package:carousel_slider/carousel_slider.dart';
import 'package:farmer/constants/uidata.dart';
import 'package:farmer/view/home/widgets/supplier_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NearBySuppliers extends StatelessWidget {
  const NearBySuppliers({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 194.h,
      padding: EdgeInsets.only(left: 12.w, top: 10.h),
      child: CarouselSlider(
        options: CarouselOptions(
          height: 180.h, // Adjust the height of the carousel slider
          autoPlay: true, // Optional: enable autoplay
          enlargeCenterPage: true, // Optional: enlarge the center item
          scrollDirection: Axis.horizontal,
        ),
        items: List.generate(supplier.length, (i) {
          var supply = supplier[i];

          // Display Supplier Widget for each image in the slider
          return Builder(
            builder: (BuildContext context) {
              return SupplierWidget(
                image: supply['imageUrl'],
                logo: supply['logoUrl'],
                title: supply['title'],
                time: supply['time'],
                rating: supply['ratingCount'],
              );
            },
          );
        }),
      ),
    );
  }
}






// import 'package:farmer/constants/uidata.dart';
// import 'package:farmer/view/home/widgets/supplier_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// class NearBySuppliers extends StatelessWidget{
//   const NearBySuppliers ({super.key});
//   // var supply;
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Container(
//       height: 194.h,
//       padding: EdgeInsets.only(left: 12.w,top: 10.h),
//       child: ListView(
//         scrollDirection: Axis.horizontal,
//         children: List.generate(supplier.length, (i){
//            var supply = supplier[i];
//           return SupplierWidget(image: supply['imageUrl'],logo: supply['logoUrl'], title: supply['title'], time:supply ['time'], rating: supply['ratingCount'],);
//         }),
//       ),
//     );
//   }
// }