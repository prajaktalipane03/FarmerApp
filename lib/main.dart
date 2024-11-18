import 'package:farmer/constants/constants.dart';
import 'package:farmer/login/authapp.dart';
import 'package:farmer/view/home/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'Admin/DeliveryPersonHomePage.dart';
import 'Admin/ErrorScreen.dart';
import 'Admin/FoodlyAdminPanel.dart';
import 'Admin/HotelHomePage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(options: FirebaseOptions(apiKey: "AIzaSyAfcyNm5rVl4NcmvAJU94e4ryS2zMOw6hI",
        authDomain: "farmersapp-3b75b.firebaseapp.com",
        projectId: "farmersapp-3b75b",
        storageBucket: "farmersapp-3b75b.firebasestorage.app",
        messagingSenderId: "586216028325",
        appId: "1:586216028325:web:e3f656646b785716bc754c",
        measurementId: "G-PPHGF566RQ"));
  } catch (e) {
    print("Error initializing Firebase: $e");
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 825),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Agri Mart',
          theme: ThemeData(
            scaffoldBackgroundColor: kOffWhite,
            iconTheme: const IconThemeData(color: kDark),
            primarySwatch: Colors.grey,
          ),
          home: const DefaultHome(),
        );
      },
    );
  }
}

class DefaultHome extends StatelessWidget {
  const DefaultHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
          return UserRoleHomePage(userId: snapshot.data!.uid);
        } else {
          return AuthApp(); // Login page
        }
      },
    );
  }
}

class UserRoleHomePage extends StatelessWidget {
  final String userId;

  const UserRoleHomePage({required this.userId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('users').doc(userId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError || snapshot.data == null || !snapshot.data!.exists) {
          return ErrorScreen(); // Error handling screen
        }

        var userData = snapshot.data!.data() as Map<String, dynamic>;
        final roles = userData['roles'];

        if (roles['admin'] == true) {
          return FoodlyAdminPanel(); // Admin Panel
        } else if (roles['hotel'] == true) {
          return HotelHomePage(); // Hotel Home
        } else if (roles['delivery_person'] == true) {
          return DeliveryPersonHomePage(); // Delivery Person
        } else {
          return HomePage(); // Default User Home
        }
      },
    );
  }
}





// import 'package:farmer/constants/constants.dart';
// import 'package:farmer/login/authapp.dart';
// import 'package:farmer/view/entrypoint.dart';
// import 'package:farmer/view/home/home_page.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// import 'Admin/DeliveryPersonHomePage.dart';
// import 'Admin/ErrorScreen.dart';
// import 'Admin/FoodlyAdminPanel.dart';
// import 'Admin/HotelHomePage.dart';
//
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(AuthApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//       designSize: const Size(375, 825),
//       minTextAdapt: true,
//       splitScreenMode: true,
//       builder: (context, child) {
//         return GetMaterialApp(
//           debugShowCheckedModeBanner: false,
//           title: 'Agri Mart',
//           theme: ThemeData(
//             scaffoldBackgroundColor: kOffWhite,
//             iconTheme: const IconThemeData(color: kDark),
//             primarySwatch: Colors.grey,
//           ),
//           home: DefaultHome(),
//         );
//       },
//     );
//   }
// }
//
// class DefaultHome extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<User?>(
//       stream: FirebaseAuth.instance.authStateChanges(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         }
//         if (snapshot.hasData) {
//           // User is logged in, fetch their role
//           return UserRoleHomePage(userId: snapshot.data!.uid);
//         } else {
//           // User is not logged in, show login page
//           return AuthApp(); // Assuming AuthApp is your login page
//         }
//       },
//     );
//   }
// }
//
// class UserRoleHomePage extends StatelessWidget {
//   final String userId;
//
//   UserRoleHomePage({required this.userId});
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<DocumentSnapshot>(
//       future: FirebaseFirestore.instance.collection('users').doc(userId).get(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         }
//         if (snapshot.hasError || !snapshot.data!.exists) {
//           return ErrorScreen(); // Handle error or non-existing user
//         }
//
//         var userData = snapshot.data!.data() as Map<String, dynamic>;
//
//         // Determine the user's role and navigate accordingly
//         if (userData['roles']['admin'] == true) {
//           return FoodlyAdminPanel(); // Replace with your actual Admin home page widget
//         } else if (userData['roles']['hotel'] == true) {
//           return HotelHomePage(); // Replace with your actual Hotel home page widget
//         } else if (userData['roles']['delivery_person'] == true) {
//           return DeliveryPersonHomePage(); // Replace with your actual Delivery Person home page widget
//         } else {
//           return HomePage(); // Default user home page
//         }
//       },
//     );
//   }
// }
//
//
//


// import 'package:farmer/constants/constants.dart';
// import 'package:farmer/login/authapp.dart';
// import 'package:farmer/view/entrypoint.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
//
// Widget defaultHome = MainScreen();
//
// Future<void> main() async {
//   // runApp(const MyApp());
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//
//   runApp(AuthApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     //Set the fit size (Find your UI design, look at the dimensions of the device screen and fill it in,unit in dp)
//     return ScreenUtilInit(
//       designSize: const Size(375, 825),
//       minTextAdapt: true,
//       splitScreenMode: true,
//       // Use builder only if you need to use library outside ScreenUtilInit context
//       builder: (contex , child) {
//         return GetMaterialApp(
//           debugShowCheckedModeBanner: false,
//           title: 'Agri Mart',
//           // You can use the library anywhere in the app even in theme
//           theme: ThemeData(
//            scaffoldBackgroundColor: kOffWhite,
//             iconTheme: const IconThemeData(color: kDark),
//             primarySwatch: Colors.grey
//           ),
//           home: defaultHome,
//         );
//       },
//
//     );
//   }
// }
//
