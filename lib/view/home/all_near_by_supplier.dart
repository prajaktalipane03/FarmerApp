import 'package:farmer/common/app_style.dart';
import 'package:farmer/common/reusable_text.dart';
import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class AllNearBySupplier extends StatelessWidget{
  const AllNearBySupplier ({super.key});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        elevation: 0.3,
        backgroundColor: kOffWhite,
        title: ReusableText(text:"All Near by Suppliers",
          style: appStyle(13, kDark, FontWeight.w600),),
      ),
      body: const Center(
        child: Text("All Near by Suppliers"),
      ),
    );
  }
}