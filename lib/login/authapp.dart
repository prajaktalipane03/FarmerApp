import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../Admin/DeliveryPersonHomePage.dart';
import '../Admin/FoodlyAdminPanel.dart';
import '../Admin/HotelHomePage.dart';
import '../view/home/home_page.dart';

class AuthApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login & Signup',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: AuthScreen(),
    );
  }
}

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true; // Toggle for login or signup
  String? selectedRole; // Role selected during signup
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Available roles for selection during signup
  final List<String> roles = ['User', 'Admin', 'Hotel', 'Delivery Person'];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Lottie Animation
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.1),
              child: Container(
                height: screenHeight * 0.3,
                child: Lottie.asset(
                  'assets/anime/delivery.json', // Add your animation file
                  fit: BoxFit.contain,
                ),
              ),
            ),
            // Login/Signup Toggle
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isLogin = true;
                    });
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isLogin ? Color(0xff2df3ae) : Colors.grey,
                    ),
                  ),
                ),
                SizedBox(width: 30),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isLogin = false;
                    });
                  },
                  child: Text(
                    "Signup",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: !isLogin ? Color(0xff2df3ae) : Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Form
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email, color: Color(0xff2df3ae)),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock, color: Color(0xff2df3ae)),
                    ),
                  ),
                  if (!isLogin) ...[
                    SizedBox(height: 15),
                    DropdownButtonFormField<String>(
                      value: selectedRole,
                      hint: Text('Select Role'),
                      items: roles.map((role) => DropdownMenuItem<String>(
                        value: role,
                        child: Text(role),
                      )).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedRole = value;
                        });
                      },
                      decoration: InputDecoration(border: OutlineInputBorder()),
                    ),
                    SizedBox(height: 15),
                    TextField(
                      controller: confirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.lock, color: Color(0xff2df3ae)),
                      ),
                    ),
                  ],
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      if (isLogin) {
                        await loginUser();
                      } else {
                        await registerUser();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff2df3ae),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    ),
                    child: Text(
                      isLogin ? 'Login' : 'Signup',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      if (userDoc.exists) {
        final roles = userDoc['roles'];

        if (roles['admin'] == true) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => FoodlyAdminPanel()),
          );
        } else if (roles['hotel'] == true) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HotelHomePage()),
          );
        } else if (roles['delivery_person'] == true) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => DeliveryPersonHomePage()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        }
      }
    } catch (e) {
      print("Error during login: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login Failed: ${e.toString()}')),
      );
    }
  }

  Future<void> registerUser() async {
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    if (selectedRole == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a role')),
      );
      return;
    }

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
        'email': emailController.text.trim(),
        'roles': {
          'admin': selectedRole == 'Admin',
          'user': selectedRole == 'User',
          'hotel': selectedRole == 'Hotel',
          'delivery_person': selectedRole == 'Delivery Person',
        },
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } catch (e) {
      print("Error during registration: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration Failed: ${e.toString()}')),
      );
    }
  }
}






