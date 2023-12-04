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
import '../../Model/catagroy/SubCategoryModel.dart';
import '../../Model/catagroy/SubSubCategoryModel.dart';

class SubCategoryController extends GetxController with StateMixin {
  Rx<bool> isLoading = false.obs;
  Rx<bool> issubSubSelected = false.obs;

  Rx<bool> isproductLoading = false.obs;
  Rx<List<SubCategoryModel>?> subCategoryList =
      (null as List<SubCategoryModel>?).obs;

  Rx<List<SubSubCategoryModel>?> subSubCategoryList =
      (null as List<SubSubCategoryModel>?).obs;

  // Rx<List<ProductModel>?> productList = (null as List<ProductModel>?).obs;
  RxList<ProductModel> productList = <ProductModel>[].obs;
  RxList<ProductModel> cartAddedProduct = <ProductModel>[].obs;

  List<GetFavProductListModel> favProductList = [];

  // List<TaxModel> taxModel = [];
  double taxPercentage = 0;
  String tax = "";
  String taxName = "";




  RxInt selectedIndex = 0.obs;
  RxInt category = 0.obs;
  RxInt subcategory = 0.obs;
  RxInt subSubcategory = 0.obs;
  int totalPages = 1;
  int currentPage = 1;
  String? cateogoryId = '';
  String? subCateogoryId = '';
  String categoryName = "";
  String formattedDateTime = "";

  final CartService cartService = getIt<CartService>();

  @override
  void onInit() {
    super.onInit();
    getCurrentDateTime();
  }

  String getCurrentDateTime() {
    var now = DateTime.now();
    var formatter = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
    formattedDateTime = formatter.format(now);
    return formattedDateTime;
  }

  getAllSubCategoryList(String? categoryCode) async {
    isLoading.value = true;
      await getProductByCategoryId(
        categoryId: categoryCode ?? '',
        subCategoryId:  '',
        isPagination: false,
        subCategoryL2Name:  "");
    NetworkManager.get(url: HttpUrl.getAllSubCategory, parameters: {
      "OrganizationId": HttpUrl.org,
      "CategoryCode": categoryCode
    }).then((response) {
      isLoading.value = false;
      print(categoryCode);
      if (response.apiResponseModel != null &&
          response.apiResponseModel!.status) {
        change(null, status: RxStatus.success());
        if (response.apiResponseModel!.data != null) {
          List? resJson = response.apiResponseModel!.data!;
          if (resJson != null) {
            List<SubCategoryModel> list =
                resJson.map<SubCategoryModel>((value) {
              return SubCategoryModel.fromJson(value);
            }).toList();
            list.insert(0, SubCategoryModel(name: "All"));
            subCategoryList.value = list;
            categoryName =
                subCategoryList.value?.first.categoryName ?? "Sub Categories";
            change(null, status: RxStatus.success());
            return;
          }
        } else {
          subCategoryList.value = null;
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

  getAllSubSubCategoryList(String? subCategoryCode, String? code) async {
    // isLoading.value = true;
    productList.value = [];
    await getProductByCategoryId(
        categoryId: code ?? '',
        subCategoryId: subCategoryCode ?? '',
        isPagination: false,
        subCategoryL2Name: '');
    NetworkManager.get(url: HttpUrl.getAllSubSubCategory, parameters: {
      "OrganizationId": HttpUrl.org,
      "SubCategoryCode": subCategoryCode,
    }).then((response) {
      // isLoading.value = false;
      print(subCategoryCode);
      if (response.apiResponseModel != null &&
          response.apiResponseModel!.status) {
        change(null, status: RxStatus.success());
        if (response.apiResponseModel!.data != null) {
          List? resJson = response.apiResponseModel!.data!;
          if (resJson != null) {
            List<SubSubCategoryModel> list =
                resJson.map<SubSubCategoryModel>((value) {
              return SubSubCategoryModel.fromJson(value);
            }).toList();
            list.insert(0, SubSubCategoryModel(name: "All"));
            subSubCategoryList.value = list;
            change(null, status: RxStatus.success());
            return;
          }
        } else {
          subSubCategoryList.value = [];
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
      subSubCategoryList.value = [];
      change(null, status: RxStatus.error());
    }).catchError((error) {
      subSubCategoryList.value = [];
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

  Future<void> getProductByCategoryId({
    required String categoryId,
    required String subCategoryId,
    required String subCategoryL2Name,
    required bool isPagination,
  }) async {
    await GetFavProduct();
    change(null, status: RxStatus.loadingMore());
    await NetworkManager.get(
      url: HttpUrl.getAllProduct,
      parameters: {
        "OrganizationId": HttpUrl.org,
        "Category": categoryId ?? "",
        "SubCategory": subCategoryId ?? "",
        "SubCategoryL2": subCategoryL2Name ?? "",
        "pageNo": "$currentPage",
        "pageSize": "10"
      },
    ).then((response) {
      if (response.apiResponseModel != null &&
          response.apiResponseModel!.status) {
        if (response.apiResponseModel!.result != null) {
          List? resJson = response.apiResponseModel!.result!;
          if (resJson != null) {
            List<ProductModel> list;
            if (favProductList.length != 0) {
              print("++++++++++++++++++++++++++++++1111111");
              list = resJson.map<ProductModel>((value) {
                ProductModel _model = ProductModel.fromJson(value);
                _model.isfavourite = favProductList.any(
                    (element) => element.productCode == _model.productCode);
                return _model;
                // return ProductModel.fromJson(value);
              }).toList();
            } else {
              print("++++++++++++++++++++++++++++++22222222");
              list = resJson.map<ProductModel>((value) {
                return ProductModel.fromJson(value);
              }).toList();
            }
            if (!isPagination) {
              productList.clear();
            }
            productList.value.addAll(list);
            print("productList.length");
            print(productList.length);
            totalPages = response.apiResponseModel?.totalNumberOfPages ?? 1;
            currentPage++;
            updateProductCount();
            change(productList);
          } else {
            productList.value = [];
          }
          change(null, status: RxStatus.success());
        } else {
          productList.value = [];
          currentPage = 1;
          print("productList.length");
          print(productList.length);
          change(null, status: RxStatus.error());
        }
      } else {
        productList.value = [];
        currentPage = 1;
        change(null, status: RxStatus.error());
        String? message = response.apiResponseModel?.message;
        PreferenceHelper.showSnackBar(context: Get.context!, msg: message);
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
    // isproductLoading.value = true;
    NetworkManager.get(url: HttpUrl.b2CCustomerFavGetWishList, parameters: {
      "OrganizationId": HttpUrl.org,
      "CustomerId": await PreferenceHelper.getUserData()
          .then((value) => value?.b2CCustomerId)
    }).then((response) {
      // isproductLoading.value = false;
      // change(null, status: RxStatus.success());
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
            // change(null, status: RxStatus.success());
            return;
            return;
          }
        }
      } else {
        productList.value.isEmpty;
        favProductList.isEmpty;
        // change(null, status: RxStatus.success());
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
  }

}
