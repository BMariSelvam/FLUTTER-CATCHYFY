import 'package:Catchyfive/Const/colors.dart';
import 'package:Catchyfive/Helper/preferencehelper.dart';
import 'package:Catchyfive/View/reset_password/reset_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Const/approutes.dart';
import '../../Const/assets.dart';
import '../../Const/font.dart';

import '../../Const/validations.dart';
import '../../Model/login/login_model.dart';
import '../../Widget/customtextformfield.dart';
import '../../Widget/elevatedbutton.dart';
import '../Login/logincontroller.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  late ResetPasswordController resetPasswordController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    resetPasswordController = Get.put(ResetPasswordController());
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: resetPasswordController.resetKey,
      child: Scaffold(
        backgroundColor: MyColors.white,
        appBar: AppBar(
          toolbarHeight: 70,
          backgroundColor: MyColors.mainTheme,
          iconTheme: const IconThemeData(color: MyColors.white),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Get.back();
            },
          ),
          title: Text(
            'Settings',
            style: TextStyle(
                fontFamily: MyFont.myFont,
                fontWeight: FontWeight.bold,
                color: MyColors.white),
          ),
          // actions: [
          //   Padding(
          //     padding: const EdgeInsets.all(15),
          //     child: GestureDetector(
          //       onTap: () {
          //         Get.toNamed(AppRoutes.ResetPasswordScreen);
          //       },
          //       child: const Icon(
          //         Icons.person,
          //         color: MyColors.white,
          //       ),
          //     ),
          //   ),
          // ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              textFormField(),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.fromLTRB(40, 8, 40, 50),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SubmitButton(
                onTap: () {
                  FocusScope.of(context).unfocus();
                  if (resetPasswordController.resetKey.currentState!.validate()) {
                    print("*****************");
                    if (resetPasswordController.enterNewPasswordController.text ==
                        resetPasswordController
                            .enterConfirmPasswordController.text) {
                      resetPasswordController.changePassword();
                    } else {
                      PreferenceHelper.showSnackBar(
                          context: Get.context!,
                          msg: "Missmatch NewPassword And ConfirmPassword");
                    }
                  }
                },
                title: 'Confirm',
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: ()  {
                    Get.toNamed(AppRoutes.ForgetPasswordScreen);
                  },
                  child: Text("Try another way",
                      style: TextStyle(
                        fontFamily: MyFont.myFont,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: MyColors.mainTheme,
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
                  Assets.ResetPassword,
                  scale: 0.8,
                )),
            const SizedBox(height: 10),
            Text(
              'Reset Password',
              style: TextStyle(
                  fontFamily: MyFont.myFont,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: MyColors.primaryCustom),
            ),
            const SizedBox(height: 10),
            Text(
              'Enter new password for your Account',
              style: TextStyle(
                  fontFamily: MyFont.myFont,
                  fontWeight: FontWeight.w600,
                  // fontSize: 25,
                  color: MyColors.black),
            ),
            const SizedBox(height: 20),
            CustomTextFormField(
              controller:
                  resetPasswordController.enterCurrentPasswordController,
              labelText: 'Enter Current Password',
              labelTextStyle: TextStyle(fontFamily: MyFont.myFont),
              readOnly: false,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              obscureText:
                  resetPasswordController.isPasswordVisibleCurrent.value
                      ? false
                      : true,
              filled: true,
              inputFormatters: const [
                // AlphaNumericSplInputFormatter(),
              ],
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      resetPasswordController.isPasswordVisibleCurrent.value =
                          !resetPasswordController
                              .isPasswordVisibleCurrent.value;
                    });
                  },
                  icon: Icon(
                      resetPasswordController.isPasswordVisibleCurrent.value
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined
                  )),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Enter Valid Password";
                } else if (value.length < 6) {
                  return "Password Should be 6 Character";
                }
              },
            ),
            const SizedBox(height: 20),
            CustomTextFormField(
              controller: resetPasswordController.enterNewPasswordController,
              labelText: 'Enter New Password',
              labelTextStyle: TextStyle(fontFamily: MyFont.myFont),
              readOnly: false,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              obscureText: resetPasswordController.isPasswordVisible.value
                  ? false
                  : true,
              filled: true,
              inputFormatters: const [
                // AlphaNumericSplInputFormatter(),
              ],
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      resetPasswordController.isPasswordVisible.value =
                          !resetPasswordController.isPasswordVisible.value;
                    });
                  },
                  icon: Icon(resetPasswordController.isPasswordVisible.value
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined
                  )),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Enter Valid Password";
                } else if (value.length < 6) {
                  return "Password Should be 6 Character";
                }
              },
            ),
            const SizedBox(height: 20),
            CustomTextFormField(
              controller:
                  resetPasswordController.enterConfirmPasswordController,
              labelText: 'Enter Confirm Password',
              labelTextStyle: TextStyle(fontFamily: MyFont.myFont),
              readOnly: false,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              obscureText:
                  resetPasswordController.isPasswordVisibleConfirm.value
                      ? false
                      : true,
              filled: true,
              inputFormatters: const [
                // AlphaNumericSplInputFormatter(),
              ],
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      resetPasswordController.isPasswordVisibleConfirm.value =
                          !resetPasswordController
                              .isPasswordVisibleConfirm.value;
                    });
                  },
                  icon: Icon(
                      resetPasswordController.isPasswordVisibleConfirm.value
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined
                  )),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Enter Valid Password";
                } else if (value.length < 6) {
                  return "Password Should be 6 Character";
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
