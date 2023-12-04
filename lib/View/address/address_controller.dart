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

class LocationFetchController extends GetxController with StateMixin {
  TextEditingController postalCodeController = TextEditingController();
  TextEditingController address1 = TextEditingController();
  TextEditingController address2 = TextEditingController();
  TextEditingController address3 = TextEditingController();


  RxBool isLoading = false.obs;
  RxBool createIsLoading = false.obs;
  Rx<List<AddressModel>?> addressList = (null as List<AddressModel>?).obs;
  B2cLoginModel? loginUser;
  CreateAddress? createAddress;
  String? messages;

  RxBool fetchIsLoading = false.obs;
  List<PostalModel> postalModel = [];

  bool iscart = false;

  @override
  void onInit() {
    super.onInit();
    iscart = Get.arguments as bool;
  }

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

  createPostAddress() async {
    change(null, status: RxStatus.loading());
    print("lllllllllllll");
    await NetworkManager.post(
            URl: HttpUrl.b2CCustomerDeliveryAddressCreate,
            params: createAddress?.toJson())
        .then((apiResponse) async {
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        print("mmmmmmmmmmmm");
        print(apiResponse.apiResponseModel!.status);
        Get.snackbar(
          margin: EdgeInsets.all(20),
          backgroundColor: MyColors.mainTheme.withOpacity(0.5),
          "Success",
          "address successfully added",
          colorText: MyColors.black,
          icon: const Icon(Icons.task_alt_rounded),
          duration: const Duration(seconds: 3),
          snackPosition: SnackPosition.TOP,
        );
        if  (iscart ==  false) {
          Get.offAllNamed(AppRoutes.addressScreen);
        }
        if  (iscart ==  true) {
          Get.offAllNamed(AppRoutes.cartScreen);
        }
        // Get.offNamed(AppRoutes.addressScreen);
        change(null, status: RxStatus.success());
      } else {
        change(null, status: RxStatus.error());
        String? message = apiResponse.apiResponseModel?.message.toString();
        message = messages;
        Get.snackbar(
          margin: EdgeInsets.all(20),
          backgroundColor: MyColors.red,
          "Attention",
          message ?? apiResponse.apiResponseModel!.message.toString(),
          icon: const Icon(Icons.emergency),
          duration: const Duration(seconds: 3),
          snackPosition: SnackPosition.TOP,
        );
      }
    });
  }

  getPostal(String postalNo) async {
    fetchIsLoading.value = true;
    final Uri url = Uri.parse(
        "https://developers.onemap.sg/commonapi/search?searchVal=%22$postalNo%22&returnGeom=N&getAddrDetails=Y");
    fetchIsLoading.value = false;
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      if (jsonData != null) {
        postalModel = (jsonData['results'] as List)
            .map((e) => PostalModel.fromJson(e))
            .toList();
        address1.text = "${postalModel.first.BLKNO},${postalModel.first.ROADNAME}";
        address2.text = (postalModel.first.BUILDING!   == "NIL") ? "" :postalModel.first.BUILDING!;
        // landmarkAreaNameController.text = postalModel.first.BUILDING!;
        // if (landmarkAreaNameController.text == null &&
        //     landmarkAreaNameController.text == "NIl") {
        //   landmarkAreaNameController.text = "";
        // } else {
        //   landmarkAreaNameController.text = postalModel.first.BUILDING!;
        // }
        change(postalModel);
      }
      change(null, status: RxStatus.success());
    } else {
      change(null, status: RxStatus.error());
      Get.snackbar(
        margin: const EdgeInsets.all(20),
        backgroundColor: MyColors.red,
        "Attention",
        "Please enter postal code",
        icon: const Icon(Icons.emergency),
        duration: const Duration(seconds: 3),
        snackPosition: SnackPosition.TOP,
      );
    }
  }
}
