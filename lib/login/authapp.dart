import 'package:farmer/main.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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
  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Delivery Boy Animation
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.1),
              child: Container(
                height: screenHeight * 0.3,
                child: Lottie.asset(
                  'assets/anime/delivery.json', // Replace with your Lottie animation file
                  fit: BoxFit.contain,
                ),
              ),
            ),
            // Login and Signup Toggle
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
            // Form Section
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
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email, color: Color(0xff2df3ae)),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock, color: Color(0xff2df3ae)),
                    ),
                  ),
                  if (!isLogin) ...[
                    SizedBox(height: 15),
                    TextField(
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
                    onPressed: () {

                      // String action = isLogin ? 'Login' : 'Signup';
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   SnackBar(content: Text('$action Successful!')),
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const MyApp()),

                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff2df3ae),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 15,
                      ),
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
}




// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
//
// // void main() => runApp(AuthApp());
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
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xff2df3ae),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             // Delivery Boy Animation
//             Container(
//               height: 250,
//               child: Lottie.asset(
//                 'assets/anime/delivery.json', // Replace with your Lottie animation file
//                 fit: BoxFit.contain,
//               ),
//             ),
//             // Switch between Login and Signup
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 20),
//               child: Column(
//                 children: [
//                   // Login and Signup Toggle
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             isLogin = true;
//                           });
//                         },
//                         child: Text(
//                           "Login",
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: isLogin ? Colors.white : Colors.black45,
//                           ),
//                         ),
//                       ),
//                       SizedBox(width: 30),
//                       GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             isLogin = false;
//                           });
//                         },
//                         child: Text(
//                           "Signup",
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: !isLogin ? Colors.white : Colors.black45,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 20),
//                   // Form Section
//                   Container(
//                     padding: EdgeInsets.all(20),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(20),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black12,
//                           blurRadius: 10,
//                           offset: Offset(0, 5),
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       children: [
//                         TextField(
//                           decoration: InputDecoration(
//                             labelText: 'Email',
//                             border: OutlineInputBorder(),
//                             prefixIcon: Icon(Icons.email),
//                           ),
//                         ),
//                         SizedBox(height: 15),
//                         TextField(
//                           obscureText: true,
//                           decoration: InputDecoration(
//                             labelText: 'Password',
//                             border: OutlineInputBorder(),
//                             prefixIcon: Icon(Icons.lock),
//                           ),
//                         ),
//                         if (!isLogin) ...[
//                           SizedBox(height: 15),
//                           TextField(
//                             obscureText: true,
//                             decoration: InputDecoration(
//                               labelText: 'Confirm Password',
//                               border: OutlineInputBorder(),
//                               prefixIcon: Icon(Icons.lock),
//                             ),
//                           ),
//                         ],
//                         SizedBox(height: 20),
//                         ElevatedButton(
//                           onPressed: () {
//                             // Handle Login or Signup
//                             String action = isLogin ? 'Login' : 'Signup';
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(content: Text('$action Successful!')),
//                             );
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Color(0xff2df3ae),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             padding: EdgeInsets.symmetric(
//                               horizontal: 30,
//                               vertical: 15,
//                             ),
//                           ),
//                           child: Text(
//                             isLogin ? 'Login' : 'Signup',
//                             style: TextStyle(fontSize: 18, color: Colors.white),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }