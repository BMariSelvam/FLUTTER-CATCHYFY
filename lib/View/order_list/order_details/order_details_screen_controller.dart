import 'package:Catchyfive/Helper/NetworkManger.dart';
import 'package:Catchyfive/Helper/preferencehelper.dart';
import 'package:Catchyfive/Model/login/login_model.dart';
import 'package:Catchyfive/Model/order_model/order_details/order_details_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Helper/api.dart';

class OrderDetailsController extends GetxController with StateMixin {
  Rx<bool> isLoading = false.obs;
  B2cLoginModel? loginUser;
  List<OrderDetailsModel> orderDetailsModel = [];

  getOrderDetailsList(String? orderNo) async {
    isLoading.value = true;
    loginUser = await PreferenceHelper.getUserData();
    try {
      NetworkManager.get(url: HttpUrl.b2CCustomerOrderGetByCode, parameters: {
        "OrganizationId": HttpUrl.org,
        "OrderNo": orderNo,
      }).then((response) {
        isLoading.value = false;
        if (response.apiResponseModel != null &&
            response.apiResponseModel!.status) {
          if (response.apiResponseModel!.data != null) {
            List? resJson = response.apiResponseModel!.data!;
            if (resJson != null) {
              orderDetailsModel = (response.apiResponseModel!.data as List)
                  .map((e) => OrderDetailsModel.fromJson(e))
                  .toList();
              print(orderDetailsModel.first.orderDetail?.length);
              print("orderDetailsModel.length===========");
              change(orderDetailsModel);
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
        }
      });
    } catch (error) {
      change(null, status: RxStatus.error());
      Get.showSnackbar(
        GetSnackBar(
          title: "Error",
          message: error.toString(),
          icon: const Icon(Icons.error),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }
}
