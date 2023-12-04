import 'package:Catchyfive/Const/approutes.dart';
import 'package:Catchyfive/Helper/NetworkManger.dart';
import 'package:Catchyfive/Helper/preferencehelper.dart';
import 'package:Catchyfive/Model/login/login_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Helper/api.dart';

class EditProfileController extends GetxController with StateMixin {
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressLine1Controller = TextEditingController();
  TextEditingController addressLine2Controller = TextEditingController();
  TextEditingController addressLine3Controller = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController dialCodeController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  Rx<bool> isLoading = false.obs;
  B2cLoginModel? loginUser;
  String currentDate = DateTime.now().toString();

  updatedMember() async {
    isLoading.value = true;
    loginUser = await PreferenceHelper.getUserData();
    await NetworkManager.post(
      URl: HttpUrl.b2CCustomerRegisterEditProfile,
      params: {
        "OrgId": HttpUrl.org,
        "B2CCustomerId": loginUser?.b2CCustomerId,
        "AddressLine1": loginUser?.addressLine1,
        "AddressLine2": loginUser?.addressLine2,
        "AddressLine3": loginUser?.addressLine3,
        "CountryId": loginUser?.countryId,
        "PostalCode": loginUser?.postalCode,
        "ChangedBy": loginUser?.b2CCustomerName,
        "ChangedOn": currentDate
      },
    ).then((apiResponse) async {
      isLoading.value = false;
      if (apiResponse.apiResponseModel != null) {
        if (apiResponse.apiResponseModel!.status) {
          String? message = apiResponse.apiResponseModel!.message;
          print("Updated profile");
          _callRefresh();
          PreferenceHelper.showSnackBar(context: Get.context!, msg: message);
        } else {
          String? message = apiResponse.apiResponseModel?.message;
          PreferenceHelper.showSnackBar(context: Get.context!, msg: message);
        }
      } else {
        PreferenceHelper.showSnackBar(
            context: Get.context!, msg: apiResponse.error);
      }
    });
  }

  _callRefresh() async {
    isLoading.value = true;
    loginUser = await PreferenceHelper.getUserData();
    await NetworkManager.post(
      URl: HttpUrl.login,
      params: {
        "OrganizationId": 1,
        "EmailId": loginUser?.emailId,
        "Password": loginUser?.password
      },
    ).then((apiResponse) async {
      isLoading.value = false;
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.result != null) {
          Map<String, dynamic>? customerJson =
              (apiResponse.apiResponseModel!.result! as List).first;
          if (customerJson != null) {
            await PreferenceHelper.saveUserData(customerJson)
                .then((value) async {
              Get.offAllNamed(AppRoutes.bottomNavBar);
            });
          } else {
            PreferenceHelper.showSnackBar(
                context: Get.context!, msg: "Invalid Data");
          }
        } else {
          String? message = apiResponse.apiResponseModel?.message;
          PreferenceHelper.showSnackBar(context: Get.context!, msg: message);
        }
      } else {
        PreferenceHelper.showSnackBar(
            context: Get.context!, msg: apiResponse.error);
      }
    });
  }
}
