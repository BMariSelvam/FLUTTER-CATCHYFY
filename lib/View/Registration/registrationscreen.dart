import 'package:Catchyfive/Helper/api.dart';
import 'package:Catchyfive/Model/%20b2c_customer_Reg/B2CCustomerRegModel.dart';
import 'package:Catchyfive/View/Registration/registrationcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Const/assets.dart';
import '../../Const/colors.dart';
import '../../Const/font.dart';
import '../../Const/validations.dart';
import '../../Widget/customtextformfield.dart';
import '../../Widget/elevatedbutton.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late RegistrationController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(RegistrationController());
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegistrationController>(builder: (state) {
      return Form(
        key: controller.registrationKey,
        child: Scaffold(
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SafeArea(
                  child: Align(
                      alignment: Alignment.center,
                      child: Image.asset(Assets.registration)),
                ),
                Text(
                  'Sign up',
                  style: TextStyle(
                      fontFamily: MyFont.myFont,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: MyColors.primaryCustom),
                ),
                const SizedBox(height: 10),
                Text(
                  'Let\'s get started with creating your Account',
                  style: TextStyle(
                      fontFamily: MyFont.myFont,
                      fontWeight: FontWeight.w600,
                      // fontSize: 25,
                      color: MyColors.black),
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  controller: controller.nameController,
                  labelText: 'Name',
                  labelTextStyle: TextStyle(fontFamily: MyFont.myFont),
                  readOnly: false,
                  obscureText: false,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  filled: true,
                  keyboardInput: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the Name";
                    } else if (value.trim().isEmpty) {
                      return "Name should not consist of only spaces";
                    } else if (value.startsWith(' ')) {
                      return "Name should not start with a space";
                    } else {
                      return null; // No validation error
                    }
                  },
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  controller: controller.emailController,
                  labelText: 'Email Address',
                  labelTextStyle: TextStyle(fontFamily: MyFont.myFont),
                  readOnly: false,
                  obscureText: false,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  filled: true,
                  keyboardInput: TextInputType.emailAddress,
                  inputFormatters: [
                    MyInputFormatter(),
                  ],
                  onChanged: (value) {
                    setState(() {
                      // controller.emailController.text = value;
                      controller.verifyOTP = false.obs;
                    });
                  },
                  suffixIcon: controller.sendOtpLoading.value == true
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          child: Card(
                            elevation: 0,
                            color: MyColors.mainTheme,
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Text(
                                "Verifying...",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: MyFont.myFont,
                                  fontWeight: FontWeight.bold,
                                  color: MyColors.white,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ),
                        )
                      // const Padding(
                      //         padding:
                      //             EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      //         child: CircularProgressIndicator(),
                      //       )
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          child: (controller.verifyOTP.value == false)
                              ? GestureDetector(
                                  onTap: () async {
                                    if (controller
                                        .emailController.text.isNotEmpty) {
                                      controller.ExitingEmailCheck();
                                    } else {
                                      Get.snackbar(
                                        margin: const EdgeInsets.all(20),
                                        backgroundColor: MyColors.red,
                                        "Attention",
                                        "Please enter the Email",
                                        colorText: MyColors.white,
                                        icon: const Icon(
                                          Icons.emergency,
                                          color: MyColors.white,
                                        ),
                                        duration: const Duration(seconds: 3),
                                        snackPosition: SnackPosition.TOP,
                                      );
                                    }
                                  },
                                  child: Card(
                                    elevation: 0,
                                    color: MyColors.mainTheme,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      child: Text(
                                        "Send OTP",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: MyFont.myFont,
                                          fontWeight: FontWeight.bold,
                                          color: MyColors.white,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Card(
                                  elevation: 0,
                                  color: MyColors.mainTheme,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    child: Text(
                                      "Verified",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: MyFont.myFont,
                                        fontWeight: FontWeight.bold,
                                        color: MyColors.white,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                )),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !value.contains('@') ||
                        !value.contains('.')) {
                      return 'Invalid Email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  controller: controller.phoneNoController,
                  labelText: 'Mobile Number',
                  labelTextStyle: TextStyle(fontFamily: MyFont.myFont),
                  readOnly: false,
                  obscureText: false,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  filled: true,
                  keyboardInput: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty && value.length != 9) {
                      return "Please enter the Mobile Number.";
                    } else {}
                  },
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  controller: controller.passwordController,
                  labelText: 'Password',
                  labelTextStyle: TextStyle(fontFamily: MyFont.myFont),
                  readOnly: false,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  obscureText:
                      controller.isPasswordVisible.value ? false : true,
                  filled: true,
                  keyboardInput: TextInputType.text,
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the Password";
                    } else if (value.trim().isEmpty) {
                      return "Password should not consist of only spaces";
                    } else if (value.contains(' ')) {
                      return "Password should not contain spaces";
                    } else {
                      return null; // No validation error
                    }
                  },
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  controller: controller.postalCodeController,
                  labelText: 'Postal Code',
                  labelTextStyle: TextStyle(fontFamily: MyFont.myFont),
                  readOnly: false,
                  obscureText: false,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  filled: true,
                  onChanged: (value) {
                    if (value.isEmpty || value == null) {
                      controller.addressLine1Controller.text = "";
                    }
                  },
                  keyboardInput: TextInputType.number,
                  suffixIcon: controller.fetchIsLoading.value == true
                      ? const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          child: CircularProgressIndicator(),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          child: InkWell(
                            onTap: () async {
                              if (controller
                                  .postalCodeController.text.isNotEmpty) {
                                await controller.getPostal(
                                    controller.postalCodeController.text);
                              } else {
                                Get.snackbar(
                                  margin: const EdgeInsets.all(20),
                                  backgroundColor: MyColors.red,
                                  "Attention",
                                  "Please enter the postal code",
                                  colorText: MyColors.white,
                                  icon: const Icon(
                                    Icons.emergency,
                                    color: MyColors.white,
                                  ),
                                  duration: const Duration(seconds: 3),
                                  snackPosition: SnackPosition.TOP,
                                );
                              }
                            },
                            child: Card(
                              elevation: 0,
                              color: MyColors.mainTheme,
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Text(
                                  "Fetch",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: MyFont.myFont,
                                    fontWeight: FontWeight.bold,
                                    color: MyColors.white,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the Postal Code";
                    } else {}
                  },
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  controller: controller.addressLine1Controller,
                  labelText: 'Address1',
                  labelTextStyle: TextStyle(fontFamily: MyFont.myFont),
                  readOnly: true,
                  obscureText: false,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  filled: true,
                  keyboardInput: TextInputType.streetAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return " ";
                    } else {}
                  },
                  onChanged: (value) {
                    setState(() {
                      controller.addressLine1Controller.text = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  controller: controller.addressLine2Controller,
                  labelText: 'Address2',
                  labelTextStyle: TextStyle(fontFamily: MyFont.myFont),
                  readOnly: true,
                  obscureText: false,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  filled: true,
                  keyboardInput: TextInputType.streetAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return " ";
                    } else {}
                  },
                  onChanged: (value) {
                    setState(() {
                      controller.addressLine1Controller.text = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  controller: controller.addressLine3Controller,
                  labelText: "Floor No & Unit No",
                  labelTextStyle: TextStyle(fontFamily: MyFont.myFont),
                  readOnly: false,
                  obscureText: false,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  filled: true,
                  keyboardInput: TextInputType.streetAddress,
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return " ";
                  //   } else {}
                  // },
                  // onChanged: (value) {
                  //   setState(() {
                  //     controller.addressLin3Controller.text = value;
                  //   });
                  // },
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     SizedBox(
                //       width: width(context) / 2.3,
                //       child: CustomTextFormField(
                //         controller: controller.addressLine2Controller,
                //         labelText: 'Floor',
                //         labelTextStyle: TextStyle(fontFamily: MyFont.myFont),
                //         readOnly: false,
                //         obscureText: false,
                //         autoValidateMode: AutovalidateMode.onUserInteraction,
                //         filled: true,
                //         keyboardInput: TextInputType.streetAddress,
                //       ),
                //     ),
                //     SizedBox(
                //       width: width(context) / 2.3,
                //       child: CustomTextFormField(
                //         controller: controller.addressLine3Controller,
                //         labelText: 'Unit No',
                //         labelTextStyle: TextStyle(fontFamily: MyFont.myFont),
                //         readOnly: false,
                //         obscureText: false,
                //         autoValidateMode: AutovalidateMode.onUserInteraction,
                //         filled: true,
                //         keyboardInput: TextInputType.streetAddress,
                //       ),
                //     ),
                //   ],
                // ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          bottomNavigationBar: Padding(
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
                      if (controller.verifyOTP.value == true) {
                        FocusScope.of(context).unfocus();
                        if (controller.registrationKey.currentState!
                            .validate()) {
                          controller.b2cCustomerRegModel = B2cCustomerRegModel(
                              orgId: HttpUrl.org,
                              branchCode: "HO",
                              b2CCustomerId: "",
                              b2CCustomerName: controller.nameController.text,
                              emailId: controller.emailController.text,
                              password: controller.passwordController.text,
                              addressLine1:
                                  controller.addressLine1Controller.text,
                              addressLine2:
                                  controller.addressLine2Controller.text,
                              addressLine3:
                                  controller.addressLine3Controller.text,
                              mobileNo: controller.phoneNoController.text,
                              countryId:
                                  controller.b2cCustomerRegModel?.countryId,
                              postalCode: controller.postalCodeController.text,
                              isActive:
                                  controller.b2cCustomerRegModel?.isActive ??
                                      true,
                              isApproved:
                                  controller.b2cCustomerRegModel?.isApproved ??
                                      true,
                              createdBy: controller.nameController.text,
                              createdOn: DateTime.now(),
                              changedBy: "Admin",
                              changedOn: DateTime.now(),
                              orders: [],
                              address: []);
                          controller.onRegister();
                        }
                      } else {
                        Get.snackbar(
                          "Attention",
                          "Kindly verify Your Email",
                          margin: EdgeInsets.all(20),
                          backgroundColor: MyColors.red,
                          duration: const Duration(seconds: 3),
                          snackPosition: SnackPosition.TOP,
                        );
                      }
                    },
                    title: 'Register',
                  ),
          ),
        ),
      );
    });
  }
}
