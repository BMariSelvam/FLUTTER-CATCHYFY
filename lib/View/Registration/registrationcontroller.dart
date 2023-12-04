import 'dart:convert';

import 'package:Catchyfive/Const/colors.dart';
import 'package:Catchyfive/Model/%20b2c_customer_Reg/B2CCustomerRegModel.dart';
import 'package:Catchyfive/Model/%20b2c_customer_Reg/postal_code_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';

import '../../Const/approutes.dart';
import '../../Helper/NetworkManger.dart';
import '../../Helper/api.dart';
import '../../Helper/preferencehelper.dart';

class RegistrationController extends GetxController with StateMixin {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  TextEditingController addressLine1Controller = TextEditingController();
  TextEditingController addressLine2Controller = TextEditingController();
  TextEditingController addressLine3Controller = TextEditingController();
  final OtpFieldController _otpController = OtpFieldController();

  final registrationKey = GlobalKey<FormState>();

  RxBool isLoading = false.obs;
  RxBool isPasswordVisible = false.obs;
  String? otpValue;
  B2cCustomerRegModel? b2cCustomerRegModel;
  RxBool fetchIsLoading = false.obs;
  RxBool sendOtpLoading = false.obs;
  List<PostalModel> postalModel = [];
  RxBool verifyOTP = false.obs;

  ExitingEmailCheck() async {
    NetworkManager.get(url: HttpUrl.ExitingEmaiRegister, parameters: {
      "OrganizationId": "${HttpUrl.org}",
      "EmailId": emailController.text
    }).then((response) {
      change(null, status: RxStatus.success());
      if (response.apiResponseModel != null &&
          response.apiResponseModel!.status) {
        if (response.apiResponseModel!.data != null) {
          List? resJson = response.apiResponseModel!.data!;
          if (resJson != null) {
            if (response.apiResponseModel!.data![0]['B2CCustomerId'] == null) {
              SendOTP(true);
            } else {
              Get.snackbar(
                "Alert",
                "Email already Registered",
                margin: EdgeInsets.all(20),
                backgroundColor: MyColors.lightGreen4,
                duration: const Duration(seconds: 3),
                snackPosition: SnackPosition.TOP,
              );
            }
            change(null, status: RxStatus.success());
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

  SendOTP(bool isResend) async {
    sendOtpLoading.value = true;
    // final String url = "https://stupefied-mirzakhani.154-26-130-251.plesk.page/SendOTP/SendOTP?OrganizationId=${HttpUrl.org}&Email=${emailController.text}";
    final String url =
        "${HttpUrl.base}/SendOTP/SendOTP?OrganizationId=${HttpUrl.org}&Email=${emailController.text}";
    final response = await http.post(Uri.parse(url));
    sendOtpLoading.value = false;
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      otpValue = data['Data'];
      print('POST request successful${otpValue}');
      print('Response data: ${data['Data']}');

      if (isResend) {
        sendOtpLoading.value = false;
        showOtpPopUp();
      }
      // You can parse and handle the response here
    } else {
      print('POST request failed with status code: ${response.statusCode}');
      print('Response data: ${response.body}');
      // Handle errors and error responses here
    }
  }

  onRegister() async {
    isLoading.value = true;
    NetworkManager.post(
            URl: HttpUrl.createCustomerRegister,
            params: b2cCustomerRegModel?.toJson())
        .then((apiResponse) async {
      isLoading.value = false;
      if (apiResponse.apiResponseModel != null) {
        if (apiResponse.apiResponseModel!.status) {
          print(apiResponse.apiResponseModel!.status);
          Get.offAllNamed(AppRoutes.RegistrationSuccessfullyScreen);
        } else {
          String? message = apiResponse.apiResponseModel?.message;
          PreferenceHelper.showSnackBar(context: Get.context!, msg: message);
        }
      } else {
        PreferenceHelper.showSnackBar(
            context: Get.context!, msg: apiResponse.error);
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
      print(response.body);
      final jsonData = json.decode(response.body);
      postalModel = (jsonData['results'] as List)
          .map((e) => PostalModel.fromJson(e))
          .toList();
      addressLine1Controller.text =
          "${postalModel.first.BLKNO},${postalModel.first.ROADNAME}";
      addressLine2Controller.text = (postalModel.first.BUILDING! == "NIL")
          ? ""
          : postalModel.first.BUILDING!;
      // addressLine3Controller.text = postalModel.first.BUILDING!;
      change(postalModel);
      change(null, status: RxStatus.success());
      print(postalModel.first.ADDRESS);
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

  showOtpPopUp() {
    showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (BuildContext context) {
          String? otp;
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            content: Padding(
              padding: const EdgeInsets.symmetric(vertical: 1),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      'Email OTP',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    const SizedBox(height: 10),
                    OTPTextField(
                        controller: _otpController,
                        length: 4,
                        otpFieldStyle:
                            OtpFieldStyle(focusBorderColor: MyColors.mainTheme),
                        style: TextStyle(color: Colors.black),
                        width: double.infinity,
                        textFieldAlignment: MainAxisAlignment.spaceAround,
                        fieldWidth: 35,
                        outlineBorderRadius: 15,
                        onChanged: (pin) {},
                        onCompleted: (pin) {
                          otp = pin;
                        }),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 25.0, right: 25, top: 20, bottom: 8),
                      child: ElevatedButton(
                          onPressed: () {
                            print("&&&&&&&& $otp");
                            print("!!!!! $otpValue");
                            if (otp == otpValue) {
                              verifyOTP.value = true;
                              change(null, status: RxStatus.success());
                            } else {
                              Get.snackbar(
                                margin: const EdgeInsets.all(20),
                                backgroundColor: MyColors.red,
                                "",
                                "Invalied OTP",
                                colorText: MyColors.white,
                                icon: const Icon(
                                  Icons.emergency,
                                  color: MyColors.white,
                                ),
                                duration: const Duration(seconds: 3),
                                snackPosition: SnackPosition.TOP,
                              );
                            }
                            Navigator.pop(context);
                          },
                          child: Text((verifyOTP.value == false)
                              ? 'Verify'
                              : "Success")),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                            onPressed: () {
                              SendOTP(false);
                              Get.snackbar(
                                margin: const EdgeInsets.all(20),
                                backgroundColor: MyColors.lightGreen4,
                                "",
                                "Resented OTP",
                                colorText: MyColors.black,
                                icon: const Icon(
                                  Icons.emergency,
                                  color: MyColors.black,
                                ),
                                duration: const Duration(seconds: 3),
                                snackPosition: SnackPosition.TOP,
                              );
                            },
                            child: const Text(
                              'Resend',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 20),
                            )),
                        GestureDetector(
                          onTap: () {
                            sendOtpLoading = false.obs;
                            Navigator.pop(context);
                            change(sendOtpLoading);
                          },
                          child: const Text("Cancel",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                  color: MyColors.mainTheme)),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
