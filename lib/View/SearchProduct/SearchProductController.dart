import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Const/colors.dart';
import '../../Helper/NetworkManger.dart';
import '../../Helper/api.dart';
import '../../Helper/preferenceHelper.dart';
import '../../Model/GetFavProductListModel.dart';
import '../../Model/catagroy/ProductModel.dart';
import '../../locator/cart_service.dart';
import '../../locator/locator.dart';

class SearchProductController extends GetxController with StateMixin {
  final TextEditingController searchController = TextEditingController();
  RxList<ProductModel> productList = <ProductModel>[].obs;
  Rx<bool> isLoading = false.obs;
  final searchText = ''.obs;
  int totalPages = 1;
  int currentPage = 1;
  Rx<bool> isproductLoading = false.obs;
  List<GetFavProductListModel> favProductList = [];
  String formattedDateTime = "";
  final CartService cartService = getIt<CartService>();

  Future<void> getProductByCategoryId(
      {required bool isPagination, required String Text,}) async {
    isLoading.value = true;
    change(null, status: RxStatus.loadingMore());
    await NetworkManager.get(
      url: HttpUrl.getAllProduct,
      parameters: {
        "OrganizationId": HttpUrl.org,
        "pageNo": "$currentPage",
        "pageSize": "10",
        "ProductName": "${Text}",
      },
    ).then((response) {
      isLoading.value = false;
      if (response.apiResponseModel != null &&
          response.apiResponseModel!.status) {
        if (response.apiResponseModel!.result != null) {
          List? resJson = response.apiResponseModel!.result!;
          if (resJson != null) {
            List<ProductModel> list = resJson.map<ProductModel>((value) {
              ProductModel _model = ProductModel.fromJson(value);
              _model.isfavourite = favProductList
                  .any((element) => element.productCode == _model.productCode);
              return _model;
            }).toList();
            if (!isPagination) {
              productList.clear();
            }
            productList.addAll(list);
            totalPages = response.apiResponseModel?.totalNumberOfPages ?? 1;
            currentPage++;
            updateProductCount();
            change(productList);
          }
          change(null, status: RxStatus.success());
        } else {
          productList.value.isEmpty;
          currentPage = 1;
          String? message = response.apiResponseModel?.message;
          print("============productList.value");
          print(productList.value.length);
          // Get.showSnackbar(
          //   GetSnackBar(
          //     title: "${Get.context!}",
          //     message: message.toString(),
          //     icon: const Icon(Icons.error),
          //     duration: const Duration(seconds: 3),
          //   ),
          // );
        }
      }
    }).catchError((error) {
      print("============productList.value1111");
      print(productList.value);
      productList.value.isEmpty;
      currentPage = 1;
      // Get.showSnackbar(
      //   GetSnackBar(
      //     title: "Error",
      //     message: error.toString(),
      //     icon: const Icon(Icons.error),
      //     duration: const Duration(seconds: 3),
      //   ),
      // );
    });

  }

  Future<void> updateProductCount() async {
    for (var product in productList) {
      cartService.cartItems.firstWhereOrNull((element) {
        if (element.productCode == product.productCode) {
          product.qtycount = element.qtycount;
          return true;
        } else {
          return false;
        }
      });
    }
  }

  GetFavProduct() async {
    isproductLoading.value = true;
    NetworkManager.get(url: HttpUrl.b2CCustomerFavGetWishList, parameters: {
      "OrganizationId": HttpUrl.org,
      "CustomerId": await PreferenceHelper.getUserData()
          .then((value) => value?.b2CCustomerId)
    }).then((response) {
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
            print("==============");
            print(favProductList.first.productName);
            change(null, status: RxStatus.success());
            return;
          }
        }
      } else {
        productList.value = [];
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
            "Removed from Favorite!",
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
  }
}
