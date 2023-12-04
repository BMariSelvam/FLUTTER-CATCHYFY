import 'package:Catchyfive/Const/approutes.dart';
import 'package:Catchyfive/Const/colors.dart';
import 'package:Catchyfive/Const/font.dart';
import 'package:Catchyfive/Const/size.dart';
import 'package:Catchyfive/Helper/api.dart';
import 'package:Catchyfive/Helper/constant.dart';
import 'package:Catchyfive/Model/address/create_address_model.dart';
import 'package:Catchyfive/View/address/address_controller.dart';
import 'package:Catchyfive/Widget/CustomTextField.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../Helper/preferenceHelper.dart';
import '../../Model/login/login_model.dart';

class EnterAddressDetailsScreen extends StatefulWidget {
  const EnterAddressDetailsScreen({Key? key}) : super(key: key);

  @override
  State<EnterAddressDetailsScreen> createState() =>
      _EditEnterAddressDetailsScreenState();
}

class _EditEnterAddressDetailsScreenState
    extends State<EnterAddressDetailsScreen> {
  late LocationFetchController locationFetchController;
  String currentDate = DateTime.now().toString();
  final addressKey = GlobalKey<FormState>();
  B2cLoginModel? loginUser;

  @override
  void initState() {
    super.initState();
    locationFetchController = Get.put(LocationFetchController());
    Map<String, dynamic>? args = Get.arguments;
    if (args != null) {
      locationFetchController.address1.text = args['address1'] != null ? args['address1'].toString() : '';
      locationFetchController.address2.text = args['address2'] != null ? args['address2'].toString() : '';
      locationFetchController.address3.text = args['address3'] != null ? args['address3'].toString() : '';
      locationFetchController.postalCodeController.text = args['postalCode'] != null ? args['postalCode'].toString() : '';
      // Add other field assignments as needed
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    clear();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationFetchController>(builder: (logic) {
      return Form(
        key: addressKey,
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
              'Enter Address Details',
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
                    'Postal Code',
                    style: TextStyle(
                      fontFamily: MyFont.myFont,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                ),
                CustomTextField(
                  inputBorder: const OutlineInputBorder(),
                  controller: locationFetchController.postalCodeController,
                  keyboardType: TextInputType.number,
                  readOnly: false,
                  suffixIcon: locationFetchController.fetchIsLoading.value ==
                          true
                      ? const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          child: CircularProgressIndicator(
                            strokeWidth: 5,
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          child: InkWell(
                            onTap: () async {
                              clear();
                              if (locationFetchController
                                  .postalCodeController.text.isNotEmpty) {
                                await locationFetchController.getPostal(
                                    locationFetchController
                                        .postalCodeController.text);
                              } else {
                                Get.snackbar(
                                  margin: EdgeInsets.all(20),
                                  backgroundColor: MyColors.red,
                                  "Attention",
                                  "Please enter postal code",
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
                      return "Enter Your PostalCode";
                    } else {}
                  },
                ),
                Container(
                  padding: const EdgeInsets.only(
                    top: 5,
                    left: 10,
                    right: 5,
                  ),
                  child: Text(
                    'Address 1',
                    style: TextStyle(
                      fontFamily: MyFont.myFont,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                ),
                CustomTextField(
                  inputBorder: const OutlineInputBorder(),
                  controller: locationFetchController.address1,
                  keyboardType: TextInputType.text,
                  // hintText: 'Mobile Number',
                  readOnly: true,
                  onChanged: (value) {
                    locationFetchController.address1.text =
                        value;
                  },
                ),
                Container(
                  padding: const EdgeInsets.only(
                    top: 5,
                    left: 10,
                    right: 5,
                  ),
                  child: Text(
                    'Address 2',
                    style: TextStyle(
                      fontFamily: MyFont.myFont,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                ),
                CustomTextField(
                  inputBorder: const OutlineInputBorder(),
                  controller: locationFetchController.address2,
                  keyboardType: TextInputType.text,
                  readOnly: false,
                  onChanged: (value) {
                    if (locationFetchController.postalCodeController.text.isNotEmpty) {
                      locationFetchController.address2.text = value;
                    } else {
                      Get.snackbar(
                        margin: EdgeInsets.all(20),
                        backgroundColor: MyColors.red,
                        "Attention",
                        "Please enter postal code",
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
                ),
                Container(
                  padding: const EdgeInsets.only(
                    top: 5,
                    left: 10,
                    right: 5,
                  ),
                  child: Text(
                    "Floor No & Unit No",
                    style: TextStyle(
                      fontFamily: MyFont.myFont,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                ),
                CustomTextField(
                  inputBorder: const OutlineInputBorder(),
                  controller:
                      locationFetchController.address3,
                  keyboardType: TextInputType.text,
                  readOnly: false,
                ),
                // Container(
                //   padding: const EdgeInsets.only(
                //     top: 5,
                //     left: 10,
                //     right: 5,
                //   ),
                //   child: Text(
                //     'Add Address Label',
                //     style: TextStyle(
                //       fontFamily: MyFont.myFont,
                //       fontWeight: FontWeight.w500,
                //       fontSize: 12,
                //     ),
                //   ),
                // ),
                // CustomTextField(
                //   inputBorder: const OutlineInputBorder(),
                //   controller: locationFetchController.addAddressLabelController,
                //   keyboardType: TextInputType.text,
                //   readOnly: false,
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return "Enter Your Add address label";
                //     } else {}
                //   },
                // ),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            height: 60,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
            child: GestureDetector(
              onTap: () async {
                loginUser = await PreferenceHelper.getUserData();
                FocusScope.of(context).unfocus();
                if (addressKey.currentState!.validate()) {
                  locationFetchController.createAddress = CreateAddress(
                    orgId: HttpUrl.org,
                    customerId: loginUser?.b2CCustomerId ?? "",
                    deliveryId: 0,
                    fax: "",
                    isDefault: true,
                    mobile: locationFetchController.loginUser?.mobileNo,
                    name: loginUser?.b2CCustomerName,
                    phone: loginUser?.mobileNo,
                    addressLine1: locationFetchController.address1.text,
                    addressLine2: locationFetchController.address2.text,
                    addressLine3: locationFetchController.address3.text,
                    countryId: locationFetchController.createAddress?.countryId,
                    postalCode:locationFetchController.postalCodeController.text,
                    isActive:locationFetchController.createAddress?.isActive ?? true,
                    createdBy:loginUser?.b2CCustomerName ??"",
                    createdOn: currentDate,
                    changedBy: "Admin",
                    changedOn: currentDate,
                  );
                  await locationFetchController.createPostAddress();
                  clear();
                }
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
                  'Confirm',
                  style: TextStyle(
                    fontFamily: MyFont.myFont,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: MyColors.white,
                  ),
                )),
              ),
            ),
          ),
        ),
      );
    });
  }

  clear() {
    locationFetchController.address1.clear();
    locationFetchController.address2.clear();
    locationFetchController.address3.clear();
    locationFetchController.postalModel.clear();
  }
}
