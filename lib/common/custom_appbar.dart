import 'package:farmer/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


// Define appStyle function
TextStyle appStyle(double fontSize, Color color, FontWeight fontWeight) {
  return TextStyle(
    fontSize: fontSize,
    color: color,
    fontWeight: fontWeight,
  );
}

// ReusableText Widget
class ReusableText extends StatelessWidget {
  final String text;
  final TextStyle style;

  const ReusableText({required this.text, required this.style, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
    );
  }
}

// CustomAppBar Widget
class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen width for responsive layout
    double width = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      height: 110.h,
      width: width,
      color: kOffWhite,
      child: Container(
        margin: EdgeInsets.only(top: 20.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CircleAvatar(
                  radius: 23.r,
                  backgroundColor: kSecondary,
                  backgroundImage: const NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ4YreOWfDX3kK-QLAbAL4ufCPc84ol2MA8Xg&s'),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 6.h, left: 8.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReusableText(
                        text: "Deliver to",
                        style: appStyle(15, kSecondary, FontWeight.w600),
                      ),
                      SizedBox(
                        width: width * 0.65,
                        child: Text(
                          "PWD Qtr No 7, Padampur, Aurangabad.",
                          overflow: TextOverflow.ellipsis,
                          style: appStyle(14, kDark, FontWeight.normal),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Time of day icon
            Text(
              getTimeOfDay(),
              style: appStyle(35, kSecondary, FontWeight.normal), // Adjust styling as needed
            ),
          ],
        ),
      ),
    );
  }
}

// Function to return time-based emoji
String getTimeOfDay() {
  DateTime now = DateTime.now();
  int hour = now.hour;

  if (hour >= 6 && hour < 12) {
    return ' ️☀️ '; // Morning
  } else if (hour >= 12 && hour < 18) {
    return ' 🌥️ '; // Afternoon
  } else {
    return ' 🌙 '; // Night
  }
}
