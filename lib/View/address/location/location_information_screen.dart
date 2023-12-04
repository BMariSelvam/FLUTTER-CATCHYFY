import 'dart:async';

import 'package:Catchyfive/Const/approutes.dart';
import 'package:Catchyfive/Const/assets.dart';
import 'package:Catchyfive/Const/colors.dart';
import 'package:Catchyfive/Const/font.dart';
import 'package:Catchyfive/Const/size.dart';
import 'package:Catchyfive/Widget/CustomTextField.dart';
import 'package:Catchyfive/Widget/searchTextField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class LocationInformationScreen extends StatefulWidget {
  const LocationInformationScreen({Key? key}) : super(key: key);

  @override
  State<LocationInformationScreen> createState() =>
      _LocationInformationScreenState();
}

class _LocationInformationScreenState extends State<LocationInformationScreen> {
  TextEditingController locationSearchInformationController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        backgroundColor: MyColors.mainTheme,
        elevation: 0,
        iconTheme: const IconThemeData(color: MyColors.white),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          'Location Information',
          style: TextStyle(
            fontFamily: MyFont.myFont,
            fontWeight: FontWeight.bold,
            color: MyColors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Get.toNamed(AppRoutes.cartEmptyScreen);
            },
            icon:
                const Icon(Icons.shopping_cart_outlined, color: MyColors.white),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: CustomTextField(
                inputBorder: const OutlineInputBorder(),
                controller: locationSearchInformationController,
                keyboardType: TextInputType.text,
                hintText: 'Search a new address',
                readOnly: false,
                fillColor: MyColors.lightGreen2,
                prefixIcon: Image.asset(
                  Assets.searchIcon,
                  scale: 0.9,
                  color: MyColors.black,
                ),
              ),
            ),
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Image.asset(
                    Assets.map,
                    scale: 1,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 15),
                  margin: const EdgeInsets.fromLTRB(30, 10, 30, 18),
                  decoration: const BoxDecoration(
                    color: MyColors.lightGreen2,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(5),
                                child: Text(
                                  'Home',
                                  style: TextStyle(
                                    fontFamily: MyFont.myFont,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 15,
                                    color: MyColors.black,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(5),
                                width: width(context) / 1.35,
                                child: Text(
                                  'Home 1/44, Kuppam road, Valimiki Nagar, Raja Garden,Kottivakkam, Chennai, Tamil nadu- 600041',
                                  style: TextStyle(
                                    fontFamily: MyFont.myFont,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 10,
                                    color: MyColors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 5,
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 8),
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
                                        'Confirm & Continue',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontFamily: MyFont.myFont,
                                            fontSize: 14,
                                            color: MyColors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
