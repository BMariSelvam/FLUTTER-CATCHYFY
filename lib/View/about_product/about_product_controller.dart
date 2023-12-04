import 'package:Catchyfive/Helper/NetworkManger.dart';
import 'package:Catchyfive/Helper/api.dart';
import 'package:Catchyfive/Model/catagroy/ProductModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../Const/colors.dart';
import '../../Helper/preferenceHelper.dart';
import '../../locator/cart_service.dart';
import '../../locator/locator.dart';

class AboutProductController extends GetxController with StateMixin {
  RxBool isAbout = false.obs;
  RxBool isFavorite = false.obs;
  Rx<bool> isproductLoading = false.obs;
  int counter = 0;
  PageController imageSwipeController = PageController();
  final loginKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;
  final CartService cartService = getIt<CartService>();
  RxList<ProductModel> productList = <ProductModel>[].obs;
  String formattedDateTime = "";
  RxInt selectedIndex = 0.obs;

  @override
  onInit() async {
    super.onInit();
    getCurrentDateTime();
  }

  String getCurrentDateTime() {
    var now = DateTime.now();
    var formatter = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
    formattedDateTime = formatter.format(now);
    return formattedDateTime;
  }

  changeFavProduct({
    required ProductModel productModel,
    // required bool isFav,
  }) async {
    await NetworkManager.post(
        URl: HttpUrl.b2CCustomerFavCreateWishList,
        params: {
          "OrgId": HttpUrl.org,
          "CustomerId": await PreferenceHelper.getUserData()
              .then((value) => value?.b2CCustomerId),
          "ProductCode": productModel.productCode,
          "ProductName": productModel.productName,
          "IsActive": true,
          "CreatedBy": await PreferenceHelper.getUserData()
              .then((value) => value?.b2CCustomerName),
          "CreatedOn": formattedDateTime
        }).then((apiResponse) async {
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.status) {
          Get.snackbar(
            "Success",
            "Add To Favorite!",
            margin: EdgeInsets.all(20),
            backgroundColor: MyColors.lightGreen4,
            duration: const Duration(seconds: 3),
            snackPosition: SnackPosition.TOP,
          );
          change(null, status: RxStatus.success());
        } else {
          String? message = apiResponse.apiResponseModel?.message;
          Get.showSnackbar(
            GetSnackBar(
              title: "Error",
              message: message.toString(),
              icon: const Icon(Icons.error),
              duration: const Duration(seconds: 3),
            ),
          );
        }
      }
    });
  }

  UnFavProduct({
    required ProductModel productModel,
    // required bool isFav,
  }) async {
    isproductLoading.value = true;
    NetworkManager.get(url: HttpUrl.b2CCustomerUnFavCreateWishList, parameters: {
      "OrganizationId": HttpUrl.org,
      "CustomerId": await PreferenceHelper.getUserData()
          .then((value) => value?.b2CCustomerId),
      "ProductCode": productModel.productCode,
      "UserName": await PreferenceHelper.getUserData()
          .then((value) => value?.b2CCustomerName),
    }).then((response) {
      isproductLoading.value = false;
      change(null, status: RxStatus.success());
      if (response.apiResponseModel != null &&
          response.apiResponseModel!.status) {
        if (response.apiResponseModel!.data != null) {
          Get.snackbar(
            "Success",
            "Removed from Favorite!",
            margin: EdgeInsets.all(20),
            backgroundColor: MyColors.lightGreen4,
            duration: const Duration(seconds: 3),
            snackPosition: SnackPosition.TOP,
          );
          change(null, status: RxStatus.success());
        }
      } else {
        change(null, status: RxStatus.error());
        Get.showSnackbar(
          GetSnackBar(
            title: "Error",
            message: response.apiResponseModel!.message ?? '',
            icon: const Icon(Icons.error),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }).catchError((error) {
      change(null, status: RxStatus.error());
      Get.showSnackbar(
        GetSnackBar(
          title: "Error",
          message: error.toString(),
          icon: const Icon(Icons.error),
          duration: const Duration(seconds: 3),
        ),
      );
    });
  }

}
