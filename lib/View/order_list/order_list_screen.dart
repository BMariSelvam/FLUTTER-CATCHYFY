import 'package:Catchyfive/Const/approutes.dart';
import 'package:Catchyfive/Const/colors.dart';
import 'package:Catchyfive/Const/font.dart';
import 'package:Catchyfive/Const/size.dart';
import 'package:Catchyfive/View/order_list/order_details/order_details_screen_controller.dart';
import 'package:Catchyfive/View/order_list/order_empty_screen.dart';
import 'package:Catchyfive/View/order_list/order_list_controller.dart';
import 'package:Catchyfive/Widget/empty.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({super.key});

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  late OrderController orderController;

  @override
  void initState() {
    orderController = Get.put(OrderController());
    orderController.getOrderList();
    super.initState();
  }

  Future<void> _refreshData() async {
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      orderController = Get.put(OrderController());
      orderController.getOrderList();
      super.initState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder: (logic) {
      // if (logic.isLoading.value == true ) {
      //   return Container(
      //     color: MyColors.white,
      //     child: const Center(
      //       child: CircularProgressIndicator(),
      //     ),
      //   );
      // }
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
            'Orders',
            style: TextStyle(
              fontFamily: MyFont.myFont,
              fontWeight: FontWeight.bold,
              color: MyColors.white,
            ),
          ),
        ),
        body: RefreshIndicator(
            onRefresh: _refreshData,
            child: SingleChildScrollView(
              child: (orderController.ordersModelList.value != null)
                  ? orderList()
                  : Container(),
            )),
      );
    });
  }

  orderList() {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: orderController.ordersModelList.value?.length,
        itemBuilder: (context, index) {
          DateTime dateTime = DateFormat("yyyy-MM-dd").parse(orderController
                  .ordersModelList.value?[index].orderDate
                  .toString() ??
              "");
          String orderDate = DateFormat("dd-MM-yyyy").format(dateTime);
          var status = orderController.ordersModelList.value?[index].status;

          String statusName = "";
          if (status == 0) {
            statusName = "open";
          } else if (status == 1) {
            statusName = "Delivered";
          } else if (status == 2) {
            statusName = "Return";
          } else {
            statusName = "Canceled";
          }
          return InkWell(
            onTap: () {
              Get.toNamed(AppRoutes.orderDetailsListScreen,
                  arguments: orderController.ordersModelList.value?[index]);
            },
            child: Column(
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
                              Get.toNamed(AppRoutes.orderDetailsListScreen,
                                  arguments: orderController
                                      .ordersModelList.value?[index]);
                            },
                            child: SizedBox(
                              width: width(context) / 2,
                              child: Text(
                                " ${orderController.ordersModelList.value?[index].customerName ?? ""}",

                                // "${orderDetailsController.orderDetailsModel[index].orderDetail?[index].productName}",
                                // "strawberries, raspberries, blueberries, kiwifruit and passionfruit.strawberries, raspberries, blueberries, kiwifruit and passionfruit.",
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
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Text(
                              "\$ ${orderController.ordersModelList.value?[index].netTotal?.toStringAsFixed(2) ?? ""}",
                              style: TextStyle(
                                  fontFamily: MyFont.myFont,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: MyColors.mainTheme),
                            ),
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
                                        text:
                                            " ${orderController.ordersModelList.value?[index].orderNo ?? ""}",
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
                                    text: orderDate,
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
                                  color: (status == 0)
                                      ? MyColors.org
                                      : (status == 1)
                                          ? MyColors.mainTheme
                                          : (status == 2)
                                              ? MyColors.red
                                              : Colors.grey,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    child: Text(
                                      statusName,
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
            ),
          );
        });
  }
}
