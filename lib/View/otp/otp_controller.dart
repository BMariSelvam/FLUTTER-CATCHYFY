import 'dart:convert';

import 'package:Catchyfive/Const/approutes.dart';
import 'package:Catchyfive/Helper/preferencehelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Const/colors.dart';
import '../../Helper/NetworkManger.dart';
import '../../Helper/api.dart';


class ContactDetailsController extends GetxController with StateMixin {
  final loginKey = GlobalKey<FormState>();
  final TextEditingController otpController = TextEditingController();
  String? otp;
  RxBool sendOtpLoading = false.obs;
  RxBool isLoading = false.obs;
  String? messages;

String? email;
  @override
  void onInit() {
    super.onInit();
    email =Get.arguments as String;
  }

  VerifyOtp() async {
    isLoading.value = true;
    change(null, status: RxStatus.loading());
    NetworkManager.post(URl: HttpUrl.verifyOtp, params: {
      "OrgId": HttpUrl.org,
      "Email":email,
      "OTP": otp,
    }).then((apiResponse) async {
      isLoading.value = false;
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        Get.offAllNamed(AppRoutes.forgotPAsswordScreen,arguments: email);
        change(null, status: RxStatus.success());
      } else {
        change(null, status: RxStatus.error());
        String? message = apiResponse.apiResponseModel?.message.toString();
        message = messages;
        Get.snackbar(
          margin: const EdgeInsets.all(20),
          backgroundColor: MyColors.red,
          "",
          "Invalid OTP",
          colorText: MyColors.white,
          icon: const Icon(
            Icons.emergency,
            color: MyColors.white,
          ),
          duration: const Duration(seconds: 3),
          snackPosition: SnackPosition.TOP,
        );
      }
    });
  }


  void callVerifyOtp(String otp, BuildContext context) {
    if (otp == "1111") {
      Get.toNamed(AppRoutes.RegistrationSuccessfullyScreen);
    } else {
      otpController.clear();
      PreferenceHelper.showSnackBar(context: context, msg: "Invalid OTP");
    }
  }
}
