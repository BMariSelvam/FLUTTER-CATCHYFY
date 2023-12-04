import 'package:Catchyfive/Const/approutes.dart';
import 'package:Catchyfive/Const/assets.dart';
import 'package:Catchyfive/Const/colors.dart';
import 'package:Catchyfive/Const/font.dart';
import 'package:Catchyfive/Const/size.dart';
import 'package:Catchyfive/View/about_product/about_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FaqsOrderScreen extends StatefulWidget {
  const FaqsOrderScreen({super.key});

  @override
  State<FaqsOrderScreen> createState() => _FaqsOrderScreenState();
}

class _FaqsOrderScreenState extends State<FaqsOrderScreen> {
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
          'FAQs',
          style: TextStyle(
            fontFamily: MyFont.myFont,
            fontWeight: FontWeight.bold,
            color: MyColors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height(context) / 50),
            SizedBox(height: height(context) / 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Offers',
                style: TextStyle(
                  fontFamily: MyFont.myFont,
                  fontWeight: FontWeight.w900,
                  fontSize: 19,
                  color: MyColors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                children: [
                  ListTile(
                    onTap: () {},
                    contentPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    title: Text(
                      'Coupons not woring/expired cupon',
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
                  ListTile(
                    onTap: () {},
                    contentPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    title: Text(
                      'I forgot  to apply my coupon code. what I do now?',
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
                  ListTile(
                    onTap: () {},
                    contentPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    title: Text(
                      'How do I refer my friend ?',
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
