import 'package:farmer/constants/constants.dart';
import 'package:farmer/login/authapp.dart';
import 'package:farmer/view/cart/cart_provider.dart';
import 'package:farmer/view/entrypoint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

Widget defaultHome = MainScreen();

void main() {
  // runApp(const MyApp());

  runApp(AuthApp());
  runApp(
    ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Set the fit size (Find your UI design, look at the dimensions of the device screen and fill it in,unit in dp)
    return ScreenUtilInit(
      designSize: const Size(375, 825),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (contex , child) {
        return GetMaterialApp(

          title: 'Agri Mart',
          // You can use the library anywhere in the app even in theme
          theme: ThemeData(
           scaffoldBackgroundColor: kOffWhite,
            iconTheme: const IconThemeData(color: kDark),
            primarySwatch: Colors.grey
          ),
          home: defaultHome,
        );
      },

    );
  }
}

