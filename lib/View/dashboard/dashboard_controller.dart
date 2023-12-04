import 'package:carousel_slider/carousel_slider.dart';
import 'package:Catchyfive/Helper/NetworkManger.dart';
import 'package:Catchyfive/Helper/api.dart';
import 'package:Catchyfive/Helper/preferencehelper.dart';
import 'package:Catchyfive/Model/dashboard_model/BannerModel.dart';
import 'package:Catchyfive/Model/catagroy/CategoryModel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../Const/colors.dart';
import '../../Model/GetFavProductListModel.dart';
import '../../Model/catagroy/ProductModel.dart';
import '../../locator/cart_service.dart';
import '../../locator/locator.dart';

class DashBoardController extends GetxController with StateMixin {
  //Controller
  final CarouselController carouselController = CarouselController();
  final CarouselController bannerController = CarouselController();
  final ScrollController customScrollViewController = ScrollController();
  TextEditingController searchController = TextEditingController();
  final productController = PageController();

  int counter = 0;
  int currentIndex = 0;

  Rx<bool> isLoadings = false.obs;
  Rx<List<CategoryModel>?> categoryList = (null as List<CategoryModel>?).obs;
  List<BannerModel> bannerImageList = [];

  final geoLocator =
      Geolocator.getCurrentPosition(forceAndroidLocationManager: true);
  Position? currentPosition;
  String currentAddress = "";
  String placeName = "";

  increment() {
    counter++;
  }

  decrement() {
    if (counter > 0) {
      counter--;
    }
  }

  @override
  onInit() async {
    super.onInit();
    productList.value.length = 0;
    GetFavProduct();
    getAllCategoryList();
    bannerGet();
    getCurrentDateTime();
  }


  String getCurrentDateTime() {
    var now = DateTime.now();
    var formatter = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
    formattedDateTime = formatter.format(now);
    return formattedDateTime;
  }

  getAllCategoryList() async {
    change(null, status: RxStatus.loading());
    isLoadings.value = true;
    await NetworkManager.get(
        url: HttpUrl.getAllCategory,
        parameters: {"OrganizationId": HttpUrl.org}).then((response) {
      isLoadings.value = false;
      if (response.apiResponseModel != null &&
          response.apiResponseModel!.status) {
        if (response.apiResponseModel!.data != null) {
          List? resJson = response.apiResponseModel!.data!;
          if (resJson != null) {
            List<CategoryModel> list = resJson.map<CategoryModel>((value) {
              return CategoryModel.fromJson(value);
            }).toList();
            categoryList.value = list;
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
    }).catchError(
      (error) {
        change(null, status: RxStatus.error());
        Get.showSnackbar(
          GetSnackBar(
            title: "Error",
            message: error.toString(),
            icon: const Icon(Icons.error),
            duration: const Duration(seconds: 3),
          ),
        );
      },
    );
  }

  bannerGet() async {
    await NetworkManager.get(
      url: HttpUrl.banner,
      parameters: {"OrganizationId": HttpUrl.org},
    ).then((apiResponse) async {
      print(apiResponse.apiResponseModel!.result);
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.data != null) {
          bannerImageList = (apiResponse.apiResponseModel!.data as List)
              .map((e) => BannerModel.fromJson(e))
              .toList();
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

  Rx<bool> isproductLoading = false.obs;
  List<GetFavProductListModel> favProductList = [];
  String formattedDateTime = "";
  RxList<ProductModel> productList = <ProductModel>[].obs;
  final CartService cartService = getIt<CartService>();

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
            print("favProductList.length");
            print(favProductList.length);
            change(null, status: RxStatus.success());
            List<String?> productCodes =
                favProductList.map((product) => product.productCode).toList();
            for (String? productCode in productCodes) {
              // isLoadings.value = true;
              print("++++++++++++++++++productCode");
              print(productCode);
              try {
                await getAllSubCategoryList(productCode);
              } catch (error) {
                handleApiError(error);
              }
              // isLoadings.value = false;
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
            updateProductCount();
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
    // change(null, status: RxStatus.error());
    Get.showSnackbar(
      GetSnackBar(
        title: "Error",
        message: error.toString(),
        icon: const Icon(Icons.error),
        duration: const Duration(seconds: 3),
      ),
    );
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



  // changeFavProduct({
  //   required ProductModel productModel,
  //   // required bool isFav,
  // }) async {
  //   await NetworkManager.post(
  //       URl: HttpUrl.b2CCustomerFavCreateWishList,
  //       params: {
  //         "OrgId": HttpUrl.org,
  //         "CustomerId": await PreferenceHelper.getUserData()
  //             .then((value) => value?.b2CCustomerId),
  //         "ProductCode": productModel.productCode,
  //         "ProductName": productModel.productName,
  //         "IsActive": true,
  //         "CreatedBy": await PreferenceHelper.getUserData()
  //             .then((value) => value?.b2CCustomerName),
  //         "CreatedOn": formattedDateTime
  //       }).then((apiResponse) async {
  //     if (apiResponse.apiResponseModel != null &&
  //         apiResponse.apiResponseModel!.status) {
  //       if (apiResponse.apiResponseModel!.status) {
  //         Get.snackbar(
  //           "Success",
  //           "Add To Favorite!",
  //           margin: EdgeInsets.all(20),
  //           backgroundColor: MyColors.lightGreen4,
  //           duration: const Duration(seconds: 3),
  //           snackPosition: SnackPosition.TOP,
  //         );
  //         change(null, status: RxStatus.success());
  //       } else {
  //         String? message = apiResponse.apiResponseModel?.message;
  //         Get.showSnackbar(
  //           GetSnackBar(
  //             title: "Error",
  //             message: message.toString(),
  //             icon: const Icon(Icons.error),
  //             duration: const Duration(seconds: 3),
  //           ),
  //         );
  //       }
  //     }
  //   });
  //   productList.value.length = 0;
  //   GetFavProduct();
  // }

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
    favProductList.length = 0;
   await GetFavProduct();
  }
}
