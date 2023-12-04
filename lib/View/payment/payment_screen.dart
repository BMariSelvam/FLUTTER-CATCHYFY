import 'package:Catchyfive/Const/approutes.dart';
import 'package:Catchyfive/Const/assets.dart';
import 'package:Catchyfive/Const/colors.dart';
import 'package:Catchyfive/Const/font.dart';
import 'package:Catchyfive/Const/size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_rounded, color: MyColors.white),
        ),
        title: Text(
          'Payment Method',
          style: TextStyle(
              fontFamily: MyFont.myFont,
              fontWeight: FontWeight.w900,
              fontSize: 19,
              color: MyColors.white),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: GestureDetector(
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Text(
                          "Delivery to",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontFamily: MyFont.myFont,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(height: height(context) / 100),
                        Text(
                          "Home",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: MyFont.myFont,
                            fontSize: 13,
                            color: MyColors.mainTheme,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Text(
                          "Order Amount",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontFamily: MyFont.myFont,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(height: height(context) / 100),
                        Text(
                          "\$ 16.77",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: MyFont.myFont,
                            fontSize: 13,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 18),
              decoration: const BoxDecoration(
                  color: MyColors.lightGreen2,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Proceed to Checkout",
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontFamily: MyFont.myFont,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                  SizedBox(height: height(context) / 50),
                  Center(
                    child: Column(
                      children: [
                        Image.asset(
                          Assets.paypal,
                          scale: 1,
                        ),
                        SizedBox(height: height(context) / 80),
                        Text(
                          "Pay Pal",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontFamily: MyFont.myFont,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
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
                          color: MyColors.org1,
                          // border: Border.all(color: MyColors.mainTheme, width: 2),
                        ),
                        child: Center(
                          child: Image.asset(
                            Assets.paypal1,
                            scale: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 5,
                    ),
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
                          child: Image.asset(
                            Assets.paypalcredit,
                            scale: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: height(context) / 50),
                  Container(
                    alignment: Alignment.center,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Center(
                          child: Image.asset(
                            Assets.visa,
                            scale: 1,
                          ),
                        ),
                        Center(
                          child: Image.asset(
                            Assets.visa,
                            scale: 1,
                          ),
                        ),
                        Center(
                          child: Image.asset(
                            Assets.visa,
                            scale: 1,
                          ),
                        ),
                        Center(
                          child: Image.asset(
                            Assets.visa,
                            scale: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height(context) / 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Powered by",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontStyle: FontStyle.italic,
                          fontFamily: MyFont.myFont,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(width: width(context) / 50),
                      Image.asset(
                        Assets.paypal1,
                        scale: 1,
                      ),
                    ],
                  ),
                  SizedBox(height: height(context) / 80),
                ],
              ),
            ),
            SizedBox(height: height(context) / 30),
            Container(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 18),
              decoration: const BoxDecoration(
                  color: MyColors.lightGreen2,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Net Banking",
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontFamily: MyFont.myFont,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                  SizedBox(height: height(context) / 50),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Image.asset(
                              Assets.netpay,
                              scale: 1,
                            ),
                            SizedBox(height: height(context) / 100),
                            Text(
                              "Pay Pal",
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontFamily: MyFont.myFont,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: width(context) / 30),
                        Column(
                          children: [
                            Image.asset(
                              Assets.netpay,
                              scale: 1,
                            ),
                            SizedBox(height: height(context) / 100),
                            Text(
                              "Pay Pal",
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontFamily: MyFont.myFont,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: width(context) / 30),
                        Column(
                          children: [
                            Image.asset(
                              Assets.netpay,
                              scale: 1,
                            ),
                            SizedBox(height: height(context) / 100),
                            Text(
                              "Pay Pal",
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontFamily: MyFont.myFont,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: width(context) / 30),
                      ],
                    ),
                  ),
                  SizedBox(height: height(context) / 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                                "Other Bank",
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
            ),
            SizedBox(height: height(context) / 30),
            Container(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 18),
              decoration: const BoxDecoration(
                  color: MyColors.lightGreen2,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Pay on Delivery",
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontFamily: MyFont.myFont,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                  SizedBox(height: height(context) / 50),
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              Assets.amountIcon,
                              scale: 1,
                            ),
                          ],
                        ),
                        SizedBox(width: width(context) / 30),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: width(context) / 1.6,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    "Cash On Delivery",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontFamily: MyFont.myFont,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Image.asset(
                                    Assets.tick,
                                    scale: 1.5,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: height(context) / 100),
                            Text(
                              "Scan and pay via UPI on delivery. Ask delivery partner for details.",
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontFamily: MyFont.myFont,
                                fontSize: 8,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height(context) / 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                                "Proceed to Pay",
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
            ),
          ],
        ),
      ),
    );
  }
}
