import 'package:flutter/material.dart';

// void main() => runApp(ProfileApp());

class ProfileApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile Page',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2df3ae),
      appBar: AppBar(
        backgroundColor: Color(0xff2df3ae),
        elevation: 0,
        title: Text('Profile', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // User Image Section
          CircleAvatar(
            radius: 60,
            backgroundImage: AssetImage('assets/user_image.png'), // Replace with actual image
            backgroundColor: Colors.white,
          ),
          SizedBox(height: 10),
          // User Name
          Text(
            'John Doe',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 30),
          // Profile Options
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: ListView(
                children: [
                  profileOption(
                    context,
                    icon: Icons.shopping_bag,
                    title: 'Orders',
                  ),
                  profileOption(
                    context,
                    icon: Icons.help_center,
                    title: 'Help Center',
                  ),
                  profileOption(
                    context,
                    icon: Icons.settings,
                    title: 'Settings',
                  ),
                  profileOption(
                    context,
                    icon: Icons.logout,
                    title: 'Log Out',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget profileOption(BuildContext context, {required IconData icon, required String title}) {
    return GestureDetector(
      onTap: () {
        // Add functionality here
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$title Clicked')));
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Color(0xff2df3ae), width: 2),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Color(0xff2df3ae).withOpacity(0.5),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Color(0xff2df3ae)),
            SizedBox(width: 20),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}



// import 'dart:math';
//
// import 'package:farmer/common/custom_container.dart';
// import 'package:farmer/constants/constants.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// class ProfilePage extends StatelessWidget{
//   const ProfilePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Scaffold(
//       backgroundColor: kPrimary,
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(130.h), child: Container(height: 130),
//       ),
//       body:SafeArea(child: CustomContainer(containerContent: Container()),
//       ),
//     );
//   }
//  }