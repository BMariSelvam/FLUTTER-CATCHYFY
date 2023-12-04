import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';

import '../../Const/approutes.dart';
import '../../Const/colors.dart';
import '../../Helper/NetworkManger.dart';
import '../../Helper/api.dart';
import 'package:http/http.dart' as http;

class ForgetPasswordController extends GetxController with StateMixin {
  RxBool sendOtpLoading = false.obs;
  String? otpValue;
  RxBool verifyOTP = false.obs;

  final forgotPasswordKey = GlobalKey<FormState>();

  TextEditingController forgetPasswordEmailController = TextEditingController();
  final OtpFieldController otpController = OtpFieldController();

  ExitingEmailCheck() async {
    sendOtpLoading.value = true;
    change(null, status: RxStatus.loading());
    NetworkManager.get(url: HttpUrl.ExitingEmaiRegister, parameters: {
      "OrganizationId": "${HttpUrl.org}",
      "EmailId": forgetPasswordEmailController.text
    }).then((response) {
      if (response.apiResponseModel != null &&
          response.apiResponseModel!.status) {
        if (response.apiResponseModel!.data != null) {
          List? resJson = response.apiResponseModel!.data!;
          if (resJson != null) {
            if (response.apiResponseModel!.data![0]['B2CCustomerId'] == null) {
              sendOtpLoading.value = false;
              change(null, status: RxStatus.success());
              Get.snackbar(
                "Alert",
                "User doesn't Exist",
                margin: const EdgeInsets.all(20),
                backgroundColor: MyColors.lightGreen4,
                duration: const Duration(seconds: 3),
                snackPosition: SnackPosition.TOP,
              );
            } else {
              SendOTP();
            }
            return;
          }
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

  SendOTP() async {
    // final String url = "https://stupefied-mirzakhani.154-26-130-251.plesk.page/SendOTP/SendOTP?OrganizationId=${HttpUrl.org}&Email=${emailController.text}";
    final String url =
        "${HttpUrl.base}/SendOTP/SendOTP?OrganizationId=${HttpUrl.org}&Email=${forgetPasswordEmailController.text}";
    final response = await http.post(Uri.parse(url));
    sendOtpLoading.value = false;
    change(null, status: RxStatus.success());
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      otpValue = data['Data'];
      print('POST request successful${otpValue}');
      print('Response data: ${data['Data']}');
        Get.toNamed(AppRoutes.OtpScreen,arguments: forgetPasswordEmailController.text);
      // You can parse and handle the response here
    } else {
      print('POST request failed with status code: ${response.statusCode}');
      print('Response data: ${response.body}');
      // Handle errors and error responses here
    }
  }


}
