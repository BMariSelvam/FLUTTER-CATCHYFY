import 'package:Catchyfive/Const/colors.dart';
import 'package:Catchyfive/Const/size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Const/approutes.dart';
import '../../Const/assets.dart';
import '../../Const/font.dart';
import '../../Const/validations.dart';
import '../../Widget/customtextformfield.dart';
import '../../Widget/elevatedbutton.dart';
import 'logincontroller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginController controller;
  final focus = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(LoginController());
    loadUserEmailPassword();
    // controller.emailController.text = "mariselvam.appxperts@gmail.com";
    // controller.passwordController.text = "maari";
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.loginKey,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              textFormField(),
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 15, 40, 18),
                child: controller.isLoading.value == true
                    ? const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                        ],
                      )
                    : SubmitButton(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          if (controller.loginKey.currentState!.validate()) {
                            controller.loginKey.currentState?.save();
                            controller.onLoginTapped();
                          } else {
                            print("Fields are Empty");
                          }
                        },
                        title: 'Log In',
                      ),
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.registration);
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 18),
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: "Don't have an account? ",
                        style: TextStyle(
                          fontFamily: MyFont.myFont,
                          fontWeight: FontWeight.bold,
                          color: MyColors.black,
                        )),
                    const WidgetSpan(child: SizedBox(width: 8)),
                    TextSpan(
                        text: "Create Account",
                        style: TextStyle(
                          fontFamily: MyFont.myFont,
                          fontWeight: FontWeight.bold,
                          color: MyColors.primaryCustom,
                        )),
                  ])),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///TextFormField
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
                  Assets.login,
                  scale: 0.8,
                )),
            const SizedBox(height: 10),
            Text(
              'Log in',
              style: TextStyle(
                  fontFamily: MyFont.myFont,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: MyColors.primaryCustom),
            ),
            const SizedBox(height: 10),
            Text(
              'Welcome Back!',
              style: TextStyle(
                  fontFamily: MyFont.myFont,
                  fontWeight: FontWeight.w600,
                  // fontSize: 25,
                  color: MyColors.black),
            ),
            const SizedBox(height: 20),
            CustomTextFormField(
              controller: controller.emailController,
              labelText: 'Email or Phone No',
              labelTextStyle: TextStyle(fontFamily: MyFont.myFont),
              readOnly: false,
              obscureText: false,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              filled: true,
              keyboardInput: TextInputType.text,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (v) {
                FocusScope.of(context).requestFocus(focus);
              },
              inputFormatters: [
                MyInputFormatter(),
              ],
              validator: (value) {
                String pattern =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regex = RegExp(pattern);
                if (value == null ||
                    value.isEmpty && !(regex.hasMatch(value))) {
                  return "please enter the Email or Phone No";
                } else {}
              },
              suffixIcon: const Icon(Icons.person),
            ),
            const SizedBox(height: 20),
            CustomTextFormField(
              focusNode: focus,
              controller: controller.passwordController,
              labelText: 'Password',
              labelTextStyle: TextStyle(fontFamily: MyFont.myFont),
              readOnly: false,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              obscureText: controller.isPasswordVisible.value ? false : true,
              filled: true,
              keyboardInput: TextInputType.text,
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "please enter the Password";
                } else {}
              },
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      controller.isPasswordVisible.value =
                          !controller.isPasswordVisible.value;
                    });
                  },
                  icon: Icon(controller.isPasswordVisible.value
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined)),
            ),
            SizedBox(height: height(context) / 40),
            remberMeCheckBox(),
            SizedBox(height: height(context) / 40),
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.ForgetPasswordScreen);
              },
              child: RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: "Forgot",
                    style: TextStyle(
                      fontFamily: MyFont.myFont,
                      fontWeight: FontWeight.bold,
                      color: MyColors.black,
                    )),
                const WidgetSpan(child: SizedBox(width: 8)),
                TextSpan(
                    text: "Password ?",
                    style: TextStyle(
                      fontFamily: MyFont.myFont,
                      fontWeight: FontWeight.bold,
                      color: MyColors.primaryCustom,
                    )),
              ])),
            ),
          ],
        ),
      ),
    );
  }

  ///FooterButton
  button() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(18, 0, 18, 18),
      child: Column(
        children: [
          SizedBox(height: 20),
        ],
      ),
    );
  }

  remberMeCheckBox() {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      SizedBox(
        height: 24.0,
        width: 24.0,
        child: Theme(
            data: ThemeData(
                unselectedWidgetColor: MyColors.mainTheme // Your color
                ),
            child: Checkbox(
              activeColor: MyColors.mainTheme,
              value: controller.isChecked,
              onChanged: (value) {
                setState(() {
                  handleRemeberme(value!);
                });
              },
            )),
      ),
      const SizedBox(width: 10.0),
      Text("Remember Me",
          style: TextStyle(
            fontFamily: MyFont.myFont,
            fontWeight: FontWeight.bold,
            color: MyColors.black,
          ))
    ]);
  }

  //handle remember me function
  handleRemeberme(bool value) {
    controller.isChecked = value;
    SharedPreferences.getInstance().then(
      (prefs) {
        prefs.setBool("remember_me", value);
        prefs.setString('User Name', controller.emailController.text);
        prefs.setString('password', controller.passwordController.text);
      },
    );
    setState(() {
      controller.isChecked = value;
    });
  }

  //load email and password
  loadUserEmailPassword() async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      var _email = _prefs.getString("User Name") ?? "";
      var _password = _prefs.getString("password") ?? "";
      var _remeberMe = _prefs.getBool("remember_me") ?? false;
      print(_remeberMe);
      print(_email);
      print(_password);
      if (_remeberMe) {
        setState(() {
          controller.isChecked = true;
        });
        controller.emailController.text = _email ?? "";
        controller.passwordController.text = _password ?? "";
      }
    } catch (e) {
      print(e);
    }
  }
}
