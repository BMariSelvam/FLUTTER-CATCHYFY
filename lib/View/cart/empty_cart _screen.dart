import 'dart:async';

import 'package:Catchyfive/Const/approutes.dart';
import 'package:Catchyfive/Const/colors.dart';
import 'package:Catchyfive/Const/font.dart';
import 'package:Catchyfive/Const/size.dart';
import 'package:Catchyfive/View/Login/loginscreen.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Const/assets.dart';

class CartEmptyScreen extends StatefulWidget {
  const CartEmptyScreen({Key? key}) : super(key: key);

  @override
  State<CartEmptyScreen> createState() => _CartEmptyScreenState();
}

class _CartEmptyScreenState extends State<CartEmptyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Cart',
          style: TextStyle(
            fontFamily: MyFont.myFont,
            fontWeight: FontWeight.bold,
            color: MyColors.white,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: InkWell(
              onTap: () {
                Get.toNamed(AppRoutes.cartScreen);
              },
              child: const Icon(
                Icons.shopping_cart_outlined,
                color: MyColors.white,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 60,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
        child: GestureDetector(
          onTap: () {
            Get.toNamed(AppRoutes.cartScreen);
          },
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: MyColors.mainTheme,
              // border: Border.all(color: MyColors.mainTheme, width: 2),
            ),
            child: Center(
                child: Text(
              'Click to Order Products',
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
      body: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Image.asset(Assets.empty),
            ),
            Container(
              width: width(context) / 1.5,
              padding: const EdgeInsets.all(20),
              child: Text(
                'Oops, You haven’t placed an order yet..!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: MyFont.myFont,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: MyColors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
