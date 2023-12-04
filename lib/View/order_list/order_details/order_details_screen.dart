import 'package:Catchyfive/Const/assets.dart';
import 'package:Catchyfive/Const/colors.dart';
import 'package:Catchyfive/Const/font.dart';
import 'package:Catchyfive/Const/size.dart';
import 'package:Catchyfive/Model/order_model/order_list_model.dart';
import 'package:Catchyfive/View/order_list/order_details/order_details_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrderDetailsListScreen extends StatefulWidget {
  const OrderDetailsListScreen({super.key});

  @override
  State<OrderDetailsListScreen> createState() => _OrderDetailsListScreenState();
}

class _OrderDetailsListScreenState extends State<OrderDetailsListScreen> {
  late OrderListModel selectedItems;

  late OrderDetailsController orderDetailsController;
  String orderDate = "";
  String statusName = "";
  var status;

  @override
  void initState() {
    super.initState();
    initData();
    data();
  }

  Future<void> initData() async {
    orderDetailsController = Get.put(OrderDetailsController());
    selectedItems = Get.arguments as OrderListModel;
    await orderDetailsController.getOrderDetailsList(selectedItems.orderNo);
  }

  data() {
    DateTime dateTime = DateFormat("yyyy-MM-dd")
        .parse(selectedItems.orderDate.toString() ?? "");
    orderDate = DateFormat("dd-MM-yyyy").format(dateTime);

    status = selectedItems.status;

    if (status == 0) {
      statusName = "open";
    } else if (status == 1) {
      statusName = "Delivered";
    } else if (status == 2) {
      statusName = "Return";
    } else {
      statusName = "Canceled";
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderDetailsController>(
      builder: (logic) {
        if (logic.isLoading.value == true) {
          return Container(
            color: MyColors.white,
            child: const Center(
              child: CircularProgressIndicator(
                color: MyColors.mainTheme,
              ),
            ),
          );
        }
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
              'Order',
              style: TextStyle(
                fontFamily: MyFont.myFont,
                fontWeight: FontWeight.bold,
                color: MyColors.white,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    text: 'ORDER NO: ',
                                    style: TextStyle(
                                        fontFamily: MyFont.myFont,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                        color: MyColors.black1)),
                                TextSpan(
                                    text: selectedItems.orderNo,
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
                                text: 'Placed on  ',
                                style: TextStyle(
                                    fontFamily: MyFont.myFont,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
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
                ),
                Container(
                  color: MyColors.lightGreen,
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(20, 5, 10, 10),
                        child: Text(
                          "Order ${statusName}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: MyFont.myFont,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: MyColors.black,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                        child: Text(
                          'Your payment was not completed. Any amount if debited will get refunded within 3-5 days. Please try placing the order again.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: MyFont.myFont,
                            fontWeight: FontWeight.bold,
                            color: MyColors.black,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                orderDetailsList(),
                SizedBox(height: height(context) / 50),
                const Divider(
                  thickness: 5,
                  color: MyColors.lightGreen2,
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Item total',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: MyFont.myFont,
                              fontSize: 15,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "",
                                // "\$ ${222.toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontFamily: MyFont.myFont,
                                  decoration: TextDecoration.lineThrough,
                                  fontSize: 13,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                "\$ ${selectedItems.subTotal!.toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: MyFont.myFont,
                                  fontSize: 13,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: height(context) / 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Handling charge (\$ ${10.toStringAsFixed(2)})',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontFamily: MyFont.myFont,
                              fontSize: 13,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "",
                                // "\$ ${10.toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.lineThrough,
                                  fontFamily: MyFont.myFont,
                                  fontSize: 13,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                "",
                                // "\$ ${10.toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: MyFont.myFont,
                                  fontSize: 13,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: height(context) / 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Delivery Fee',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontFamily: MyFont.myFont,
                              fontSize: 13,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "",
                                // "\$ ${10.toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.lineThrough,
                                  fontFamily: MyFont.myFont,
                                  fontSize: 13,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                "",
                                // "\$ ${10.toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: MyFont.myFont,
                                  fontSize: 13,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      const Divider(thickness: 1),
                      SizedBox(height: height(context) / 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'To Pay',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontFamily: MyFont.myFont,
                              fontSize: 18,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "",
                                // "\$ ${10.toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontFamily: MyFont.myFont,
                                  decoration: TextDecoration.lineThrough,
                                  fontSize: 13,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                selectedItems.netTotal!.toStringAsFixed(2),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: MyFont.myFont,
                                  fontSize: 18,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height(context) / 50),
                Container(
                    color: MyColors.lightGreen2, height: height(context) / 5),
              ],
            ),
          ),
        );
      },
    );
  }

  orderDetailsList() {
    print(" .length===========");
    print(orderDetailsController.orderDetailsModel.first.orderDetail?.length);
    return ListView.builder(
      shrinkWrap: true,
      itemCount:
          orderDetailsController.orderDetailsModel.first.orderDetail?.length ??
              0,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(10, 15, 0, 5),
              decoration: BoxDecoration(
                color: MyColors.background,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset(
                height: height(context) / 10,
                width: width(context) / 4,
                Assets.noImage,
                fit: BoxFit.contain,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width(context) / 1.39,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: width(context) / 2.2,
                              padding: const EdgeInsets.fromLTRB(20, 0, 0, 5),
                              child: Text(
                                "${orderDetailsController.orderDetailsModel.first.orderDetail?[index].productName}",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                  fontFamily: MyFont.myFont,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  color: MyColors.black,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: Text(
                                "${orderDetailsController.orderDetailsModel.first.orderDetail?[index].weight}"
                                "Kg"
                                " |  Qty : "
                                "${orderDetailsController.orderDetailsModel.first.orderDetail?[index].qty}",
                                style: TextStyle(
                                  fontFamily: MyFont.myFont,
                                  fontWeight: FontWeight.bold,
                                  color: MyColors.grey,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(23, 0, 20, 0),
                          child: Column(
                            children: [
                              Text(
                                "${orderDetailsController.orderDetailsModel.first.orderDetail?[index].subTotal?.toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontFamily: MyFont.myFont,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: MyColors.mainTheme,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 3, 0, 0),
                                child: Text(
                                  "${orderDetailsController.orderDetailsModel.first.orderDetail?[index].subTotal?.toStringAsFixed(2)}",
                                  style: TextStyle(
                                    fontFamily: MyFont.myFont,
                                    fontWeight: FontWeight.bold,
                                    color: MyColors.lightGreen3,
                                    decoration: TextDecoration.lineThrough,
                                    fontSize: 11,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
