import 'package:Catchyfive/Const/approutes.dart';
import 'package:Catchyfive/Const/assets.dart';
import 'package:Catchyfive/Const/colors.dart';
import 'package:Catchyfive/Const/font.dart';
import 'package:Catchyfive/Const/size.dart';
import 'package:Catchyfive/View/about_product/about_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FaqsPaymentRelatedScreen extends StatefulWidget {
  const FaqsPaymentRelatedScreen({super.key});

  @override
  State<FaqsPaymentRelatedScreen> createState() =>
      _FaqsPaymentRelatedScreenState();
}

class _FaqsPaymentRelatedScreenState extends State<FaqsPaymentRelatedScreen> {
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
                'Payment related',
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
                      'What are the modes of payment ?',
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
                      'How to i change the mode of payment ?',
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
                      'What is Pan seas wallet ?',
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
                      'Why is my COD blocked ?',
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
                      'Why is there a Nethili fish fee ?',
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
                      'Do you charge for the bag ?',
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
                      'Give me famous fish price ?',
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
