import 'package:Catchyfive/Const/colors.dart';
import 'package:Catchyfive/Model/login/login_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Const/approutes.dart';
import '../../Helper/NetworkManger.dart';
import '../../Helper/api.dart';
import '../../Helper/preferencehelper.dart';
import 'loginscreen.dart';

class LoginController extends GetxController with StateMixin {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxBool isPasswordVisible = false.obs;
  String? messages;
  B2cLoginModel? b2cLoginModel;
  bool isChecked = false;
  final loginKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;



  onLoginTapped() async {
    isLoading.value = true;
    change(null, status: RxStatus.loading());
    NetworkManager.post(URl: HttpUrl.login, params: {
      "OrgId": HttpUrl.org,
      "Username": emailController.text.trim(),
      "Password": passwordController.text.trim(),
      "BranchCode": "HO"
    }).then((apiResponse) async {
      isLoading.value = false;
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.data != null &&
            (apiResponse.apiResponseModel!.data as List).isNotEmpty) {
          Get.offAllNamed(AppRoutes.bottomNavBar);
          change(null, status: RxStatus.success());
          Map<String, dynamic>? customerJson =
              (apiResponse.apiResponseModel!.data! as List).first;

          if (customerJson != null) {
            await PreferenceHelper.saveUserData(customerJson)
                .then((value) async {
              Get.offAllNamed(AppRoutes.bottomNavBar);
            });
            await PreferenceHelper.saveEmail(key: "my_key", value: emailController.text);
          } else {
            change(null, status: RxStatus.error());
            Get.snackbar(
              "Error",
              "Customer data is empty!",
              margin: EdgeInsets.all(20),
              backgroundColor: MyColors.red,
              icon: const Icon(Icons.error),
              duration: const Duration(seconds: 3),
              snackPosition: SnackPosition.TOP,
            );
          }
        }
      } else {
        change(null, status: RxStatus.error());
        String? message = apiResponse.apiResponseModel?.message.toString();
        message = messages;
        print("API Response Message (Error): $message");

        Get.snackbar(
          margin: EdgeInsets.all(20),
          backgroundColor: MyColors.red,
          "Attention",
          message ?? "Your Username or Password are Incorrect",
          icon: const Icon(Icons.emergency),
          duration: const Duration(seconds: 3),
          snackPosition: SnackPosition.TOP,
        );
      }
    });
  }

}
