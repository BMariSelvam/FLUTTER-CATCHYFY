import 'package:Catchyfive/Const/colors.dart';
import 'package:Catchyfive/View/categories/categories_screen.dart';
import 'package:Catchyfive/View/dashboard/dashboard_screen.dart';
import 'package:Catchyfive/View/favourite/favourite_screen.dart';
import 'package:Catchyfive/View/setting/setting_screen.dart';
import 'package:flutter/material.dart';

import '../Const/assets.dart';

class BottomNavBar extends StatefulWidget {
  int? intex;

  BottomNavBar({
    this.intex = 0,
    Key? key,
  }) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  onItemTapped(int index) {
    print(index);
    print(widget.intex);
    setState(() {
      widget.intex = index;
    });
  }

  List<Widget> tab = const [
    DashBoardScreen(),
    CategoriesScreen(),
    FavouriteScreen(),
    SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      body: IndexedStack(
        index: widget.intex,
        children: tab,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: MyColors.white,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            activeIcon: Padding(
              padding: const EdgeInsets.all(8),
              child: Image.asset(Assets.home,
                  scale: 4, color: MyColors.primaryCustom),
            ),
            icon: Padding(
              padding: const EdgeInsets.all(8),
              child: Image.asset(
                Assets.home,
                scale: 5,
              ),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            activeIcon: Padding(
              padding: const EdgeInsets.all(8),
              child: Image.asset(Assets.category,
                  scale: 4, color: MyColors.primaryCustom),
            ),
            icon: Padding(
              padding: const EdgeInsets.all(8),
              child: Image.asset(
                Assets.category,
                scale: 5,
              ),
            ),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            activeIcon: Padding(
              padding: const EdgeInsets.all(8),
              child: Image.asset(Assets.star,
                  scale: 4, color: MyColors.primaryCustom),
            ),
            icon: Padding(
              padding: const EdgeInsets.all(8),
              child: Image.asset(
                Assets.star,
                scale: 5,
              ),
            ),
            label: 'Favourite',
          ),
          BottomNavigationBarItem(
            activeIcon: Padding(
              padding: const EdgeInsets.all(8),
              child: Image.asset(Assets.setting,
                  scale: 4, color: MyColors.primaryCustom),
            ),
            icon: Padding(
              padding: const EdgeInsets.all(8),
              child: Image.asset(
                Assets.setting,
                scale: 5,
              ),
            ),
            label: 'Setting',
          ),
        ],
        currentIndex: widget.intex!,
        selectedItemColor: MyColors.primaryCustom,
        onTap: onItemTapped,
      ),
    );
  }
}
