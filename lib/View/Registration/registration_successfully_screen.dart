import 'dart:async';

import 'package:Catchyfive/Const/colors.dart';
import 'package:Catchyfive/Const/size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Const/approutes.dart';
import '../../Const/assets.dart';
import '../../Const/font.dart';

import '../../Const/validations.dart';
import '../../Widget/customtextformfield.dart';
import '../../Widget/elevatedbutton.dart';

class RegistrationSuccessfullyScreen extends StatefulWidget {
  const RegistrationSuccessfullyScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationSuccessfullyScreen> createState() =>
      _RegistrationSuccessfullyScreenState();
}

class _RegistrationSuccessfullyScreenState
    extends State<RegistrationSuccessfullyScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Timer(
        const Duration(seconds: 4),
        () => Get.offAllNamed(AppRoutes.login),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: height(context) / 10,
            ),
            Align(
                alignment: Alignment.center,
                child: Image.asset(Assets.successfully)),
            SizedBox(
              height: height(context) / 50,
            ),
            Text(
              "Registration Successfully..! ",
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontFamily: MyFont.myFont,
                  fontSize: 19,
                  color: MyColors.mainTheme),
            ),
            SizedBox(
              height: height(context) / 50,
            ),
            Image.asset(
              Assets.Tickgif,
              scale: 3,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(40, 8, 40, 50),
        child: SubmitButton(
          onTap: () {
            Get.offAllNamed(AppRoutes.login);
          },
          title: 'Go to Login',
        ),
      ),
    );
  }
}
