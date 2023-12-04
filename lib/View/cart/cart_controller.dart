import 'dart:async';
import 'dart:convert';
import 'package:Catchyfive/Const/approutes.dart';
import 'package:Catchyfive/Helper/NetworkManger.dart';
import 'package:Catchyfive/Helper/api.dart';
import 'package:Catchyfive/Helper/preferencehelper.dart';
import 'package:Catchyfive/Model/catagroy/ProductModel.dart';
import 'package:Catchyfive/Model/sales_order/sales_order.dart';
import 'package:Catchyfive/locator/cart_service.dart';
import 'package:Catchyfive/locator/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../Helper/constant.dart';
import '../../Model/address/address_model.dart';
import '../../Model/login/login_model.dart';

class CartController extends GetxController with StateMixin {
  final loginKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;
  late SalesOrder salesOrder;
  RxInt selectedIndex = 0.obs;
  List<ProductModel> selectedItems = [];
  Map<String,dynamic>? paymentIntent;
  final CartService cartService = getIt<CartService>();

  Rx<List<AddressModel>?> addressList = (null as List<AddressModel>?).obs;
  // AddressModel? selectedAddress;
  List<AddressModel> selectedAddress = [];
  B2cLoginModel? loginUser;

  // Rx<AddressModel?> selectedAddress = Rx<AddressModel?>(null);

  salesOrderApi() async {
    isLoading.value = true;
    int index = 1;
    salesOrder.orderDetail?.forEach((element) {
      element.slNo = index;
      index += 1;
    });
    NetworkManager.post(URl: HttpUrl.salesOrder, params: salesOrder.toJson())
        .then((apiResponse) async {
      isLoading.value = false;
      if (apiResponse.apiResponseModel != null) {
        if (apiResponse.apiResponseModel!.status) {
          selectedItems.clear();
          cartService.cartItems.clear();
          await PreferenceHelper.removeCartData();
          await Get.offAndToNamed(AppRoutes.confirmingOrderScreen);
          Timer(const Duration(seconds: 5), () async {
            cartService.clearCart();
            await PreferenceHelper.removeCartData()
                .then((value) => Get.offAndToNamed(AppRoutes.bottomNavBar));
          });
        } else {
          String? message = apiResponse.apiResponseModel?.message;
          PreferenceHelper.showSnackBar(context: Get.context!, msg: message);
        }
      } else {
        PreferenceHelper.showSnackBar(context: Get.context!, msg: apiResponse.error);
      }
    });
  }

  void updateProductCount() {
    for (var product in selectedItems) {
      cartService.cartItems.firstWhereOrNull((element) {
        if (element.productCode == product.productCode) {
          product.qtycount = element.qtycount;
          return true;
        } else {
          return false;
        }
      });
    }
  }


  Future<void> makePayment() async {
    try {
      //STEP 1: Create Payment Intent
      paymentIntent = await createPaymentIntent();

      //STEP 2: Initialize Payment Sheet
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentIntent!['client_secret'], //Gotten from payment intent
            style: ThemeMode.light,
            merchantDisplayName: 'santhosh',
            // googlePay: gpay
          ))
          .then((value) {});


      //STEP 3: Display Payment sheet
      displayPaymentSheet();
    } catch (err) {
      throw Exception(err);
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        showDialog(
            context: Get.context!,
            builder: (_) => const AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 100.0,
                  ),
                  SizedBox(height: 10.0),
                  Text("Payment Successful!"),
                ],
              ),
            ));
        salesOrderApi();
        paymentIntent = null;
      }).onError((error, stackTrace) {
        throw Exception(error);
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
      const AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
                Text("Payment Failed"),
              ],
            ),
          ],
        ),
      );
    } catch (e) {
      print('$e');
    }
  }

  createPaymentIntent() async {
    try {
      Map<String, dynamic> body = {
        'amount': "112",
        'currency': "SGD",
      };
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer ${Constant.STRIPE_SECRET}',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      print("============check==========");
      print("1111111${response.body}");
      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  getAddress() async {
    isLoading.value = true;
    loginUser = await PreferenceHelper.getUserData();
    await NetworkManager.get(
      url: HttpUrl.b2CCustomerDeliveryAddressGetAll,
      parameters: {
        "OrganizationId": HttpUrl.org,
        "CustomerId": loginUser?.b2CCustomerId
      },
    ).then((response) {
      isLoading.value = false;
      if (response.apiResponseModel != null &&
          response.apiResponseModel!.status) {
        if (response.apiResponseModel!.data != null) {
          List? resJson = response.apiResponseModel!.data!;
          if (resJson != null) {
            addressList.value = (response.apiResponseModel!.data as List)
                .map((e) => AddressModel.fromJson(e))
                .toList();
            change(addressList.value);
          }
          change(null, status: RxStatus.success());
        } else {
          change(null, status: RxStatus.error());
          Get.showSnackbar(
            GetSnackBar(
              title: "Error",
              message: response.apiResponseModel!.message ?? '',
              icon: const Icon(Icons.error),
              duration: const Duration(seconds: 3),
            ),
          );
        }
      } else {
        addressList.value?.length = 0;
        change(null, status: RxStatus.success());
        print("addressList.value?.length");
        print(addressList.value?.length);
      }
    }).catchError((error) {
      change(null, status: RxStatus.error());
      Get.showSnackbar(
        GetSnackBar(
          title: "ror",
          message: error.toString(),
          icon: const Icon(Icons.error),
          duration: const Duration(seconds: 3),
        ),
      );
    });
    print("addressList.value?.length");
    print(addressList.value?.length);
  }

  RemoveDeliveryAddress(String? b2CCustomerId,int? deliveryId, String? userName) async {
    change(null, status: RxStatus.loading());
    loginUser = await PreferenceHelper.getUserData();
    await NetworkManager.get(
      url: HttpUrl.removeDeliveryAddress,
      parameters: {
        "OrganizationId": HttpUrl.org,
        "CustomerId": b2CCustomerId,
        "DeliveryId": "${deliveryId}",
        "UserName" : userName
      },
    ).then((response) {
      change(null, status: RxStatus.success());
      if (response.apiResponseModel != null &&
          response.apiResponseModel!.status) {
        if (response.apiResponseModel!.data != null) {
          getAddress();
        } else {
          change(null, status: RxStatus.error());
          Get.showSnackbar(
            GetSnackBar(
              title: "Errrr",
              message: response.apiResponseModel!.message ?? '',
              icon: const Icon(Icons.error),
              duration: const Duration(seconds: 3),
            ),
          );
        }
      } else {
        addressList.value?.length = 0;
        change(null, status: RxStatus.success());
      }
    }).catchError((error) {
      change(null, status: RxStatus.error());
      Get.showSnackbar(
        GetSnackBar(
          title: "ror",
          message: error.toString(),
          icon: const Icon(Icons.error),
          duration: const Duration(seconds: 3),
        ),
      );
    });
  }


}
