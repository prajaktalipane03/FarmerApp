import 'package:farmer/constants/constants.dart';
import 'package:farmer/controllers/tab_index_controller.dart';
import 'package:farmer/view/cart/cart_page.dart';
import 'package:farmer/view/home/home_page.dart';
import 'package:farmer/view/profile/profile_page.dart';
import 'package:farmer/view/search/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:farmer/view/profile/profile_page.dart';

class MainScreen extends StatelessWidget {
   MainScreen({super.key});
List<Widget>pageList = [
  const HomePage(),
  const SearchPage(),
  const CartPage(),
  const ProfilePage(),
];
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TabIndexController());
    // TODO: implement build
    return Obx(() =>
        Scaffold(
          body: Stack(
            children: [
              pageList[controller.tabIndex],
              Align(
                alignment: Alignment.bottomCenter,
                child: Theme(
                    data: Theme.of(context).copyWith(canvasColor: kPrimary),
                    child: BottomNavigationBar(
                        showSelectedLabels: false,
                        showUnselectedLabels: false,
                        unselectedIconTheme: const IconThemeData(
                            color: Colors.black38),
                        selectedIconTheme: IconThemeData(color: kSecondary),
                        onTap: (value) {
                          controller.settabIndex = value;
                        },
                        currentIndex: controller.tabIndex,
                        items:[
                          BottomNavigationBarItem(
                              icon: controller.tabIndex==0 ? const Icon(FontAwesome.home) : const Icon(AntDesign.home), label: 'Home'),
                          const BottomNavigationBarItem(
                              icon: Icon(Icons.search), label: 'Search'),
                          const BottomNavigationBarItem(
                              icon: Badge(label: Text('1'),child: Icon(AntDesign.shoppingcart)), label: 'Cart'),
                          BottomNavigationBarItem(
                              icon: controller.tabIndex==3 ? const Icon(FontAwesome.user_circle) : Icon(FontAwesome.user_circle_o), label: 'Profile'),
                        ])),
              ),
            ],
          ),
        ));
  }
}