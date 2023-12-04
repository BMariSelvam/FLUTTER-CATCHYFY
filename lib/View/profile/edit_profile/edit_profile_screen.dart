import 'package:Catchyfive/Const/approutes.dart';
import 'package:Catchyfive/Const/colors.dart';
import 'package:Catchyfive/Const/font.dart';
import 'package:Catchyfive/Const/size.dart';
import 'package:Catchyfive/Helper/preferencehelper.dart';
import 'package:Catchyfive/View/profile/edit_profile/edit_profile_controller.dart';
import 'package:Catchyfive/Widget/CustomTextField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final loginKey = GlobalKey<FormState>();

  late EditProfileController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(EditProfileController());
    initalFunction();
  }

  initalFunction() async {
    await PreferenceHelper.getUserData().then((value) => setState(() {
          controller.emailController.text = "${value?.emailId}";
          controller.userNameController.text = "${value?.b2CCustomerName}";
          controller.mobileNumberController.text = "${value?.mobileNo}";
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: loginKey,
      child: Scaffold(
        backgroundColor: MyColors.white,
        appBar: AppBar(
          backgroundColor: MyColors.mainTheme,
          iconTheme: const IconThemeData(color: MyColors.white),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Get.back();
            },
          ),
          title: Text(
            'Edit Profile',
            style: TextStyle(
                fontFamily: MyFont.myFont,
                fontWeight: FontWeight.bold,
                color: MyColors.white),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(
                  top: 5,
                  left: 10,
                  right: 5,
                ),
                child: Text(
                  'Name',
                  style: TextStyle(
                    fontFamily: MyFont.myFont,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
              ),
              CustomTextField(
                inputBorder: const OutlineInputBorder(),
                controller: controller.userNameController,
                keyboardType: TextInputType.name,
                readOnly: false,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Enter Valid UserName";
                  } else if (value.length < 3) {
                    return "Enter Minimum 3 long";
                  } else {
                    return null;
                  }
                },
              ),
              Container(
                padding: const EdgeInsets.only(
                  top: 5,
                  left: 10,
                  right: 5,
                ),
                child: Text(
                  'Email Address',
                  style: TextStyle(
                    fontFamily: MyFont.myFont,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
              ),
              CustomTextField(
                inputBorder: const OutlineInputBorder(),
                controller: controller.emailController,
                keyboardType: TextInputType.emailAddress,
                // hintText: 'Mobile Number',
                readOnly: false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter Your Email";
                  } else {
                    return null;
                  }
                },
              ),
              Container(
                padding: const EdgeInsets.only(
                  top: 5,
                  left: 10,
                  right: 5,
                ),
                child: Text(
                  'Mobile Number',
                  style: TextStyle(
                    fontFamily: MyFont.myFont,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
              ),
              CustomTextField(
                inputBorder: const OutlineInputBorder(),
                controller: controller.mobileNumberController,
                keyboardType: TextInputType.phone,
                readOnly: false,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Enter Valid Mobile Number";
                  } else if (value.length < 5) {
                    return "Enter Minimum 5 long";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: height(context) / 30,
              ),
              Container(
                padding: const EdgeInsets.only(
                  top: 5,
                  left: 10,
                  right: 5,
                ),
                child: Text(
                  'We promise not to spam you',
                  style: TextStyle(
                    fontFamily: MyFont.myFont,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
              ),
              SizedBox(
                height: height(context) / 50,
              ),
              Container(
                height: 60,
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 18),
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                child: GestureDetector(
                  onTap: ()    {

                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: MyColors.mainTheme,
                      // border: Border.all(color: MyColors.mainTheme, width: 2),
                    ),
                    child: Center(
                        child: Text(
                      'Submit',
                      style: TextStyle(
                        fontFamily: MyFont.myFont,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: MyColors.white,
                      ),
                    )),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
