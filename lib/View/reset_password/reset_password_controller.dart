import 'package:Catchyfive/Const/approutes.dart';
import 'package:Catchyfive/Helper/NetworkManger.dart';
import 'package:Catchyfive/Model/login/login_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Helper/api.dart';

import '../../../../Helper/preferenceHelper.dart';

class ResetPasswordController extends GetxController with StateMixin {
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

  B2cLoginModel? loginUser;

  changePassword() async {
    isLoading.value = true;
    loginUser = await PreferenceHelper.getUserData();
    NetworkManager.post(
      URl: HttpUrl.login,
      params: {
        "OrgId": HttpUrl.org,
        "BranchCode": "HO",
        "Username": loginUser?.emailId,
        "Password": enterCurrentPasswordController.text,
      },
    ).then((apiResponse) async {
      isLoading.value = false;
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.data != null &&
            (apiResponse.apiResponseModel!.data as List).isNotEmpty) {
          Map<String, dynamic>? customerJson =
              (apiResponse.apiResponseModel!.data! as List).first;

          if (customerJson != null) {
            print("LLLLLLLLLLLLLLLLL");
            changeConformPassword();
          } else {
            // PreferenceHelper.showSnackBar(
            //     context: Get.context!, msg: "Your Current password is wrong");
            Get.showSnackbar(
              const GetSnackBar(
                title: "Error",
                message: "Your Current password is wrong",
                icon: Icon(Icons.error),
                duration: Duration(seconds: 3),
              ),
            );
          }
        } else {
          // PreferenceHelper.showSnackBar(
          //     context: Get.context!, msg: "Your Current password is wrong");
          Get.showSnackbar(const GetSnackBar(
            title: "Error",
            message: "Your Current password is wrong",
            icon: Icon(Icons.error),
            duration: Duration(seconds: 3),
          ));
        }
      } else {
        // PreferenceHelper.showSnackBar(
        //     context: Get.context!, msg: apiResponse.error);
        Get.showSnackbar(const GetSnackBar(
          title: "Error",
          message: "",
          icon: Icon(Icons.error),
          duration: Duration(seconds: 3),
        ));
      }
    });
  }

  changeConformPassword() async {
    loginUser = await PreferenceHelper.getUserData();
    isLoading.value = true;
    update();
    NetworkManager.post(
      URl: HttpUrl.b2CCustomerRegisterEditProfilePassword,
      params: {
        "OrgId": HttpUrl.org,
        "B2CCustomerId": loginUser?.b2CCustomerId,
        "EmailId": loginUser?.emailId,
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
