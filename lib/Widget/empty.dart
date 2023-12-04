import 'package:Catchyfive/Const/assets.dart';
import 'package:Catchyfive/Const/colors.dart';
import 'package:Catchyfive/Const/font.dart';
import 'package:Catchyfive/Const/size.dart';
import 'package:flutter/material.dart';

class EmptyAddress extends StatelessWidget {
  const EmptyAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Image.asset(Assets.empty),
            ),
            Container(
              width: width(context) / 1.5,
              padding: const EdgeInsets.all(20),
              child: Text(
                'No Address Added',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: MyFont.myFont,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: MyColors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EmptyList extends StatelessWidget {
  const EmptyList({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Image.asset(Assets.empty),
            ),
            Container(
              width: width(context) / 1.5,
              padding: const EdgeInsets.all(20),
              child: Text(
                'No order found',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: MyFont.myFont,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: MyColors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