// import 'package:farmer/main.dart';
// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// import '../Admin/DeliveryPersonHomePage.dart';
// import '../Admin/FoodlyAdminPanel.dart';
// import '../Admin/HotelHomePage.dart';
// import '../view/home/home_page.dart';
//
// class AuthApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Login & Signup',
//       theme: ThemeData(
//         primarySwatch: Colors.green,
//       ),
//       home: AuthScreen(),
//     );
//   }
// }
//
// class AuthScreen extends StatefulWidget {
//   @override
//   _AuthScreenState createState() => _AuthScreenState();
// }
//
// class _AuthScreenState extends State<AuthScreen> {
//   bool isLogin = true;
//   String? selectedRole;
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   final confirmPasswordController = TextEditingController();
//
//   // List of roles
//   final List<String> roles = ['User', 'Admin', 'Hotel', 'Delivery Person'];
//
//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             // Delivery Boy Animation
//             Padding(
//               padding: EdgeInsets.only(top: screenHeight * 0.1),
//               child: Container(
//                 height: screenHeight * 0.3,
//                 child: Lottie.asset(
//                   'assets/anime/delivery.json', // Replace with your Lottie animation file
//                   fit: BoxFit.contain,
//                 ),
//               ),
//             ),
//             // Login and Signup Toggle
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       isLogin = true;
//                     });
//                   },
//                   child: Text(
//                     "Login",
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: isLogin ? Color(0xff2df3ae) : Colors.grey,
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 30),
//                 GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       isLogin = false;
//                     });
//                   },
//                   child: Text(
//                     "Signup",
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: !isLogin ? Color(0xff2df3ae) : Colors.grey,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 20),
//             // Form Section
//             Container(
//               margin: EdgeInsets.symmetric(horizontal: 20),
//               padding: EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(20),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black12,
//                     blurRadius: 10,
//                     offset: Offset(0, 5),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 children: [
//                   TextField(
//                     controller: emailController,
//                     decoration: InputDecoration(
//                       labelText: 'Email',
//                       border: OutlineInputBorder(),
//                       prefixIcon:
//                       Icon(Icons.email, color: Color(0xff2df3ae)),
//                     ),
//                   ),
//                   SizedBox(height: 15),
//                   TextField(
//                     controller: passwordController,
//                     obscureText: true,
//                     decoration: InputDecoration(
//                       labelText: 'Password',
//                       border: OutlineInputBorder(),
//                       prefixIcon:
//                       Icon(Icons.lock, color: Color(0xff2df3ae)),
//                     ),
//                   ),
//                   if (!isLogin) ...[
//                     SizedBox(height: 15),
//                     DropdownButtonFormField<String>(
//                       value: selectedRole,
//                       hint: Text('Select Role'),
//                       items:
//                       roles.map((role) => DropdownMenuItem<String>(
//                         value: role,
//                         child: Text(role),
//                       )).toList(),
//                       onChanged: (value) {
//                         setState(() {
//                           selectedRole = value;
//                         });
//                       },
//                       decoration:
//                       InputDecoration(border:
//                       OutlineInputBorder()),
//                     ),
//                     SizedBox(height: 15),
//                     TextField(
//                       controller:
//                       confirmPasswordController,
//                       obscureText:
//                       true,
//                       decoration:
//                       InputDecoration(
//                         labelText:
//                         'Confirm Password',
//                         border:
//                         OutlineInputBorder(),
//                         prefixIcon:
//                         Icon(Icons.lock, color:
//                         Color(0xff2df3ae)),
//                       ),
//                     ),
//                   ],
//                   SizedBox(height:
//                   20),
//                   ElevatedButton(
//                     onPressed:
//                         () async {
//                       if (isLogin) {
//                         await loginUser();
//                       } else {
//                         await registerUser();
//                       }
//                     },
//                     style:
//                     ElevatedButton.styleFrom(
//                       backgroundColor:
//                       Color(0xff2df3ae),
//                       shape:
//                       RoundedRectangleBorder(
//                         borderRadius:
//                         BorderRadius.circular(10),
//                       ),
//                       padding:
//                       EdgeInsets.symmetric(horizontal:
//                       30, vertical:
//                       15),
//                     ),
//                     child:
//                     Text(isLogin ? 'Login' : 'Signup',
//                         style:
//                         TextStyle(fontSize:
//                         18, color:
//                         Colors.white)),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Future<void> loginUser() async {
//     try {
//       UserCredential userCredential =
//       await FirebaseAuth.instance.signInWithEmailAndPassword(
//         email:
//         emailController.text.trim(),
//         password:
//         passwordController.text.trim(),
//       );
//
//       // Fetch user role from Firestore
//       DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).get();
//       String role = userDoc['roles'].keys.firstWhere((k) => userDoc['roles'][k] == true);
//
//       // Navigate to home based on user role
//       if (role == 'admin') {
//         Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => FoodlyAdminPanel())); // Replace with your Admin home page widget
//       } else if (role == 'hotel') {
//         Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => HotelHomePage())); // Replace with your Hotel home page widget
//       } else if (role == 'delivery_person') {
//         Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => DeliveryPersonHomePage())); // Replace with your Delivery Person home page widget
//       } else {
//         Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => HomePage())); // Default user home page
//       }
//     } catch (e) {
//       print(e);
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:
//       Text('Login Failed')));
//     }
//   }
//
//   Future<void> registerUser() async {
//     if (passwordController.text != confirmPasswordController.text) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:
//       Text('Passwords do not match')));
//       return;
//     }
//
//     try {
//       UserCredential userCredential =
//       await FirebaseAuth.instance.createUserWithEmailAndPassword(
//         email:
//         emailController.text.trim(),
//         password:
//         passwordController.text.trim(),
//       );
//
//       // Create a document in Firestore with user role
//       await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
//         'email': emailController.text.trim(),
//         'roles': {
//           'admin': selectedRole == 'Admin',
//           'user': selectedRole == 'User',
//           'hotel': selectedRole == 'Hotel',
//           'delivery_person': selectedRole == 'Delivery Person',
//         },
//       });
//
//       Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => MyApp()));
//     } catch (e) {
//       print(e);
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:
//       Text('Registration Failed')));
//     }
//   }
// }
//
//
//
//
//
// // import 'package:farmer/main.dart';
// // import 'package:flutter/material.dart';
// // import 'package:lottie/lottie.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// //
// // class AuthApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Login & Signup',
// //       theme: ThemeData(
// //         primarySwatch: Colors.green,
// //       ),
// //       home: AuthScreen(),
// //     );
// //   }
// // }
// //
// // class AuthScreen extends StatefulWidget {
// //   @override
// //   _AuthScreenState createState() => _AuthScreenState();
// // }
// //
// // class _AuthScreenState extends State<AuthScreen> {
// //   bool isLogin = true;
// //   String? selectedRole;
// //   final emailController = TextEditingController();
// //   final passwordController = TextEditingController();
// //   final confirmPasswordController = TextEditingController();
// //
// //   // List of roles
// //   final List<String> roles = ['User', 'Admin', 'Hotel', 'Delivery Person'];
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final screenHeight = MediaQuery.of(context).size.height;
// //
// //     return Scaffold(
// //       backgroundColor: Colors.white,
// //       body: SingleChildScrollView(
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.center,
// //           children: [
// //             // Delivery Boy Animation
// //             Padding(
// //               padding: EdgeInsets.only(top: screenHeight * 0.1),
// //               child: Container(
// //                 height: screenHeight * 0.3,
// //                 child: Lottie.asset(
// //                   'assets/anime/delivery.json', // Replace with your Lottie animation file
// //                   fit: BoxFit.contain,
// //                 ),
// //               ),
// //             ),
// //             // Login and Signup Toggle
// //             Row(
// //               mainAxisAlignment: MainAxisAlignment.center,
// //               children: [
// //                 GestureDetector(
// //                   onTap: () {
// //                     setState(() {
// //                       isLogin = true;
// //                     });
// //                   },
// //                   child: Text(
// //                     "Login",
// //                     style: TextStyle(
// //                       fontSize: 20,
// //                       fontWeight: FontWeight.bold,
// //                       color: isLogin ? Color(0xff2df3ae) : Colors.grey,
// //                     ),
// //                   ),
// //                 ),
// //                 SizedBox(width: 30),
// //                 GestureDetector(
// //                   onTap: () {
// //                     setState(() {
// //                       isLogin = false;
// //                     });
// //                   },
// //                   child: Text(
// //                     "Signup",
// //                     style: TextStyle(
// //                       fontSize: 20,
// //                       fontWeight: FontWeight.bold,
// //                       color: !isLogin ? Color(0xff2df3ae) : Colors.grey,
// //                     ),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //             SizedBox(height: 20),
// //             // Form Section
// //             Container(
// //               margin: EdgeInsets.symmetric(horizontal: 20),
// //               padding: EdgeInsets.all(20),
// //               decoration: BoxDecoration(
// //                 color: Colors.white,
// //                 borderRadius: BorderRadius.circular(20),
// //                 boxShadow: [
// //                   BoxShadow(
// //                     color: Colors.black12,
// //                     blurRadius: 10,
// //                     offset: Offset(0, 5),
// //                   ),
// //                 ],
// //               ),
// //               child: Column(
// //                 children: [
// //                   TextField(
// //                     controller: emailController,
// //                     decoration: InputDecoration(
// //                       labelText: 'Email',
// //                       border: OutlineInputBorder(
// //                         borderRadius: BorderRadius.circular(10), // Set border radius here
// //                         borderSide:
// //                         BorderSide(color: Colors.grey), // Border color for normal state
// //                       ),
// //                       prefixIcon:
// //                       Icon(Icons.email, color: Color(0xff2df3ae)),
// //                     ),
// //                   ),
// //                   SizedBox(height: 15),
// //                   TextField(
// //                     controller: passwordController,
// //                     obscureText: true,
// //                     decoration: InputDecoration(
// //                       labelText: 'Password',
// //                       border: OutlineInputBorder(
// //                         borderRadius: BorderRadius.circular(10), // Set border radius here
// //                         borderSide:
// //                         BorderSide(color: Colors.grey), // Border color for normal state
// //                       ),
// //                       prefixIcon:
// //                       Icon(Icons.lock, color: Color(0xff2df3ae)),
// //                     ),
// //                   ),
// //                   if (!isLogin) ...[
// //                     SizedBox(height: 15),
// //                     DropdownButtonFormField<String>(
// //                       value: selectedRole,
// //                       hint: Text('Select Role'),
// //                       items:
// //                       roles.map((role) => DropdownMenuItem<String>(
// //                         value: role,
// //                         child: Text(role),
// //                       )).toList(),
// //                       onChanged: (value) {
// //                         setState(() {
// //                           selectedRole = value;
// //                         });
// //                       },
// //                       decoration:
// //                       InputDecoration(
// //                         border:
// //                         OutlineInputBorder(borderRadius:
// //                         BorderRadius.circular(10),
// //                             borderSide:
// //                             BorderSide(color:
// //                             Colors.grey)), // Correctly set border with radius
// //                       ),
// //                     ),
// //                     SizedBox(height: 15),
// //                     TextField(
// //                       controller:
// //                       confirmPasswordController,
// //                       obscureText:
// //                       true,
// //                       decoration:
// //                       InputDecoration(
// //                         labelText:
// //                         'Confirm Password',
// //                         border:
// //                         OutlineInputBorder(borderRadius:
// //                         BorderRadius.circular(10),
// //                             borderSide:
// //                             BorderSide(color:
// //                             Colors.grey)), // Set border radius here
// //                         prefixIcon:
// //                         Icon(Icons.lock, color:
// //                         Color(0xff2df3ae)),
// //                       ),
// //                     ),
// //                   ],
// //                   SizedBox(height:
// //                   20),
// //                   ElevatedButton(
// //                     onPressed:
// //                         () async {
// //                       if (isLogin) {
// //                         await loginUser();
// //                       } else {
// //                         await registerUser();
// //                       }
// //                     },
// //                     style:
// //                     ElevatedButton.styleFrom(
// //                       backgroundColor:
// //                       Color(0xff2df3ae),
// //                       shape:
// //                       RoundedRectangleBorder(
// //                         borderRadius:
// //                         BorderRadius.circular(10),
// //                       ),
// //                       padding:
// //                       EdgeInsets.symmetric(horizontal:
// //                       30, vertical:
// //                       15),
// //                     ),
// //                     child:
// //                     Text(isLogin ? 'Login' : 'Signup',
// //                         style:
// //                         TextStyle(fontSize:
// //                         18, color:
// //                         Colors.white)),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Future<void> loginUser() async {
// //     try {
// //       UserCredential userCredential =
// //       await FirebaseAuth.instance.signInWithEmailAndPassword(
// //         email:
// //         emailController.text.trim(),
// //         password:
// //         passwordController.text.trim(),
// //       );
// //       // Navigate to home based on user role
// //       Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => MyApp()));
// //     } catch (e) {
// //       print(e);
// //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:
// //       Text('Login Failed')));
// //     }
// //   }
// //
// //   Future<void> registerUser() async {
// //     if (passwordController.text != confirmPasswordController.text) {
// //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:
// //       Text('Passwords do not match')));
// //       return;
// //     }
// //
// //     try {
// //       UserCredential userCredential =
// //       await FirebaseAuth.instance.createUserWithEmailAndPassword(
// //         email:
// //         emailController.text.trim(),
// //         password:
// //         passwordController.text.trim(),
// //       );
// //
// //       // Create a document in Firestore with user role
// //       await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
// //         'email': emailController.text.trim(),
// //         'roles': {
// //           'admin': selectedRole == 'Admin',
// //           'user': selectedRole == 'User',
// //           'hotel': selectedRole == 'Hotel',
// //           'delivery_person': selectedRole == 'Delivery Person',
// //         },
// //       });
// //
// //       Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => MyApp()));
// //     } catch (e) {
// //       print(e);
// //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:
// //       Text('Registration Failed')));
// //     }
// //   }
// // }
//
//
//
//
//
//
// // import 'package:farmer/main.dart';
// // import 'package:flutter/material.dart';
// // import 'package:lottie/lottie.dart';
// //
// // class AuthApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Login & Signup',
// //       theme: ThemeData(
// //         primarySwatch: Colors.green,
// //       ),
// //       home: AuthScreen(),
// //     );
// //   }
// // }
// //
// // class AuthScreen extends StatefulWidget {
// //   @override
// //   _AuthScreenState createState() => _AuthScreenState();
// // }
// //
// // class _AuthScreenState extends State<AuthScreen> {
// //   bool isLogin = true;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final screenHeight = MediaQuery.of(context).size.height;
// //
// //     return Scaffold(
// //       backgroundColor: Colors.white,
// //       body: SingleChildScrollView(
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.center,
// //           children: [
// //             // Delivery Boy Animation
// //             Padding(
// //               padding: EdgeInsets.only(top: screenHeight * 0.1),
// //               child: Container(
// //                 height: screenHeight * 0.3,
// //                 child: Lottie.asset(
// //                   'assets/anime/delivery.json', // Replace with your Lottie animation file
// //                   fit: BoxFit.contain,
// //                 ),
// //               ),
// //             ),
// //             // Login and Signup Toggle
// //             Row(
// //               mainAxisAlignment: MainAxisAlignment.center,
// //               children: [
// //                 GestureDetector(
// //                   onTap: () {
// //                     setState(() {
// //                       isLogin = true;
// //                     });
// //                   },
// //                   child: Text(
// //                     "Login",
// //                     style: TextStyle(
// //                       fontSize: 20,
// //                       fontWeight: FontWeight.bold,
// //                       color: isLogin ? Color(0xff2df3ae) : Colors.grey,
// //                     ),
// //                   ),
// //                 ),
// //                 SizedBox(width: 30),
// //                 GestureDetector(
// //                   onTap: () {
// //                     setState(() {
// //                       isLogin = false;
// //                     });
// //                   },
// //                   child: Text(
// //                     "Signup",
// //                     style: TextStyle(
// //                       fontSize: 20,
// //                       fontWeight: FontWeight.bold,
// //                       color: !isLogin ? Color(0xff2df3ae) : Colors.grey,
// //                     ),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //             SizedBox(height: 20),
// //             // Form Section
// //             Container(
// //               margin: EdgeInsets.symmetric(horizontal: 20),
// //               padding: EdgeInsets.all(20),
// //               decoration: BoxDecoration(
// //                 color: Colors.white,
// //                 borderRadius: BorderRadius.circular(20),
// //                 boxShadow: [
// //                   BoxShadow(
// //                     color: Colors.black12,
// //                     blurRadius: 10,
// //                     offset: Offset(0, 5),
// //                   ),
// //                 ],
// //               ),
// //               child: Column(
// //                 children: [
// //                   TextField(
// //                     decoration: InputDecoration(
// //                       labelText: 'Email',
// //                       border: OutlineInputBorder(),
// //                       prefixIcon: Icon(Icons.email, color: Color(0xff2df3ae)),
// //                     ),
// //                   ),
// //                   SizedBox(height: 15),
// //                   TextField(
// //                     obscureText: true,
// //                     decoration: InputDecoration(
// //                       labelText: 'Password',
// //                       border: OutlineInputBorder(),
// //                       prefixIcon: Icon(Icons.lock, color: Color(0xff2df3ae)),
// //                     ),
// //                   ),
// //                   if (!isLogin) ...[
// //                     SizedBox(height: 15),
// //                     TextField(
// //                       obscureText: true,
// //                       decoration: InputDecoration(
// //                         labelText: 'Confirm Password',
// //                         border: OutlineInputBorder(),
// //                         prefixIcon: Icon(Icons.lock, color: Color(0xff2df3ae)),
// //                       ),
// //                     ),
// //                   ],
// //                   SizedBox(height: 20),
// //                   ElevatedButton(
// //                     onPressed: () {
// //
// //                       // String action = isLogin ? 'Login' : 'Signup';
// //                       // ScaffoldMessenger.of(context).showSnackBar(
// //                       //   SnackBar(content: Text('$action Successful!')),
// //                           Navigator.push(
// //                             context,
// //                             MaterialPageRoute(builder: (context) => const MyApp()),
// //
// //                       );
// //                     },
// //                     style: ElevatedButton.styleFrom(
// //                       backgroundColor: Color(0xff2df3ae),
// //                       shape: RoundedRectangleBorder(
// //                         borderRadius: BorderRadius.circular(10),
// //                       ),
// //                       padding: EdgeInsets.symmetric(
// //                         horizontal: 30,
// //                         vertical: 15,
// //                       ),
// //                     ),
// //                     child: Text(
// //                       isLogin ? 'Login' : 'Signup',
// //                       style: TextStyle(fontSize: 18, color: Colors.white),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
//
//
//
//
// // import 'package:flutter/material.dart';
// // import 'package:lottie/lottie.dart';
// //
// // // void main() => runApp(AuthApp());
// //
// // class AuthApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Login & Signup',
// //       theme: ThemeData(
// //         primarySwatch: Colors.green,
// //       ),
// //       home: AuthScreen(),
// //     );
// //   }
// // }
// //
// // class AuthScreen extends StatefulWidget {
// //   @override
// //   _AuthScreenState createState() => _AuthScreenState();
// // }
// //
// // class _AuthScreenState extends State<AuthScreen> {
// //   bool isLogin = true;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Color(0xff2df3ae),
// //       body: SingleChildScrollView(
// //         child: Column(
// //           children: [
// //             // Delivery Boy Animation
// //             Container(
// //               height: 250,
// //               child: Lottie.asset(
// //                 'assets/anime/delivery.json', // Replace with your Lottie animation file
// //                 fit: BoxFit.contain,
// //               ),
// //             ),
// //             // Switch between Login and Signup
// //             Container(
// //               padding: EdgeInsets.symmetric(horizontal: 20),
// //               child: Column(
// //                 children: [
// //                   // Login and Signup Toggle
// //                   Row(
// //                     mainAxisAlignment: MainAxisAlignment.center,
// //                     children: [
// //                       GestureDetector(
// //                         onTap: () {
// //                           setState(() {
// //                             isLogin = true;
// //                           });
// //                         },
// //                         child: Text(
// //                           "Login",
// //                           style: TextStyle(
// //                             fontSize: 20,
// //                             fontWeight: FontWeight.bold,
// //                             color: isLogin ? Colors.white : Colors.black45,
// //                           ),
// //                         ),
// //                       ),
// //                       SizedBox(width: 30),
// //                       GestureDetector(
// //                         onTap: () {
// //                           setState(() {
// //                             isLogin = false;
// //                           });
// //                         },
// //                         child: Text(
// //                           "Signup",
// //                           style: TextStyle(
// //                             fontSize: 20,
// //                             fontWeight: FontWeight.bold,
// //                             color: !isLogin ? Colors.white : Colors.black45,
// //                           ),
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                   SizedBox(height: 20),
// //                   // Form Section
// //                   Container(
// //                     padding: EdgeInsets.all(20),
// //                     decoration: BoxDecoration(
// //                       color: Colors.white,
// //                       borderRadius: BorderRadius.circular(20),
// //                       boxShadow: [
// //                         BoxShadow(
// //                           color: Colors.black12,
// //                           blurRadius: 10,
// //                           offset: Offset(0, 5),
// //                         ),
// //                       ],
// //                     ),
// //                     child: Column(
// //                       children: [
// //                         TextField(
// //                           decoration: InputDecoration(
// //                             labelText: 'Email',
// //                             border: OutlineInputBorder(),
// //                             prefixIcon: Icon(Icons.email),
// //                           ),
// //                         ),
// //                         SizedBox(height: 15),
// //                         TextField(
// //                           obscureText: true,
// //                           decoration: InputDecoration(
// //                             labelText: 'Password',
// //                             border: OutlineInputBorder(),
// //                             prefixIcon: Icon(Icons.lock),
// //                           ),
// //                         ),
// //                         if (!isLogin) ...[
// //                           SizedBox(height: 15),
// //                           TextField(
// //                             obscureText: true,
// //                             decoration: InputDecoration(
// //                               labelText: 'Confirm Password',
// //                               border: OutlineInputBorder(),
// //                               prefixIcon: Icon(Icons.lock),
// //                             ),
// //                           ),
// //                         ],
// //                         SizedBox(height: 20),
// //                         ElevatedButton(
// //                           onPressed: () {
// //                             // Handle Login or Signup
// //                             String action = isLogin ? 'Login' : 'Signup';
// //                             ScaffoldMessenger.of(context).showSnackBar(
// //                               SnackBar(content: Text('$action Successful!')),
// //                             );
// //                           },
// //                           style: ElevatedButton.styleFrom(
// //                             backgroundColor: Color(0xff2df3ae),
// //                             shape: RoundedRectangleBorder(
// //                               borderRadius: BorderRadius.circular(10),
// //                             ),
// //                             padding: EdgeInsets.symmetric(
// //                               horizontal: 30,
// //                               vertical: 15,
// //                             ),
// //                           ),
// //                           child: Text(
// //                             isLogin ? 'Login' : 'Signup',
// //                             style: TextStyle(fontSize: 18, color: Colors.white),
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }