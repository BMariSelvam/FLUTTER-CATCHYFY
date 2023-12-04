// ignore_for_file: file_names

import 'package:Catchyfive/Const/colors.dart';
import 'package:Catchyfive/Const/font.dart';
import 'package:flutter/material.dart';

class SearchTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? labelText;
  final String? hintText;
  final Function()? onTap;

  final TextInputType? keyboardType;
  final bool obscureText = false;
  final InputBorder inputBorder;
  final Color fillColor;
  final readOnly = false;

  const SearchTextField({
    super.key,
    this.validator,
    this.suffixIcon,
    this.labelText,
    this.keyboardType,
    required this.controller,
    obscureText = false,
    readOnly = false,
    required this.inputBorder,
    this.hintText,
    this.prefixIcon,
    this.onTap,
    required this.fillColor,
  });

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      margin: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: TextFormField(readOnly:widget.readOnly ,
        controller: widget.controller,
        validator: widget.validator,
        onTap: widget.onTap,
        style: TextStyle(
          fontSize: 13,
          color: MyColors.black,
          fontFamily: MyFont.myFont,
          fontWeight: FontWeight.w600,
        ),
        decoration: InputDecoration(
          fillColor: widget.fillColor,
          hintStyle: TextStyle(
              decoration: TextDecoration.none,
              fontFamily: MyFont.myFont,
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: MyColors.border),
          hintText: widget.hintText,
          border: widget.inputBorder,
          contentPadding:
              const EdgeInsets.only(top: 13, bottom: 10, left: 20, right: 15),
          suffixIcon: widget.suffixIcon,
          prefixIcon: widget.prefixIcon,
          labelText: widget.labelText,
          labelStyle: TextStyle(
            color: MyColors.mainTheme,
            fontSize: 13,
            fontFamily: MyFont.myFont,
            fontWeight: FontWeight.w900,
          ),
        ),
        keyboardType: widget.keyboardType,
        obscureText: widget.obscureText,
      ),
    );
  }
}
