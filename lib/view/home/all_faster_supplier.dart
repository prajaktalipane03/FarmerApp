import 'package:farmer/common/app_style.dart';
import 'package:farmer/constants/constants.dart';
import 'package:flutter/material.dart';

import '../../common/reusable_text.dart';

class AllFastestSupplier extends StatelessWidget{
  const AllFastestSupplier ({super.key});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        elevation: 0.3,
        backgroundColor: kOffWhite,
        title: ReusableText(text:"All Fastest Suppliers Closer to you",
        style: appStyle(13, kDark, FontWeight.w600),),
      ),
      body: const Center(
        child: Text("All Near by Suppliers"),
      ),
    );
  }
}