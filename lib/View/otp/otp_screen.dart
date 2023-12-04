import 'dart:async';
import 'dart:convert';

import 'package:Catchyfive/Const/colors.dart';
import 'package:Catchyfive/Const/size.dart';
import 'package:Catchyfive/View/otp/otp_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';

import '../../Const/assets.dart';
import '../../Const/font.dart';
import '../../Helper/api.dart';
import '../../Widget/elevatedbutton.dart';
import '../forget_password/forgetpasswordcontroller.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late ContactDetailsController otpcontroller;

  late ForgetPasswordController controller;

  int start = 30;
  bool complete = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    otpcontroller = Get.put(ContactDetailsController());
    controller = Get.find<ForgetPasswordController>();
    startCountdowns();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContactDetailsController>(builder: (logic) {
      return Form(
        // key: controller.loginKey,
        child: Scaffold(
          backgroundColor: MyColors.white,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Container(
                    color: MyColors.white,
                    child: textFormField(),
                  ),
                  Container(
                    color: MyColors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: height(context) / 20),
                        SizedBox(
                          width: width(context) / 1.5,
                          child: OTPTextField(
                              controller: controller.otpController,
                              length: 4,
                              otpFieldStyle: OtpFieldStyle(
                                  focusBorderColor: MyColors.mainTheme),
                              style: TextStyle(color: Colors.black),
                              width: double.infinity,
                              textFieldAlignment: MainAxisAlignment.spaceAround,
                              fieldWidth: 35,
                              outlineBorderRadius: 15,
                              onChanged: (pin) {},
                              onCompleted: (pin) {
                                otpcontroller.otp = pin;
                              }),
                        ),
                        SizedBox(height: height(context) / 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.fromLTRB(40, 8, 40, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    // _callVerifyOtp(otp);
                  },
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Resend OTP in ",
                            style: TextStyle(
                              fontFamily: MyFont.myFont,
                              fontWeight: FontWeight.bold,
                              color: MyColors.black,
                            )),
                        (complete)
                            ? (otpcontroller.sendOtpLoading.value) ? Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: SizedBox(
                               height: 15,
                              width: 15,
                              child: CircularProgressIndicator()),
                            ) : ElevatedButton(
                                onPressed: () {
                                  print("1");
                                  setState(() {
                                    SendOTP();
                                  });
                                },
                                child: Text("Resend"))
                            : Text(
                                "${(start ~/ 60).toString().padLeft(2, '0')}:${(start % 60).toString().padLeft(2, '0')}",
                                style: TextStyle(
                                  fontFamily: MyFont.myFont,
                                  fontWeight: FontWeight.bold,
                                  color: MyColors.primaryCustom,
                                )),
                      ]),
                ),
                SizedBox(height: height(context) / 50),
                otpcontroller.isLoading.value == true
                    ? const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                        ],
                      )
                    : SubmitButton(
                        onTap: () {
                          //
                          // print("&&&&&&&& $otp");
                          // print("&&&&&&&& ${controller.otpValue}");
                          // Get.toNamed(AppRoutes.ResetPasswordScreen);
                          //
                          // if (otp == controller.otpController) {
                          //   Get.offAllNamed(AppRoutes.ResetPasswordScreen);
                          // } else {
                          //   Get.snackbar(
                          //     margin: const EdgeInsets.all(20),
                          //     backgroundColor: MyColors.red,
                          //     "",
                          //     "Invalid OTP",
                          //     colorText: MyColors.white,
                          //     icon: const Icon(
                          //       Icons.emergency,
                          //       color: MyColors.white,
                          //     ),
                          //     duration: const Duration(seconds: 3),
                          //     snackPosition: SnackPosition.TOP,
                          //   );
                          // }
                          if (otpcontroller.otp?.length == 4 &&
                              otpcontroller.otp != null) {
                            otpcontroller.VerifyOtp();
                          } else {
                            Get.snackbar(
                              margin: const EdgeInsets.all(20),
                              backgroundColor: MyColors.red,
                              "",
                              "please enter Otp",
                              colorText: MyColors.white,
                              icon: const Icon(
                                Icons.emergency,
                                color: MyColors.white,
                              ),
                              duration: const Duration(seconds: 3),
                              snackPosition: SnackPosition.TOP,
                            );
                          }
                        },
                        title: 'Verify',
                      ),
              ],
            ),
          ),
        ),
      );
    });
  }

  void startCountdowns() {
    const onsec = Duration(seconds: 1); // Change to seconds
    Timer.periodic(onsec, (Timer timer) {
      if (start == 0) {
        timer.cancel();
        setState(() {
          complete = true;
        });
      } else {
        setState(() {
          start--;
        });
      }
    });
  }

  ///TextFormField
  textFormField() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
              alignment: Alignment.center,
              child: Image.asset(
                Assets.otp,
                scale: 0.8,
              )),
          const SizedBox(height: 10),
          Text(
            'OTP Verification',
            style: TextStyle(
                fontFamily: MyFont.myFont,
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: MyColors.primaryCustom),
          ),
          const SizedBox(height: 10),
          Text(
            'An authentication code has been send to manivannan****@gmail.com',
            style: TextStyle(
                fontFamily: MyFont.myFont,
                fontWeight: FontWeight.w600,
                // fontSize: 25,
                color: MyColors.black),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  SendOTP() async {
    setState(() {
      otpcontroller.sendOtpLoading.value = true;
    });
    final String url =
        "${HttpUrl.base}/SendOTP/SendOTP?OrganizationId=${HttpUrl.org}&Email=${otpcontroller.email}";
    final response = await http.post(Uri.parse(url));
    setState(() {
      otpcontroller.sendOtpLoading.value = false;
    });
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print('Response data: ${data['Data']}');
      complete = false;
      start =30;
      startCountdowns();
    } else {
      print('POST request failed with status code: ${response.statusCode}');
      print('Response data: ${response.body}');
      // Handle errors and error responses here
    }
  }
}
