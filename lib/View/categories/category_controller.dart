import 'package:Catchyfive/Helper/NetworkManger.dart';
import 'package:Catchyfive/Helper/api.dart';
import 'package:Catchyfive/Model/catagroy/CategoryModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Model/catagroy/SubCategoryModel.dart';

class CategoryController extends GetxController with StateMixin {
  Rx<bool> isLoading = false.obs;
  String? CategoryName = "";
  Rx<List<CategoryModel>?> categoryList = (null as List<CategoryModel>?).obs;

  getAllCategoryList() {
    isLoading.value = true;
    NetworkManager.get(url: HttpUrl.getAllCategory, parameters: {})
        .then((response) {
      isLoading.value = false;
      if (response.apiResponseModel != null &&
          response.apiResponseModel!.status) {
        change(null, status: RxStatus.success());
        if (response.apiResponseModel!.data != null) {
          List? resJson = response.apiResponseModel!.data!;
          if (resJson != null) {
            List<CategoryModel> list = resJson.map<CategoryModel>((value) {
              return CategoryModel.fromJson(value);
            }).toList();
            categoryList.value = list;
            change(null, status: RxStatus.success());

            return;
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
}
