import 'package:Catchyfive/Const/font.dart';
import 'package:flutter/material.dart';

import '../Const/colors.dart';

class SubmitButton extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  const SubmitButton({super.key, required this.onTap, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            MyColors.buttonTheme,
            MyColors.mainTheme,
          ],
          begin: Alignment.topLeft, // Gradient start position
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10.0), // Button border radius
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.transparent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
          child: Text(
            title,
            style: TextStyle(
              fontFamily: MyFont.myFont,
              fontWeight: FontWeight.bold,
              color: MyColors.white,
            ),
          ),
        ),
      ),
    );
  }
}
