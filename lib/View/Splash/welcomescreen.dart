import 'dart:async';

import 'package:Catchyfive/Const/approutes.dart';
import 'package:Catchyfive/Const/font.dart';
import 'package:Catchyfive/Helper/preferencehelper.dart';
import 'package:Catchyfive/Model/login/login_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Const/assets.dart';
import '../../Const/colors.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  var b2cCustomer;
  B2cLoginModel? b2cLoginModel;

  @override
  void initState() {
    super.initState();
    _initialiseData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Timer(
          const Duration(seconds: 1),
          () => (b2cLoginModel != null)
              ? Get.offAllNamed(AppRoutes.bottomNavBar)
              : Get.offAllNamed(AppRoutes.login));
    });
  }

  _initialiseData() async {
    b2cLoginModel = await PreferenceHelper.getUserData();
    setState(() {
      b2cCustomer = b2cLoginModel?.b2CCustomerId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(Assets.welcomeGif),
            const SizedBox(height: 30),
            Text(
              'Welcome..!',
              style: TextStyle(
                fontFamily: MyFont.myFont,
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: MyColors.primaryCustom,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
