import 'package:Catchyfive/Const/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Const/approutes.dart';
import '../../Const/assets.dart';
import '../../Const/font.dart';

import '../../Const/validations.dart';
import '../../Widget/customtextformfield.dart';
import '../../Widget/elevatedbutton.dart';
import 'forgetpasswordcontroller.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  late ForgetPasswordController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(ForgetPasswordController());
  }



  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgetPasswordController>(builder: (logic)
    {
      return Form(
        key: controller.forgotPasswordKey,
        child: Scaffold(
          backgroundColor: MyColors.white,
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                textFormField(),
              ],
            ),
          ),
          bottomNavigationBar:  Padding (
            padding: const EdgeInsets.fromLTRB(40, 15, 40, 18),
            child: controller.sendOtpLoading.value == true
                ? const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
              ],
            )
                : SubmitButton(
              onTap: () {
                if (controller.forgetPasswordEmailController.text.isNotEmpty) {
                  controller.ExitingEmailCheck();
                } else {
                  Get.snackbar(
                    margin: const EdgeInsets.all(20),
                    backgroundColor: MyColors.lightGreen,
                    "Attention",
                    "Please enter the Email",
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
              title: 'Send OTP',
            ),
          ),
        ),
      );
    });
  }

  textFormField() {
    return Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
                alignment: Alignment.center,
                child: Image.asset(
                  Assets.forgetPassword,
                  scale: 0.8,
                )),
            const SizedBox(height: 10),
            Text(
              'Forget Password',
              style: TextStyle(
                  fontFamily: MyFont.myFont,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: MyColors.primaryCustom),
            ),
            const SizedBox(height: 10),
            Text(
              'Enter your Email ID to your password',
              style: TextStyle(
                  fontFamily: MyFont.myFont,
                  fontWeight: FontWeight.w600,
                  // fontSize: 25,
                  color: MyColors.black),
            ),
            const SizedBox(height: 20),
            CustomTextFormField(
              controller: controller.forgetPasswordEmailController,
              labelText: 'Email or Mobile No',
              labelTextStyle: TextStyle(fontFamily: MyFont.myFont),
              readOnly: false,
              obscureText: false,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              filled: true,
              inputFormatters: [
                AlphaNumericSplInputFormatter(),
              ],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Enter Your Email or Mobile No";
                } else {}
              },
            ),
          ],
        ),
      ),
    );
  }
}
