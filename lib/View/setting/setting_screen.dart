import 'package:Catchyfive/Const/approutes.dart';
import 'package:Catchyfive/Const/assets.dart';
import 'package:Catchyfive/Const/colors.dart';
import 'package:Catchyfive/Const/font.dart';
import 'package:Catchyfive/Const/size.dart';
import 'package:Catchyfive/Helper/preferenceHelper.dart';
import 'package:Catchyfive/Widget/bottomnavbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../locator/cart_service.dart';
import '../../locator/locator.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  // final CartService cartService = getIt<CartService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: MyColors.mainTheme,
        iconTheme: const IconThemeData(color: MyColors.white),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.offAndToNamed(AppRoutes.bottomNavBar0);
          },
        ),
        title: Text(
          'Settings',
          style: TextStyle(
              fontFamily: MyFont.myFont,
              fontWeight: FontWeight.bold,
              color: MyColors.white),
        ),
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.all(15),
        //     child: GestureDetector(
        //       onTap: () {
        //         Get.toNamed(AppRoutes.ResetPasswordScreen);
        //       },
        //       child: const Icon(
        //         Icons.person,
        //         color: MyColors.white,
        //       ),
        //     ),
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(
            top: 15,
            bottom: 15,
            right: 20,
            left: 20,
          ),
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  tileColor: MyColors.lightGreen5,
                  onTap: () {
                    Get.toNamed(AppRoutes.editProfileScreen);
                  },
                  contentPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  leading: const Icon(
                    Icons.person_2_outlined,
                    color: MyColors.mainTheme,
                  ),
                  title: Text(
                    'Profile',
                    style: TextStyle(
                      fontFamily: MyFont.myFont,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                    color: MyColors.mainTheme,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  tileColor: MyColors.lightGreen5,
                  onTap: () {
                    Get.toNamed(AppRoutes.ResetPasswordScreen);
                  },
                  contentPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  leading: const Icon(
                    Icons.person_2_outlined,
                    color: MyColors.mainTheme,
                  ),
                  title: Text(
                    'Change Password',
                    style: TextStyle(
                      fontFamily: MyFont.myFont,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                    color: MyColors.mainTheme,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  tileColor: MyColors.lightGreen5,
                  onTap: () {
                    Get.toNamed(AppRoutes.orderListScreen);
                  },
                  contentPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  leading: const Icon(
                    Icons.shopping_cart_outlined,
                    color: MyColors.mainTheme,
                  ),
                  title: Text(
                    'Orders',
                    style: TextStyle(
                      fontFamily: MyFont.myFont,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                    color: MyColors.mainTheme,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  tileColor: MyColors.lightGreen5,
                  onTap: () {
                    Get.toNamed(AppRoutes.addressScreen);
                  },
                  contentPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  leading: const Icon(
                    Icons.location_on_outlined,
                    color: MyColors.mainTheme,
                  ),
                  title: Text(
                    'Address',
                    style: TextStyle(
                      fontFamily: MyFont.myFont,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                    color: MyColors.mainTheme,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  tileColor: MyColors.lightGreen5,
                  onTap: () {
                    Get.toNamed(AppRoutes.customerSupportScreen);
                  },
                  contentPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  leading: const Icon(
                    Icons.message,
                    color: MyColors.mainTheme,
                  ),
                  title: Text(
                    'Customer Support & FAQ',
                    style: TextStyle(
                      fontFamily: MyFont.myFont,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                    color: MyColors.mainTheme,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  tileColor: MyColors.lightGreen5,
                  onTap: () {
                    Get.toNamed(AppRoutes.refundScreen);
                  },
                  contentPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  leading: const Icon(
                    Icons.refresh_rounded,
                    color: MyColors.mainTheme,
                  ),
                  title: Text(
                    'Refunds',
                    style: TextStyle(
                      fontFamily: MyFont.myFont,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                    color: MyColors.mainTheme,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  tileColor: MyColors.lightGreen5,
                  onTap: () {
                    bottomSuggestSheet();
                  },
                  contentPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  leading: const Icon(
                    Icons.settings_suggest_rounded,
                    color: MyColors.mainTheme,
                  ),
                  title: Text(
                    'Suggest Products',
                    style: TextStyle(
                      fontFamily: MyFont.myFont,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                    color: MyColors.mainTheme,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  tileColor: MyColors.lightGreen5,
                  onTap: () {
                    Get.toNamed(AppRoutes.notificationScreen);
                  },
                  contentPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  leading: const Icon(
                    Icons.notifications_none_rounded,
                    color: MyColors.mainTheme,
                  ),
                  title: Text(
                    'Notifications',
                    style: TextStyle(
                      fontFamily: MyFont.myFont,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                    color: MyColors.mainTheme,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox (
          height: 40,
          child: Row (
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () async {
                  await PreferenceHelper.clearUserData().then((value) =>
                      Get.offAllNamed(AppRoutes.login)
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 18, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: MyColors
                        .mainTheme, // border: Border.all(color: MyColors.mainTheme, width: 2),
                  ),
                  child: Center(
                      child: Text(
                        'Log Out',
                        style: TextStyle(
                          fontFamily: MyFont.myFont,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: MyColors.white,
                        ),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bottomSuggestSheet() {
    showModalBottomSheet<void>(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.0),
          ),
        ),
        builder: (BuildContext context) {
          return Container(
            height: 380,
            color: MyColors.white,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Suggest Products',
                    style: TextStyle(
                      fontFamily: MyFont.myFont,
                      fontWeight: FontWeight.w900,
                      fontSize: 19,
                      color: MyColors.black,
                    ),
                  ),
                  SizedBox(
                    height: height(context) / 50,
                  ),
                  Container(
                    width: width(context) / 1.5,
                    child: Text(
                      'Did’t find what you are looking for? Please suggest the product.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: MyFont.myFont,
                        fontWeight: FontWeight.w900,
                        fontSize: 10,
                        color: MyColors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height(context) / 50,
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(15, 10, 15, 18),
                    margin: const EdgeInsets.fromLTRB(20, 15, 20, 18),
                    decoration: const BoxDecoration(
                      color: MyColors.lightGreen2,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          width: width(context) / 1.6,
                          child: Text(
                            "Enter the name of the products you would like to see on Pan seas.",
                            style: TextStyle(
                              fontFamily: MyFont.myFont,
                              fontWeight: FontWeight.w500,
                              fontSize: 10,
                              color: MyColors.black,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height(context) / 50,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: MyColors.mainTheme,
                                // border: Border.all(color: MyColors.mainTheme, width: 2),
                              ),
                              child: Icon(
                                Icons.photo_camera,
                                color: MyColors.white,
                              ),
                            ),
                            SizedBox(
                              width: width(context) / 50,
                            ),
                            Container(
                              padding: const EdgeInsets.all(5),
                              child: Text(
                                'Upload images',
                                style: TextStyle(
                                  fontFamily: MyFont.myFont,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 15,
                                  color: MyColors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 60,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 18),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: MyColors.mainTheme,
                          // border: Border.all(color: MyColors.mainTheme, width: 2),
                        ),
                        child: Center(
                            child: Text(
                          'Submit',
                          style: TextStyle(
                            fontFamily: MyFont.myFont,
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: MyColors.white,
                          ),
                        )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
