import 'package:Catchyfive/Const/colors.dart';
import 'package:Catchyfive/Helper/preferencehelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Const/assets.dart';
import '../../Const/font.dart';

import '../../Widget/customtextformfield.dart';
import '../../Widget/elevatedbutton.dart';
import 'ForgotPAsswordScreenController.dart';

class ForgotPAsswordScreen extends StatefulWidget {
  const ForgotPAsswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPAsswordScreen> createState() => _ForgotPAsswordScreenState();
}

class _ForgotPAsswordScreenState extends State<ForgotPAsswordScreen> {
  late ForgotPasswordScreenController resetPasswordController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    resetPasswordController = Get.put(ForgotPasswordScreenController());
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: resetPasswordController.resetKey,
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
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.fromLTRB(40, 8, 40, 50),
          child: SubmitButton(
            onTap: () {
              FocusScope.of(context).unfocus();
              if (resetPasswordController.resetKey.currentState!.validate()) {
                print("*****************");
                if (resetPasswordController.enterNewPasswordController.text ==
                    resetPasswordController
                        .enterConfirmPasswordController.text) {
                  resetPasswordController.changeConformPassword();
                } else {
                  PreferenceHelper.showSnackBar(
                      context: Get.context!,
                      msg: "Missmatch NewPassword And ConfirmPassword");
                }
              }
            },
            title: 'Confirm',
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
              'Forget Password',
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
              controller: resetPasswordController.enterNewPasswordController,
              labelText: 'Enter New Password',
              labelTextStyle: TextStyle(fontFamily: MyFont.myFont),
              readOnly: false,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              obscureText: resetPasswordController.isPasswordVisible.value
                  ? true
                  : false,
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
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined)),
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
                  ? true
                  : false,
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
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined)),
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
