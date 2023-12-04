import 'package:Catchyfive/Const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String? hintText;
  final TextStyle? hintTextStyle;
  final String? labelText;
  final TextStyle? labelTextStyle;
  final bool readOnly;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardInput;
  final AutovalidateMode autoValidateMode;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final VoidCallback? onSuffixIconPressed;
  final bool obscureText;
  final bool filled;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onFieldSubmitted;
  final FocusNode? focusNode;

  const CustomTextFormField({
    Key? key,
    required this.controller,
    this.hintText,
    this.hintTextStyle,
    this.labelText,
    this.labelTextStyle,
    required this.readOnly,
    this.inputFormatters,
    this.autoValidateMode = AutovalidateMode.onUserInteraction,
    this.validator,
    this.suffixIcon,
    this.onSuffixIconPressed,
    required this.obscureText,
    required this.filled,
    this.keyboardInput,
    this.onTap,
    this.onChanged,
    this.textInputAction,
    this.onFieldSubmitted,
    this.focusNode,
  }) : super(key: key);

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: widget.focusNode,
      onFieldSubmitted: widget.onFieldSubmitted,
      textInputAction: widget.textInputAction,
      onTap: widget.onTap,
      onChanged: widget.onChanged,
      controller: widget.controller,
      readOnly: widget.readOnly,
      inputFormatters: widget.inputFormatters,
      keyboardType: widget.keyboardInput,
      autovalidateMode: widget.autoValidateMode,
      obscureText: widget.obscureText,
      validator: widget.validator,
      decoration: InputDecoration(
        hintText: widget.hintText,
        labelText: widget.labelText,
        filled: widget.filled,
        fillColor: MyColors.greyForTextFormField,
        suffixIcon: widget.suffixIcon,
        contentPadding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide:
              const BorderSide(color: MyColors.border), // Outline border color
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(
              color: MyColors.primaryCustom), // Focused outline border color
        ),
      ),
    );
  }
}
