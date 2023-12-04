import 'package:Catchyfive/Helper/NetworkManger.dart';
import 'package:Catchyfive/Helper/api.dart';
import 'package:Catchyfive/Helper/preferencehelper.dart';
import 'package:Catchyfive/locator/cart_service.dart';
import 'package:Catchyfive/locator/locator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../Const/colors.dart';
import '../../Model/GetFavProductListModel.dart';
import '../../Model/catagroy/ProductModel.dart';

class FavScreenController extends GetxController with StateMixin {
  Rx<bool> isproductLoading = false.obs;
  List<GetFavProductListModel> favProductList = [];
  String formattedDateTime = "";
  Rx<bool> isLoading = false.obs;
  RxList<ProductModel> productList = <ProductModel>[].obs;

  final CartService cartService = getIt<CartService>();

  String getCurrentDateTime() {
    var now = DateTime.now();
    var formatter = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
    formattedDateTime = formatter.format(now);
    return formattedDateTime;
  }

  GetFavProduct() async {
    isproductLoading.value = true;
    NetworkManager.get(url: HttpUrl.b2CCustomerFavGetWishList, parameters: {
      "OrganizationId": HttpUrl.org,
      "CustomerId": await PreferenceHelper.getUserData()
          .then((value) => value?.b2CCustomerId)
    }).then((response) async {
      isproductLoading.value = false;
      change(null, status: RxStatus.success());
      if (response.apiResponseModel != null &&
          response.apiResponseModel!.status) {
        if (response.apiResponseModel!.data != null) {
          List? resJson = response.apiResponseModel!.data!;
          if (resJson != null) {
            List<GetFavProductListModel> list =
                resJson.map<GetFavProductListModel>((value) {
              return GetFavProductListModel.fromJson(value);
            }).toList();
            favProductList = list;
            change(null, status: RxStatus.success());
            List<String?> productCodes =
                favProductList.map((product) => product.productCode).toList();
            for (String? productCode in productCodes) {
              isLoading.value = true;
              try {
                await getAllSubCategoryList(productCode);
              } catch (error) {
                handleApiError(error);
              }
              isLoading.value = false;
            }
            return;
          }
        }
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

  getAllSubCategoryList(String? ProductCode) {
    NetworkManager.get(url: HttpUrl.getAllProductcode, parameters: {
      "OrganizationId": HttpUrl.org,
      "ProductCode": ProductCode
    }).then((response) {
      if (response.apiResponseModel != null &&
          response.apiResponseModel!.status) {
        change(null, status: RxStatus.success());
        if (response.apiResponseModel!.data != null) {
          List? resJson = response.apiResponseModel!.data!;
          if (resJson != null) {
            List<ProductModel> list = resJson.map<ProductModel>((value) {
              return ProductModel.fromJson(value);
            }).toList();
            productList.addAll(list);
            print("productList.length");
            print(productList.length);
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
    // Similar usage for POST, PUT, and DELETE requests
  }

  void handleApiError(error) {
    change(null, status: RxStatus.error());
    Get.showSnackbar(
      GetSnackBar(
        title: "Error",
        message: error.toString(),
        icon: const Icon(Icons.error),
        duration: const Duration(seconds: 3),
      ),
    );
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
            "Add To Favourite!",
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
    productList.value.length = 0;
    GetFavProduct();
  }

  UnFavProduct({
    required ProductModel productModel,
    // required bool isFav,
  }) async {
    isproductLoading.value = true;
    NetworkManager.get(
        url: HttpUrl.b2CCustomerUnFavCreateWishList,
        parameters: {
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
            "Removed from Favourite!",
            margin: EdgeInsets.all(20),
            backgroundColor: MyColors.lightGreen4,
            duration: const Duration(seconds: 3),
            snackPosition: SnackPosition.TOP,
          );
          change(null, status: RxStatus.success());
        }
      } else {
        // change(null, status: RxStatus.error());
        // Get.showSnackbar(
        //   GetSnackBar(
        //     title: "Error",
        //     message: response.apiResponseModel!.message ?? '',
        //     icon: const Icon(Icons.error),
        //     duration: const Duration(seconds: 3),
        //   ),
        // );
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
    productList.value.length = 0;
    GetFavProduct();
  }
}
