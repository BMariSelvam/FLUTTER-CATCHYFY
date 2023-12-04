import 'package:Catchyfive/Const/approutes.dart';
import 'package:Catchyfive/Const/assets.dart';
import 'package:Catchyfive/Const/colors.dart';
import 'package:Catchyfive/Const/font.dart';
import 'package:Catchyfive/Const/size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderEmptyScreen extends StatefulWidget {
  const OrderEmptyScreen({Key? key}) : super(key: key);

  @override
  State<OrderEmptyScreen> createState() => _OrderEmptyScreenState();
}

class _OrderEmptyScreenState extends State<OrderEmptyScreen> {
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
          'Your Orders',
          style: TextStyle(
            fontFamily: MyFont.myFont,
            fontWeight: FontWeight.bold,
            color: MyColors.white,
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
      bottomNavigationBar: Container(
        height: 60,
        margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
        child: GestureDetector(
          onTap: () {
            Get.toNamed(AppRoutes.orderListScreen);
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
    );
  }
}
