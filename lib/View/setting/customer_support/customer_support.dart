import 'package:Catchyfive/Const/approutes.dart';
import 'package:Catchyfive/Const/assets.dart';
import 'package:Catchyfive/Const/colors.dart';
import 'package:Catchyfive/Const/font.dart';
import 'package:Catchyfive/Const/size.dart';
import 'package:Catchyfive/View/about_product/about_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerSupportScreen extends StatefulWidget {
  const CustomerSupportScreen({super.key});

  @override
  State<CustomerSupportScreen> createState() => _CustomerSupportScreenState();
}

class _CustomerSupportScreenState extends State<CustomerSupportScreen> {
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
          'Customer Support & FAQs',
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recent Orders',
                    style: TextStyle(
                      fontFamily: MyFont.myFont,
                      fontWeight: FontWeight.w900,
                      fontSize: 19,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: InkWell(
                      onTap: () {
                        Get.toNamed(AppRoutes.orderListScreen);
                      },
                      child: Card(
                        elevation: 0,
                        color: MyColors.mainTheme,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 0),
                          child: Row(
                            children: [
                              Text(
                                "See All  ",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: MyFont.myFont,
                                  fontWeight: FontWeight.bold,
                                  color: MyColors.white,
                                  fontSize: 10,
                                ),
                              ),
                              const Icon(
                                Icons.arrow_right_alt_rounded,
                                color: MyColors.white,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            orderList(),
            SizedBox(height: height(context) / 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'FAQs',
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
                    onTap: () {
                      Get.toNamed(AppRoutes.FaqsOrderScreen);
                    },
                    contentPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    title: Text(
                      'Offers',
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
                    onTap: () {
                      Get.toNamed(AppRoutes.FaqsGeneralInquiryScreen);
                    },
                    contentPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    title: Text(
                      'General Inquiry',
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
                    onTap: () {
                      Get.toNamed(AppRoutes.FaqsPaymentRelatedScreen);
                    },
                    contentPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    title: Text(
                      'Payment Related',
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
                    onTap: () {
                      Get.toNamed(AppRoutes.FaqsFeedbackSuggestionsScreen);
                    },
                    contentPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    title: Text(
                      'Feedback & Suggestions',
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
                    onTap: () {
                      Get.toNamed(AppRoutes.FaqsScheduledDeliveryRelatedScreen);
                    },
                    contentPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    title: Text(
                      'Scheduled Delivery Related',
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
                    onTap: () {
                      Get.toNamed(AppRoutes.FaqsOrderAndProductRelatedScreen);
                    },
                    contentPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    title: Text(
                      'Order / Products Related',
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

  orderList() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: 2,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 15,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.toNamed(AppRoutes.orderDetailsListScreen);
                          },
                          child: SizedBox(
                            width: width(context) / 2,
                            child: Text(
                              "strawberries, raspberries, blueberries, kiwifruit and passionfruit.strawberries, raspberries, blueberries, kiwifruit and passionfruit.",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontFamily: MyFont.myFont,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: MyColors.black),
                            ),
                          ),
                        ),
                        Text(
                          "\$ ${555555.toStringAsFixed(2)}",
                          style: TextStyle(
                              fontFamily: MyFont.myFont,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: MyColors.mainTheme),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                      text: 'Order No : ',
                                      style: TextStyle(
                                          fontFamily: MyFont.myFont,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10,
                                          color: MyColors.black1)),
                                  TextSpan(
                                      text: "oooooo",
                                      style: TextStyle(
                                          fontFamily: MyFont.myFont,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10,
                                          color: MyColors.black1)),
                                ],
                              ),
                            ),
                            RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  text: 'Date : ',
                                  style: TextStyle(
                                      fontFamily: MyFont.myFont,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                      color: MyColors.black1)),
                              TextSpan(
                                  text: "date",
                                  style: TextStyle(
                                      fontFamily: MyFont.myFont,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                      color: MyColors.black1)),
                            ])),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.only(right: 10, top: 10),
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              Card(
                                color: Colors.deepOrange,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: Text(
                                    "Delivered",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: MyFont.myFont,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                        color: MyColors.white),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: height(context) / 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 28, vertical: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                // color: MyColors.mainTheme,
                                border: Border.all(
                                    color: MyColors.greyText1, width: 2),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.shopping_bag_rounded,
                                    color: MyColors.mainTheme,
                                    size: 15,
                                  ),
                                  SizedBox(
                                    width: width(context) / 50,
                                  ),
                                  Text(
                                    'Reorder',
                                    style: TextStyle(
                                      fontFamily: MyFont.myFont,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      color: MyColors.mainTheme,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                // color: MyColors.mainTheme,
                                border: Border.all(
                                    color: MyColors.greyText1, width: 2),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.star_border_rounded,
                                    color: MyColors.mainTheme,
                                    size: 15,
                                  ),
                                  SizedBox(
                                    width: width(context) / 50,
                                  ),
                                  Text(
                                    'Rate Order',
                                    style: TextStyle(
                                      fontFamily: MyFont.myFont,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      color: MyColors.mainTheme,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(
                thickness: 5,
                color: MyColors.lightGreen2,
              ),
            ],
          );
        });
  }
}
