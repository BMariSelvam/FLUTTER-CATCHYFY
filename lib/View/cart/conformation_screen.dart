import 'dart:async';
import 'package:Catchyfive/Const/approutes.dart';
import 'package:Catchyfive/Const/assets.dart';
import 'package:Catchyfive/Const/colors.dart';
import 'package:Catchyfive/Const/font.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmingOrderScreen extends StatefulWidget {
  const ConfirmingOrderScreen({Key? key}) : super(key: key);

  @override
  State<ConfirmingOrderScreen> createState() => _ConfirmingOrderScreenState();
}

class _ConfirmingOrderScreenState extends State<ConfirmingOrderScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Timer(
        const Duration(seconds: 4),
        () => Get.offAllNamed(AppRoutes.bottomNavBar),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: 260,
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 18),
              margin: const EdgeInsets.fromLTRB(15, 10, 15, 0),
              decoration: const BoxDecoration(
                color: MyColors.lightGreen2,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 20, 15, 0),
                    child: Text(
                      'Confirming Order',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: MyFont.myFont,
                        fontWeight: FontWeight.w900,
                        fontSize: 15,
                        color: MyColors.black,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                    child: Image.asset(
                      Assets.Tickgif,
                      scale: 4,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                    child: Text(
                      'This might take up to a minutes.Please do not close the app.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: MyFont.myFont,
                        fontWeight: FontWeight.w900,
                        fontSize: 11,
                        color: MyColors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Image.asset(
            Assets.Orderget,
            scale: 1,
          ),
        ],
      ),
    );
  }
}
