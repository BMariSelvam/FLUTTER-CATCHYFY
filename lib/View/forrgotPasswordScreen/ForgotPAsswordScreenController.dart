import 'package:Catchyfive/Const/approutes.dart';
import 'package:Catchyfive/Helper/NetworkManger.dart';
import 'package:Catchyfive/Model/login/login_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Helper/api.dart';

import '../../../../Helper/preferenceHelper.dart';

class ForgotPasswordScreenController extends GetxController with StateMixin {
  RxBool isLoading = false.obs;

  final resetKey = GlobalKey<FormState>();

  TextEditingController enterCurrentPasswordController =
  TextEditingController();
  TextEditingController enterNewPasswordController = TextEditingController();
  TextEditingController enterConfirmPasswordController =
  TextEditingController();

  RxBool isPasswordVisible = false.obs;
  RxBool isPasswordVisibleConfirm = false.obs;
  RxBool isPasswordVisibleCurrent = false.obs;



  String? email;
  @override
  void onInit() {
    super.onInit();
    email =Get.arguments as String;
  }


  changeConformPassword() async {
    isLoading.value = true;
    update();
    NetworkManager.post(
      URl: HttpUrl.b2CCustomerRegisterEditProfilePassword,
      params: {
        "OrgId": HttpUrl.org,
        "B2CCustomerId": "",
        "EmailId": email,
        "Password": enterConfirmPasswordController.text,
      },
    ).then((apiResponse) async {
      isLoading.value = false;
      change(null, status: RxStatus.success());
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.status) {
          await PreferenceHelper.clearUserData();
          Get.offAllNamed(AppRoutes.login);
        } else {
          change(null, status: RxStatus.error());
          String? message = apiResponse.apiResponseModel?.message;
          PreferenceHelper.showSnackBar(context: Get.context!, msg: message);
        }
      } else {
        change(null, status: RxStatus.error());
        PreferenceHelper.showSnackBar(
            context: Get.context!, msg: apiResponse.error);
      }
    });
  }
}
