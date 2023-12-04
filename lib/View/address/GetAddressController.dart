import 'dart:async';
import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:Catchyfive/Const/approutes.dart';
import 'package:Catchyfive/Const/colors.dart';
import 'package:Catchyfive/Helper/NetworkManger.dart';
import 'package:Catchyfive/Helper/api.dart';
import 'package:Catchyfive/Helper/constant.dart';
import 'package:Catchyfive/Helper/preferencehelper.dart';
import 'package:Catchyfive/Model/%20b2c_customer_Reg/postal_code_model.dart';
import 'package:Catchyfive/Model/address/address_model.dart';
import 'package:Catchyfive/Model/address/create_address_model.dart';
import 'package:Catchyfive/Model/address/create_address_model.dart';
import 'package:Catchyfive/Model/login/login_model.dart';
import 'package:Catchyfive/Model/sales_order/sales_order.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../Model/address/create_address_model.dart';

class GetAddressController extends GetxController with StateMixin {


  // TextEditingController floorController = TextEditingController();
  // TextEditingController unitNoController = TextEditingController();
  // TextEditingController addressController = TextEditingController();
  // TextEditingController landmarkAreaNameController = TextEditingController();
  // TextEditingController addAddressLabelController = TextEditingController();

  RxBool isLoading = false.obs;
  RxBool isDelete = false.obs;
  RxBool createIsLoading = false.obs;
  Rx<List<AddressModel>?> addressList = (null as List<AddressModel>?).obs;
  B2cLoginModel? loginUser;
  CreateAddress? createAddress;




  getAddress() async {
    isLoading.value = true;
    change(null, status: RxStatus.loading());
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



  RemoveDeliveryAddress(String? b2CCustomerId,int? deliveryId, String? userName) async {
    isDelete.value = true;
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
      isDelete.value = false;
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
