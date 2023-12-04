import 'package:Catchyfive/Const/approutes.dart';
import 'package:Catchyfive/Const/assets.dart';
import 'package:Catchyfive/Const/colors.dart';
import 'package:Catchyfive/Const/font.dart';
import 'package:Catchyfive/Const/size.dart';
import 'package:Catchyfive/Helper/api.dart';
import 'package:Catchyfive/Helper/preferencehelper.dart';
import 'package:Catchyfive/Model/login/login_model.dart';
import 'package:Catchyfive/Model/sales_order/sales_order.dart';
import 'package:Catchyfive/Model/sales_order/sales_order_detail.dart';
import 'package:Catchyfive/View/cart/cart_controller.dart';
import 'package:Catchyfive/View/sub_categories/subcategory_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  B2cLoginModel? loginUser;

  String currentDate = DateTime.now().toString();

  late CartController cartController;

  double taxValue = 0;
  double subtotal = 0;
  double total = 0;
  double tax = 0;
  double qtyTotal = 0;
  double avgQtyTotal = 0;
  double totalcount = 0;
  double grandTotal = 0;
  int slNo = 0;

  String? customerId;
  String? orgId;
  String? countryId;
  String? address;
  String? postalCode;
  String? emailId;
  String? b2CCustomerName;
  String? branchCode;

  String? sendSalesAddress;

  @override
  initState() {
    super.initState();
    getUserData();
    cartController = Get.put(CartController());
    SubCategoryController _cartController = Get.find<SubCategoryController>();
    cartController.selectedItems = _cartController.cartAddedProduct.value;
    cartController.cartService.cartChangeStream.listen((_) {});
    cartController.getAddress();
    print("cartController.selectedItems.first.qtycount");
    print(cartController.selectedItems.first.qtycount);
  }

  getUserData() async {
    await PreferenceHelper.getUserData().then((value) {
      customerId = value?.b2CCustomerId;
      b2CCustomerName = value?.b2CCustomerName;
      branchCode = value?.branchCode;
      emailId = value?.emailId;
      postalCode = value?.postalCode;
      address = value?.address.toString();
      countryId = value?.countryId;
      orgId = value?.orgId.toString();
    });
  }

  int selectedAddressIndex = -1;

  @override
  Widget build(BuildContext context) {
    double taxValue = 0;

    double subtotal = 0;

    double grandTotal = 0;
    for (var element in cartController.selectedItems) {
      subtotal += (element.qtycount * element.sellingCost!);

      taxValue = (subtotal * element.taxPerc!) / 100;
      grandTotal = subtotal + taxValue;
    }
    return GetBuilder<CartController>(builder: (state) {
      if (state.isLoading.value == true) {
        return Container(
          color: MyColors.white,
          child: const Center(
            child: CircularProgressIndicator(),
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
            'Cart',
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
              cartList(),
              SizedBox(height: height(context) / 50),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Text(
                  'You Might Also Like',
                  style: TextStyle(
                    fontFamily: MyFont.myFont,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(height: height(context) / 50),
              // Container(
              //   padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
              //   color: MyColors.lightGreen2,
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text(
              //         "Delivery Partner Tip",
              //         style: TextStyle(
              //           fontWeight: FontWeight.w900,
              //           fontFamily: MyFont.myFont,
              //           fontSize: 16,
              //         ),
              //       ),
              //       SizedBox(height: height(context) / 80),
              //       Text(
              //         "The entire amount will be sent to your delivery partner",
              //         style: TextStyle(
              //           fontWeight: FontWeight.bold,
              //           fontFamily: MyFont.myFont,
              //           fontSize: 15,
              //         ),
              //       ),
              //       SizedBox(height: height(context) / 50),
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: [
              //           Card(
              //             shape: RoundedRectangleBorder(
              //               side: const BorderSide(
              //                 color: MyColors.mainTheme,
              //                 width: 2,
              //               ),
              //               borderRadius: BorderRadius.circular(20.0),
              //             ),
              //             child: Padding(
              //               padding: const EdgeInsets.symmetric(
              //                   horizontal: 10, vertical: 5),
              //               child: Text(
              //                 "\$ 10 ",
              //                 textAlign: TextAlign.center,
              //                 style: TextStyle(
              //                   fontFamily: MyFont.myFont,
              //                   fontWeight: FontWeight.bold,
              //                   color: MyColors.mainTheme,
              //                   fontSize: 9,
              //                 ),
              //               ),
              //             ),
              //           ),
              //           Card(
              //             shape: RoundedRectangleBorder(
              //               side: const BorderSide(
              //                 color: MyColors.mainTheme,
              //                 width: 2,
              //               ),
              //               borderRadius: BorderRadius.circular(20.0),
              //             ),
              //             child: Padding(
              //               padding: const EdgeInsets.symmetric(
              //                   horizontal: 10, vertical: 5),
              //               child: Text(
              //                 "\$ 25 ",
              //                 textAlign: TextAlign.center,
              //                 style: TextStyle(
              //                   fontFamily: MyFont.myFont,
              //                   fontWeight: FontWeight.bold,
              //                   color: MyColors.mainTheme,
              //                   fontSize: 9,
              //                 ),
              //               ),
              //             ),
              //           ),
              //           Card(
              //             shape: RoundedRectangleBorder(
              //               side: const BorderSide(
              //                 color: MyColors.mainTheme,
              //                 width: 2,
              //               ),
              //               borderRadius: BorderRadius.circular(20.0),
              //             ),
              //             child: Padding(
              //               padding: const EdgeInsets.symmetric(
              //                   horizontal: 10, vertical: 5),
              //               child: Text(
              //                 "\$ 50 ",
              //                 textAlign: TextAlign.center,
              //                 style: TextStyle(
              //                   fontFamily: MyFont.myFont,
              //                   fontWeight: FontWeight.bold,
              //                   color: MyColors.mainTheme,
              //                   fontSize: 9,
              //                 ),
              //               ),
              //             ),
              //           ),
              //           Card(
              //             shape: RoundedRectangleBorder(
              //               side: const BorderSide(
              //                 color: MyColors.mainTheme,
              //                 width: 2,
              //               ),
              //               borderRadius: BorderRadius.circular(20.0),
              //             ),
              //             child: Padding(
              //               padding: const EdgeInsets.symmetric(
              //                   horizontal: 10, vertical: 5),
              //               child: Text(
              //                 "\$ 75 ",
              //                 textAlign: TextAlign.center,
              //                 style: TextStyle(
              //                   fontFamily: MyFont.myFont,
              //                   fontWeight: FontWeight.bold,
              //                   color: MyColors.mainTheme,
              //                   fontSize: 9,
              //                 ),
              //               ),
              //             ),
              //           ),
              //           Card(
              //             color: MyColors.mainTheme,
              //             shape: const RoundedRectangleBorder(
              //               borderRadius: BorderRadius.all(Radius.circular(20)),
              //             ),
              //             child: Padding(
              //               padding: const EdgeInsets.symmetric(
              //                   horizontal: 10, vertical: 5),
              //               child: Text(
              //                 "Custom",
              //                 textAlign: TextAlign.center,
              //                 style: TextStyle(
              //                   fontFamily: MyFont.myFont,
              //                   fontWeight: FontWeight.bold,
              //                   color: MyColors.white,
              //                   fontSize: 9,
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
              SizedBox(height: height(context) / 50),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Item Count',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: MyFont.myFont,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "${cartController.selectedItems.length}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: MyFont.myFont,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height(context) / 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Item total',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: MyFont.myFont,
                            fontSize: 18,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              // "\$ ${222.toStringAsFixed(2)}",
                              "",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: MyFont.myFont,
                                decoration: TextDecoration.lineThrough,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "\$ ${subtotal.toStringAsFixed(2)}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: MyFont.myFont,
                                fontSize: 15,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: height(context) / 50),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Text(
                    //       'Delivery Fee',
                    //       style: TextStyle(
                    //         fontWeight: FontWeight.normal,
                    //         fontFamily: MyFont.myFont,
                    //         fontSize: 15,
                    //       ),
                    //     ),
                    //     Row(
                    //       children: [
                    //         Text(
                    //           // "\$ ${222.toStringAsFixed(2)}",
                    //           "",
                    //           style: TextStyle(
                    //             fontWeight: FontWeight.bold,
                    //             fontFamily: MyFont.myFont,
                    //             decoration: TextDecoration.lineThrough,
                    //             fontSize: 15,
                    //           ),
                    //         ),
                    //         const SizedBox(width: 10),
                    //         Text(
                    //           // "\$ ${222.toStringAsFixed(2)}",
                    //           "",
                    //           style: TextStyle(
                    //             fontWeight: FontWeight.bold,
                    //             fontFamily: MyFont.myFont,
                    //             fontSize: 15,
                    //           ),
                    //         )
                    //       ],
                    //     ),
                    //   ],
                    // ),
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
                        Text(
                          "\$ ${grandTotal.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: MyFont.myFont,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: height(context) / 50),
              Container(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                color: MyColors.lightGreen2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: MyColors.background,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image.asset(
                        Assets.guardTick,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "\$ 50 Saved on this order",
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontFamily: MyFont.myFont,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: height(context) / 50),
              Container(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 18),
                decoration: const BoxDecoration(
                    color: MyColors.lightGreen2,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: addAddress(),
              ),
              SizedBox(height: height(context) / 50),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onPressed: () async {
                if (cartController.selectedAddress.isNotEmpty) {
                  if (cartController.selectedItems.first.qtycount == 0) {
                    showBarBottom();
                    cartController.selectedItems.clear();
                    cartController.cartService.cartItems.clear();
                    cartController.updateProductCount();
                    Get.offAndToNamed(AppRoutes.bottomNavBar);
                  } else {
                    cartController.salesOrder = SalesOrder(
                      orgId: HttpUrl.org,
                      orderNo: "",
                      paidAmount: grandTotal,
                      paymentType: "",
                      postalCode: postalCode,
                      customerEmail: emailId,
                      billDiscount: 0,
                      billDiscountPerc: 0,
                      brachCode: branchCode,
                      orderDate: currentDate,
                      customerId: customerId,
                      customerName: b2CCustomerName,
                      customerAddress: sendSalesAddress,
                      orderDateString: currentDate,
                      taxCode: 0,
                      taxType: "E",
                      taxPerc: taxValue,
                      currencyCode: "",
                      currencyRate: 1,
                      total: subtotal,
                      subTotal: subtotal,
                      tax: taxValue,
                      netTotal: grandTotal,
                      remarks: "",
                      createdFrom: "B2C",
                      isActive: true,
                      createdBy: b2CCustomerName,
                      createdOn: currentDate,
                      changedBy: "admin",
                      changedOn: currentDate,
                      status: 0,
                      customerShipToId: 0,
                      customerShipToAddress: "",
                      latitude: 0,
                      longitude: 0,
                      signatureimage: "",
                      cameraimage: "",
                      orderDetail: cartController.selectedItems
                          .map((e) => SalesOrderDetail(
                                orgId: 1,
                                orderNo: "",
                                slNo: e.slNo,
                                productCode: e.productCode,
                                productName: e.productName,
                                qty: e.qtycount.toInt(),
                                foc: 0,
                                price: e.sellingCost!.toInt(),
                                total:
                                    e.qtycount.toInt() * e.sellingCost!.toInt(),
                                itemDiscount: 0,
                                itemDiscountPerc: 0,
                                subTotal:
                                    e.qtycount.toInt() * e.sellingCost!.toInt(),
                                tax: taxValue.toInt(),
                                netTotal: (e.qtycount.toInt() *
                                        e.sellingCost!.toInt()) +
                                    (taxValue.toInt()),
                                taxCode: 0,
                                taxType: "E",
                                createdBy: "Admin",
                                taxPerc: e.taxPerc!.toInt(),
                                createdOn: currentDate,
                                changedBy: "Admin",
                                changedOn: currentDate,
                                weight: 0,
                                remarks: e.productImagePath,
                              ))
                          .toList(),
                    );
                    cartController.makePayment();
                  }
                } else {
                  Get.snackbar(
                    margin: const EdgeInsets.all(20),
                    backgroundColor: MyColors.red,
                    "",
                    "Please Select Delivery Address",
                    colorText: MyColors.white,
                    icon: const Icon(
                      Icons.emergency,
                      color: MyColors.white,
                    ),
                    duration: const Duration(seconds: 3),
                    snackPosition: SnackPosition.TOP,
                  );
                }
              },
              child: Text(
                'Place Order',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontFamily: MyFont.myFont,
                  fontSize: 16,
                  color: MyColors.white,
                ),
              )),
        ),
      );
    });
  }

  addAddress() {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 18),
      decoration: const BoxDecoration(
          color: MyColors.lightGreen2,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                Assets.location,
                scale: 0.8,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                "Select your delivery address",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontFamily: MyFont.myFont,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          SizedBox(height: height(context) / 50),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Padding(
          //       padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          //       child: ElevatedButton(
          //           style: ElevatedButton.styleFrom(
          //             shape: RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(5),
          //             ),
          //           ),
          //           onPressed: () {
          //             Get.toNamed(AppRoutes.enterAddressDetailsScreen);
          //           },
          //           child: Text(
          //             'Add address to proceed',
          //             style: TextStyle(
          //               fontWeight: FontWeight.w900,
          //               fontFamily: MyFont.myFont,
          //               fontSize: 16,
          //               color: MyColors.white,
          //             ),
          //           )),
          //     ),
          //   ],
          // ),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: InkWell(
                  onTap: () {
                    Get.offAndToNamed(AppRoutes.enterAddressDetailsScreen,
                        arguments: true);
                  },
                  child: Card(
                    color: MyColors.mainTheme,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Text(
                        " +Add ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: MyFont.myFont,
                          fontWeight: FontWeight.bold,
                          color: MyColors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          addressList()
        ],
      ),
    );
  }

  addressList() {
    return (cartController.addressList.value != null &&
            cartController.addressList.value?.length != 0)
        ? Container(
            height: 200,
            padding: const EdgeInsets.fromLTRB(0, 10, 15, 18),
            decoration: const BoxDecoration(
                color: MyColors.lightGreen2,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: ListView.builder(
              itemCount: cartController.addressList.value?.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final isSelected = index == selectedAddressIndex;
                final address = cartController.addressList.value?[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          // If the address is already selected, deselect it
                          selectedAddressIndex = -1;
                          cartController.selectedAddress.clear();
                        } else {
                          // If a different address is selected, update the selection
                          selectedAddressIndex = index;
                          cartController.selectedAddress.clear();
                          cartController.selectedAddress.add(address!);
                        }
                      });
                      sendSalesAddress =
                          "${cartController.selectedAddress.first.addressLine1},${cartController.selectedAddress.first.addressLine2},${cartController.selectedAddress.first.addressLine3},${cartController.selectedAddress.first.postalCode}";
                      print(sendSalesAddress);
                      print("cartController.selectedAddress.length");
                      print(cartController.selectedAddress.length);
                      print(cartController.selectedAddress.first.addressLine1);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.8,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color:
                                isSelected ? MyColors.mainTheme : Colors.black),
                        borderRadius: BorderRadius.circular(13.0),
                        color: isSelected
                            ? MyColors.mainTheme.withOpacity(0.2)
                            : Colors.white,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    cartController.RemoveDeliveryAddress(
                                        cartController.addressList.value![index]
                                            .customerId,
                                        cartController.addressList.value?[index]
                                            .deliveryId,
                                        cartController
                                            .addressList.value?[index].name);
                                  },
                                  icon: const Icon(Icons.delete)),
                            ],
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                            child: Text(
                              "${address?.addressLine1},${address?.addressLine2},${address?.addressLine3},${address?.postalCode}",
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontFamily:
                                    MyFont.myFont, // Replace with your font
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )

            // Expanded(
            //   child: ListView.builder(
            //   itemCount: 2,
            //   scrollDirection: Axis.horizontal,
            //   itemBuilder: (context, index) {
            //     return Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: Container(
            //         width: width(context)/1.8,
            //         decoration: BoxDecoration(border: Border.all(color: Colors.black,),borderRadius: BorderRadius.circular(13.0)),
            //         child: Padding(
            //           padding: const EdgeInsets.all(10.0),
            //           child: Text(
            //             "1/44, Kuppam road, Valimiki Nagar, Raja Garden, Kottivakkam, Chennai, Tamil nadu- 600041",
            //             style: TextStyle(
            //               fontWeight: FontWeight.normal,
            //               fontFamily: MyFont.myFont,
            //               fontSize: 16,
            //             ),
            //           ),
            //         ),
            //       ),
            //     );},
            //     ),
            // ),
            )
        : const Center(child: Text("Add your Delivery Address"));
  }

  // InkWell(
  //   onTap: () {
  //     Get.offAndToNamed(AppRoutes.enterAddressDetailsScreen);
  //   },
  //   child: Card(
  //     color: MyColors.mainTheme,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.all(Radius.circular(20)),
  //     ),
  //     child: Padding(
  //       padding: const EdgeInsets.symmetric(
  //           horizontal: 10, vertical: 5),
  //       child: Text(
  //         "Change",
  //         textAlign: TextAlign.center,
  //         style: TextStyle(
  //           fontFamily: MyFont.myFont,
  //           fontWeight: FontWeight.bold,
  //           color: MyColors.white,
  //           fontSize: 14,
  //         ),
  //       ),
  //     ),
  //   ),
  // ),

  cartList() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      child: ListView.builder(
        itemCount: cartController.selectedItems.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          // qtyTotal = cartController.selectedItems[index].qtycount.toDouble() *
          //     cartController.selectedItems[index].sellingCost!;
          qtyTotal = cartController.selectedItems[index].sellingCost!.toDouble();
          avgQtyTotal =
              cartController.selectedItems[index].qtycount.toDouble() *
                  cartController.selectedItems[index].averageCost!;
          slNo = index;

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(10, 25, 0, 5),
                decoration: BoxDecoration(
                  color: MyColors.background,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: (cartController.selectedItems[index].productImagePath !=
                        null)
                    ? ("${cartController.selectedItems[index].productImagePath}"
                            .isNotEmpty)
                        ? Image.network(
                            '${cartController.selectedItems[index].productImagePath}',
                            height: height(context) / 13,
                            width: width(context) / 4,
                          )
                        : Image.asset(
                            Assets.noImage,
                            height: height(context) / 13,
                            width: width(context) / 4,
                          )
                    : const Icon(Icons.error),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: width(context) / 1.55,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: width(context) / 3,
                                padding:
                                    const EdgeInsets.fromLTRB(20, 0, 10, 5),
                                child: Text(
                                  cartController
                                          .selectedItems[index].productName ??
                                      "",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontFamily: MyFont.myFont,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: MyColors.mainTheme,
                                  ),
                                ),
                              ),
                              // Container(
                              //   padding:
                              //       const EdgeInsets.fromLTRB(25, 0, 20, 0),
                              //   child: Text(
                              //     cartController.selectedItems[index].weight
                              //             ?.toStringAsFixed(0) ??
                              //         "",
                              //     style: TextStyle(
                              //       fontFamily: MyFont.myFont,
                              //       fontWeight: FontWeight.bold,
                              //       color: MyColors.grey,
                              //       fontSize: 12,
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 3,
                              bottom: 0,
                              right: 20,
                            ),
                            child: (cartController
                                        .selectedItems[index].qtycount ==
                                    0)
                                ? GestureDetector(
                                    onTap: () async {
                                      setState(() {
                                        setState(() {
                                          setState(() {
                                            cartController.cartService
                                                .addToCart(
                                                    product: cartController
                                                        .selectedItems[index]);
                                            cartController.updateProductCount();
                                          });

                                          cartController.selectedItems[index]
                                                  .isShowButtons =
                                              cartController
                                                  .selectedItems[index]
                                                  .isShowButtons;
                                        });
                                      });
                                      await PreferenceHelper.saveCartData(
                                          cartController.selectedItems);
                                    },
                                    child: Card(
                                      color: MyColors.mainTheme,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(6)),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 18, vertical: 8),
                                        child: Text(
                                          "Add",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: MyFont.myFont,
                                            fontWeight: FontWeight.bold,
                                            color: MyColors.white,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : Card(
                                    color: MyColors.mainTheme,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(6)),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 5.5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          GestureDetector(
                                            onTap: () async {
                                              setState(() {
                                                cartController.cartService
                                                    .removeFromCart(
                                                        product: cartController
                                                                .selectedItems[
                                                            index]);
                                                cartController
                                                    .updateProductCount();
                                              });
                                              await PreferenceHelper
                                                  .saveCartData(cartController
                                                      .selectedItems);
                                              checkEmptyCart(index: index);
                                            },
                                            child: Container(
                                              child: const Icon(
                                                Icons.remove,
                                                color: MyColors.white,
                                                size: 18,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: AnimatedSwitcher(
                                              duration: const Duration(
                                                  milliseconds: 300),
                                              transitionBuilder: (Widget child,
                                                  Animation<double> animation) {
                                                return ScaleTransition(
                                                    scale: animation,
                                                    child: child);
                                              },
                                              child: SizedBox(
                                                width: 20,
                                                child: Text(
                                                  '${cartController.selectedItems[index].qtycount.toInt()}',
                                                  key: ValueKey<int>(
                                                    cartController
                                                            .selectedItems[index]
                                                            .qtycount
                                                            .toInt() ??
                                                        0,
                                                  ),
                                                  style: TextStyle(
                                                    fontFamily: MyFont.myFont,
                                                    color: MyColors.white,
                                                    fontSize: 16,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              setState(() {
                                                cartController.cartService
                                                    .addToCart(
                                                        product: cartController
                                                                .selectedItems[
                                                            index]);
                                                cartController
                                                    .updateProductCount();
                                              });

                                              await PreferenceHelper
                                                  .saveCartData(cartController
                                                      .selectedItems);
                                            },
                                            child: Container(
                                              child: const Icon(
                                                Icons.add,
                                                color: MyColors.white,
                                                size: 18,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(23, 0, 20, 0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '\$ ${qtyTotal.toStringAsFixed(2) ?? ""}',
                            style: TextStyle(
                              fontFamily: MyFont.myFont,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: MyColors.mainTheme,
                            ),
                          ),
                          SizedBox(
                            width: width(context) / 40,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: Text(
                              '\$ ${qtyTotal.toStringAsFixed(2) ?? ""}',
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
          );
        },
      ),
    );
  }

  youMightAlsoLikeList() {
    return SizedBox(
      height: height(context) / 3,
      child: ListView.builder(
        itemCount: 4,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(left: 2, top: 2, bottom: 2, right: 2),
            width: width(context) / 2.4,
            child: Card(
                elevation: 5,
                shadowColor: MyColors.black,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          decoration: const BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  bottomRight: Radius.circular(5))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Text(
                              "30 % Off",
                              style: TextStyle(
                                fontFamily: MyFont.myFont,
                                fontWeight: FontWeight.bold,
                                color: MyColors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: GestureDetector(
                            onTap: () {
                              Get.toNamed(AppRoutes.favouriteScreen);
                            },
                            child: const Icon(
                              Icons.favorite,
                              color: MyColors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height(context) / 50),
                    GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.aboutProductScreen);
                        },
                        child: SizedBox(
                            child: Image.asset(
                          Assets.onion,
                          height: height(context) / 9,
                          width: width(context) / 5,
                        ))),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.fromLTRB(15, 5, 10, 5),
                      child: Text(
                        "Tomato",
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: MyFont.myFont,
                          fontWeight: FontWeight.w800,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(15, 0, 10, 3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '1000 g',
                            style: TextStyle(
                              fontFamily: MyFont.myFont,
                              fontWeight: FontWeight.bold,
                              color: MyColors.grey,
                              fontSize: 10,
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 5, 10, 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '100',
                                style: TextStyle(
                                  fontFamily: MyFont.myFont,
                                  color: MyColors.grey,
                                  decoration: TextDecoration.lineThrough,
                                  fontSize: 10,
                                ),
                              ),
                              Text(
                                '50',
                                style: TextStyle(
                                  fontFamily: MyFont.myFont,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: (cartController
                                      .selectedItems[index].qtycount ==
                                  0)
                              ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      cartController.selectedItems[index]
                                          .increment();
                                    });
                                  },
                                  child: Card(
                                    color: MyColors.mainTheme,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(6)),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 18, vertical: 8),
                                      child: Text(
                                        "Add",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: MyFont.myFont,
                                          fontWeight: FontWeight.bold,
                                          color: MyColors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Card(
                                  color: MyColors.mainTheme,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 5.5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              cartController
                                                  .selectedItems[index]
                                                  .decrement();
                                            });
                                            checkEmptyCart(index: index);
                                          },
                                          child: Container(
                                            child: const Icon(
                                              Icons.remove,
                                              color: MyColors.white,
                                              size: 18,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: AnimatedSwitcher(
                                            duration: const Duration(
                                                milliseconds: 300),
                                            transitionBuilder: (Widget child,
                                                Animation<double> animation) {
                                              return ScaleTransition(
                                                  scale: animation,
                                                  child: child);
                                            },
                                            child: SizedBox(
                                              width: 30,
                                              child: Text(
                                                '${cartController.selectedItems[index].qtycount.toInt()}',
                                                key: ValueKey<int>(
                                                  cartController
                                                          .selectedItems[index]
                                                          .qtycount
                                                          .toInt() ??
                                                      0,
                                                ),
                                                style: TextStyle(
                                                  fontFamily: MyFont.myFont,
                                                  color: MyColors.white,
                                                  fontSize: 16,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              cartController
                                                  .selectedItems[index]
                                                  .increment();
                                            });
                                            checkEmptyCart(index: index);
                                          },
                                          child: Container(
                                            child: const Icon(
                                              Icons.add,
                                              color: MyColors.white,
                                              size: 18,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                        ),
                      ],
                    )
                  ],
                )),
          );
        },
      ),
    );
  }

  showBarBottom() {
    Get.showSnackbar(
      const GetSnackBar(
        margin: EdgeInsets.all(10),
        borderRadius: 10,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.TOP,
        message: "Please select atleast one product",
        icon: Icon(
          Icons.error,
          color: Colors.white,
        ),
        duration: Duration(seconds: 3),
      ),
    );
  }

  Future<void> checkEmptyCart
      ({required index}) async {
    if (cartController.selectedItems[index].qtycount == 0) {
      cartController.selectedItems.removeAt(index);
    }
    await PreferenceHelper.saveCartData(cartController.selectedItems);
    if (cartController.selectedItems.isEmpty) {
      Get.back();
    }
  }
}
