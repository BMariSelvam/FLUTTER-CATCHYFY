import 'package:Catchyfive/Helper/NetworkManger.dart';
import 'package:Catchyfive/Helper/api.dart';
import 'package:Catchyfive/Helper/preferencehelper.dart';
import 'package:Catchyfive/Model/login/login_model.dart';
import 'package:Catchyfive/Model/order_model/order_list_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderController extends GetxController with StateMixin {
  RxInt counter = 0.obs;
  Rx<bool> isLoading = false.obs;
  Rx<List<OrderListModel>?> ordersModelList =
      (null as List<OrderListModel>?).obs;

  B2cLoginModel? loginUser;

  @override
  onInit() async {
    getOrderList();
    super.onInit();
  }

  getOrderList() async {
    isLoading.value = true;
    loginUser = await PreferenceHelper.getUserData();
    NetworkManager.get(
        url: HttpUrl.b2CCustomerOrderGetHeaderSearch,
        parameters: {
          "searchModel.organisationId": "${HttpUrl.org}",
          "searchModel.customerCode": loginUser?.b2CCustomerId,
        }).then((response) {
      isLoading.value = false;
      if (response.apiResponseModel != null &&
          response.apiResponseModel!.status) {
        if (response.apiResponseModel!.data != null) {
          List? resJson = response.apiResponseModel!.data!;
          if (resJson != null) {
            ordersModelList.value = (response.apiResponseModel!.data as List)
                .map((e) => OrderListModel.fromJson(e))
                .toList();
            change(ordersModelList);
          }
          change(null, status: RxStatus.success());
        } else {
          change(null, status: RxStatus.error());
          Get.showSnackbar(
            GetSnackBar(
              title: "Errrrrrrrrrror",
              message: response.apiResponseModel!.message ?? '',
              icon: const Icon(Icons.error),
              duration: const Duration(seconds: 3),
            ),
          );
        }
      }
    }).catchError((error) {
      change(null, status: RxStatus.error());
      Get.showSnackbar(
        GetSnackBar(
          title: "Error",
          message: error.toString(),
          icon: const Icon(Icons.error),
          duration: const Duration(seconds: 3),
        ),
      );
    });
  }
}
