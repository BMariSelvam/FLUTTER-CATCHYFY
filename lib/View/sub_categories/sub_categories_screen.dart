import 'dart:async';

import 'package:Catchyfive/Const/approutes.dart';
import 'package:Catchyfive/Const/colors.dart';
import 'package:Catchyfive/Const/font.dart';
import 'package:Catchyfive/Const/size.dart';
import 'package:Catchyfive/Model/catagroy/ProductModel.dart';
import 'package:Catchyfive/View/sub_categories/subcategory_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Const/assets.dart';
import '../../Helper/constant.dart';
import '../../Helper/preferencehelper.dart';
import '../../Model/catagroy/CategoryModel.dart';
import '../categories/category_controller.dart';

class SubCategoriesScreen extends StatefulWidget {
  const SubCategoriesScreen({super.key});

  @override
  State<SubCategoriesScreen> createState() => _SubCategoriesScreenState();
}

class _SubCategoriesScreenState extends State<SubCategoriesScreen> {
  int isSelected = 0;
  int issubSubSelected = 0;

  late ProductModel productModel;
  late CategoryModel? catrogryModel;
  //Controller
  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;
  double totalCost = 0;
  double totalCount = 0;
  double averageCost = 0;
  // String categoryId = "";
  String subCategoryId = "";
  String subSubCategoryId = "";
  String slectedSubCategoryId = "";
  String selectedSubSubCategoryId = "";

  late SubCategoryController controller;
  final ScrollController scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  List<String> savedProduct = [];
  String? categoryName = "";

  @override
  void initState() {
    super.initState();
    controller = Get.put(SubCategoryController());
    controller.cartService.cartChangeStream.listen((_) {
      setState(() {});
    });
    initData();
    controller.updateProductCount();
    print("============111111");
  }

  late final List<ProductModel> localData;

  Future<void> initData() async {
    productModel = Get.put(ProductModel());
    catrogryModel = Get.arguments as CategoryModel;

    controller.productList.clear();
    await controller.getAllSubCategoryList(catrogryModel?.code);
    categoryName = catrogryModel?.name;
    controller.currentPage = 1;
    scrollController.addListener(_scrollListener);
    localData = await PreferenceHelper.getCartData();
    if (localData != null) {
      for (int i = 0; i < localData.length; i++) {
        savedProduct.add(localData[i].productCode!);
      }
      controller.cartAddedProduct.clear();
      controller.cartAddedProduct.addAll(localData);
    }
  }



  Future<void> _scrollListener() async {
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      if (controller.currentPage <= controller.totalPages &&
          !controller.status.isLoadingMore) {
        await controller.getProductByCategoryId(
            categoryId: catrogryModel?.code ?? '',
            subCategoryId:
                (slectedSubCategoryId == "" || slectedSubCategoryId == null)
                    ? ""
                    : slectedSubCategoryId,
            isPagination: true,
            subCategoryL2Name: subSubCategoryId ?? "");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    controller.updateProductCount();
    return GetBuilder<SubCategoryController>(builder: (state) {
      if (controller.isLoading.value == true) {
        return Container(
          color: MyColors.white,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
      return Scaffold(
          appBar: AppBar(
            toolbarHeight: 70,
            backgroundColor: MyColors.mainTheme,
            iconTheme: const IconThemeData(color: MyColors.white),
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: MyColors.white,
              ),
            ),
            title: Text(
              categoryName!,
              // 'Season Fruits',
              style: TextStyle(
                  fontFamily: MyFont.myFont,
                  fontWeight: FontWeight.normal,
                  color: MyColors.white),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.SearchController);
                  },
                  child: const Icon(
                    Icons.search,
                    color: MyColors.white,
                  ),
                ),
              ),
              buildAppBarCartButton()
            ],
          ),
          body: (controller.subCategoryList.value != null &&
                  controller.productList.value != null)
              ? Row(
                  children: [
                    Container(
                        height: height(context),
                        width: width(context) / 5.9,
                        // width: width(context) / 7,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              // Shadow color
                              spreadRadius: 5, // How much the shadow spreads
                              blurRadius: 10, // How blurry the shadow is
                              offset: Offset(0, 3), // Offset of the shadow
                            ),
                          ],
                        ),
                        child: subCategoryListView()),
                    Padding(
                      padding: const EdgeInsets.only(left: 3),
                      child: controller.subSubCategoryList.value != null &&
                              controller.subSubCategoryList.value!.isNotEmpty!
                          ? Column(
                              children: [
                                SizedBox(
                                  height:
                                      (controller.subSubCategoryList.value !=
                                                  null &&
                                              controller.subSubCategoryList
                                                  .value!.isNotEmpty!)
                                          ? 120
                                          : 0,
                                  width: width(context) / 1.25,
                                  child: subSubCategoryListView(),
                                ),
                                Container(
                                  color: MyColors.greyForTextFormField,
                                  height:
                                      (controller.subSubCategoryList.value !=
                                                  null &&
                                              controller.subSubCategoryList
                                                  .value!.isNotEmpty)
                                          ? height(context) / 1.41
                                          : height(context) / 1.2,
                                  width: width(context) / 1.25,
                                  child: subCategoryProductListView(),
                                ),
                                if (controller.status.isLoading)
                                  const Center(
                                    child: CircularProgressIndicator(),
                                  )
                              ],
                            )
                          : Column(
                              children: [
                                Container(
                                  color: MyColors.greyForTextFormField,
                                  height:
                                      (controller.subSubCategoryList.value !=
                                                  null &&
                                              controller.subSubCategoryList
                                                  .value!.isNotEmpty)
                                          ? height(context) / 1.4
                                          : height(context) / 1.15,
                                  width: width(context) / 1.25,
                                  child: subCategoryProductListView(),
                                ),
                                if (controller.status.isLoading)
                                  const Center(
                                    child: CircularProgressIndicator(),
                                  )
                              ],
                            ),
                    )
                  ],
                )
              : Center(
                  child: Image.asset(Assets.empty),
                ));
    });
  }

  buildAppBarCartButton() {
    return Obx(() {
      return GestureDetector(
        onTap: () async {
          if (controller.cartAddedProduct.isNotEmpty) {
            Get.toNamed(AppRoutes.cartScreen,
                    arguments: controller.cartAddedProduct)
                ?.then((value) {
              if (value == true) {
                initData();
              }
            });
          } else {
            Get.showSnackbar(
              const GetSnackBar(
                margin: EdgeInsets.all(10),
                borderRadius: 10,
                backgroundColor: Colors.red,
                snackPosition: SnackPosition.TOP,
                message: "Please select atleast one product",
                icon: Icon(
                  Icons.error,
                  color: Colors.white,
                ),
                duration: Duration(seconds: 3),
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(right: 11.0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 11.0),
                child: Icon(
                  Icons.shopping_cart_outlined,
                  color: MyColors.white,
                ),
              ),
              if (controller.cartAddedProduct.isNotEmpty)
                Positioned(
                  top: 13,
                  right: 5,
                  child: Container(
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xffc32c37),
                        border: Border.all(color: Colors.white, width: 1)),
                    child: Center(
                      child: Text(
                        controller.cartAddedProduct.length.toString(),
                        style: const TextStyle(
                          fontSize: 10,
                          color: MyColors.white,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
    });
  }

  subCategoryListView() {
    return Obx(() {
      return (controller.subCategoryList.value != null)
          ? ListView.builder(
              itemCount: controller.subCategoryList.value?.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async {
                    setState(
                      () {
                        isSelected = index;
                        issubSubSelected=0;
                      },
                    );
                    controller.subcategory.value = index;
                    controller.currentPage = 1;
                    controller.totalPages = 1;
                    controller.productList.clear();
                    if (index == 0) {
                      slectedSubCategoryId = "";
                      controller.subSubCategoryList.value?.length = 0;
                      setState(() {
                        controller.subSubCategoryList.value = [];
                         controller.getProductByCategoryId(
                            categoryId: catrogryModel?.code ?? '',
                            subCategoryId: "",
                            isPagination: false,
                            subCategoryL2Name: '');
                      });
                    } else {
                      setState(() {
                        controller.subSubCategoryList.value = [];
                      });
                      slectedSubCategoryId = controller.subCategoryList.value?[index].code ?? "";
                      await controller.getAllSubSubCategoryList(controller.subCategoryList.value?[index].code,catrogryModel?.code);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Column(
                      children: [
                        Container(
                          margin: isSelected == index
                              ? const EdgeInsets.symmetric(vertical: 10)
                              : const EdgeInsets.only(
                                  top: 10,
                                  bottom: 10,
                                  right: 5,
                                  left: 5,
                                ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                          ),
                          decoration: isSelected == index
                              ? const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(100),
                                      bottomRight: Radius.circular(100)),
                                  color: MyColors.mainTheme,
                                )
                              : BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: MyColors.lightGreen4,
                                ),
                          height: 50,
                          width: 50,
                          child: Container(
                            clipBehavior: Clip.hardEdge,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: SizedBox(
                              child: (controller.subCategoryList.value?[index]
                                          .subCategoryImageFilePath !=
                                      null)
                                  ? ("${controller.subCategoryList.value?[index].subCategoryImageFilePath}"
                                          .isNotEmpty)
                                      ? Image.network(
                                          '${controller.subCategoryList.value?[index].subCategoryImageFilePath}',
                                          height: height(context) / 200,
                                          width: width(context) / 200,
                                          fit: BoxFit.contain,
                                        )
                                      : Image.asset(
                                          Assets.noImage,
                                          height: height(context) / 200,
                                          width: width(context) / 200,
                                          fit: BoxFit.contain,
                                        )
                                  : Image.asset(
                                      Assets.noImage,
                                      height: height(context) / 200,
                                      width: width(context) / 200,
                                      fit: BoxFit.contain,
                                    ),
                              //     Image.asset(
                              //   Assets.noImage,
                              //   height: height(context) / 200,
                              //   width: width(context) / 200,
                              //   fit: BoxFit.contain,
                              // ),
                            ),
                          ),
                        ),
                        Text(
                          controller.subCategoryList.value?[index].name ?? " ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: Constant.myFont,
                              fontWeight: FontWeight.w500,
                              color: MyColors.black),
                        ),
                      ],
                    ),
                  ),
                );
              })
          : const Center(child: Text('No Data'));
    });
  }

  subCategoryProductListView() {
    controller.updateProductCount();
    if ((controller.productList.value.isNotEmpty)) {
      return Column(
        children: [
          Expanded(
            child: Obx(() {
              return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.64,
                  ),
                  itemCount: controller.productList.value?.length,
                  padding: EdgeInsets.zero,
                  controller: scrollController,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: width(context) / 2.4,
                      child: Card(
                          elevation: 5,
                          shadowColor: MyColors.grey,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    alignment: Alignment.topLeft,
                                    decoration: const BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(5),
                                            bottomRight: Radius.circular(5))),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      child: Text(
                                        "30 % Off",
                                        style: TextStyle(
                                          fontFamily: MyFont.myFont,
                                          fontWeight: FontWeight.bold,
                                          color: MyColors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          controller.productList.value[index]
                                              .isfavourite =
                                          !controller.productList
                                              .value[index].isfavourite;
                                          if (controller.productList
                                              .value[index].isfavourite ==
                                              true) {
                                            controller.changeFavProduct(
                                                productModel: controller
                                                    .productList.value[index]);
                                          } else {
                                            controller.UnFavProduct(
                                                productModel: controller
                                                    .productList.value[index]);
                                          }
                                        });
                                      },
                                      child: Icon(
                                        (controller.productList.value[index]
                                            .isfavourite)
                                            ? Icons.favorite_outlined
                                            : Icons.favorite_outline_rounded,
                                        color: MyColors.red,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: height(context) / 50),
                              GestureDetector(
                                  onTap: () {
                                    controller.selectedIndex.value = index;
                                    Get.toNamed(AppRoutes.aboutProductScreen,
                                        arguments: controller
                                            .productList.value[index]);
                                  },
                                  child: SizedBox(
                                    child: (controller.productList[index]
                                        .productImagePath !=
                                        null)
                                        ? ("${controller.productList[index]
                                        .productImagePath}"
                                        .isNotEmpty)
                                        ? Image.network(
                                      '${controller.productList[index]
                                          .productImagePath}',
                                      height: height(context) / 9,
                                      width: width(context) / 5,
                                    )
                                        : Image.asset(
                                      Assets.noImage,
                                      height: height(context) / 9,
                                      width: width(context) / 5,
                                    )
                                        : const Icon(Icons.error),
                                  )),
                              Container(
                                alignment: Alignment.centerLeft,
                                padding: const EdgeInsets.fromLTRB(5, 5, 10, 5),
                                child: Text(
                                  controller.productList.value?[index].name ??
                                      "",
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontFamily: MyFont.myFont,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              // Container(
                              //   padding: const EdgeInsets.fromLTRB(5, 0, 10, 3),
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //     children: [
                              //       Text(
                              //         (controller.productList.value?[index].weight)
                              //                 ?.toStringAsFixed(0) ??
                              //             "",
                              //         style: TextStyle(
                              //           fontFamily: MyFont.myFont,
                              //           fontWeight: FontWeight.bold,
                              //           color: MyColors.grey,
                              //           fontSize: 10,
                              //         ),
                              //       )
                              //     ],
                              //   ),
                              // ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding:
                                    const EdgeInsets.fromLTRB(5, 5, 0, 5),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '\$ ${controller.productList
                                              .value?[index].averageCost
                                              ?.toStringAsFixed(2)}',
                                          style: TextStyle(
                                            fontFamily: MyFont.myFont,
                                            color: MyColors.grey,
                                            decoration:
                                            TextDecoration.lineThrough,
                                            fontSize: 10,
                                          ),
                                        ),
                                        Text(
                                          '\$ ${(controller.productList
                                              .value?[index].sellingCost)
                                              ?.toStringAsFixed(2)}',
                                          style: TextStyle(
                                            fontFamily: MyFont.myFont,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    child: (controller
                                        .productList[index].qtycount ==
                                        0)
                                        ? GestureDetector(
                                      onTap: () async {
                                        ProductModel? selectedProduct =
                                        controller
                                            .productList.value[index];
                                        if (savedProduct.contains(
                                            selectedProduct
                                                .productCode)) {
                                          var selectedIndex = controller
                                              .cartAddedProduct
                                              .indexWhere((element) =>
                                          element.productCode ==
                                              selectedProduct
                                                  .productCode);

                                          controller.cartAddedProduct
                                              .removeAt(selectedIndex);
                                          savedProduct.remove(
                                              selectedProduct
                                                  .productCode);
                                        }
                                        setState(() {
                                          controller.cartService
                                              .addToCart(
                                              product:
                                              selectedProduct);
                                          controller.updateProductCount();
                                        });

                                        if (selectedProduct.qtycount !=
                                            0) {
                                          bool isAlreadyAdded = controller
                                              .cartAddedProduct
                                              .any((element) =>
                                          element.productCode ==
                                              selectedProduct
                                                  .productCode);

                                          if (!isAlreadyAdded) {
                                            controller.cartAddedProduct
                                                .add(selectedProduct);
                                          }
                                        }
                                        await PreferenceHelper
                                            .saveCartData(controller
                                            .cartAddedProduct);
                                      },
                                      child: Card(
                                        color: MyColors.mainTheme,
                                        shape:
                                        const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(6)),
                                        ),
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 8),
                                          child: Text(
                                            "Add",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: MyFont.myFont,
                                              fontWeight: FontWeight.bold,
                                              color: MyColors.white,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                        : Card(
                                      color: MyColors.mainTheme,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(6)),
                                      ),
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.symmetric(
                                            horizontal: 1,
                                            vertical: 5.5),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceAround,
                                          children: [
                                            GestureDetector(
                                              onTap: () async {
                                                ProductModel?
                                                selectedProduct =
                                                controller
                                                    .productList[
                                                index];

                                                setState(() {
                                                  controller.cartService
                                                      .removeFromCart(
                                                      product:
                                                      selectedProduct);
                                                  controller
                                                      .updateProductCount();
                                                });

                                                if (selectedProduct
                                                    .qtycount ==
                                                    0) {
                                                  if (controller
                                                      .cartAddedProduct
                                                      .any((element) =>
                                                  element
                                                      .productCode ==
                                                      selectedProduct
                                                          .productCode)) {
                                                    var selectedIndex = controller
                                                        .cartAddedProduct
                                                        .indexWhere((element) =>
                                                    element
                                                        .productCode ==
                                                        selectedProduct
                                                            .productCode);

                                                    controller
                                                        .cartAddedProduct
                                                        .removeAt(
                                                        selectedIndex);
                                                    if (controller
                                                        .cartAddedProduct
                                                        .isEmpty) {
                                                      controller
                                                          .cartAddedProduct
                                                          .clear();
                                                    }
                                                  }
                                                }
                                                // bottomAppBar(index);
                                                // if (controller.productList[index].qtycount == 0) {
                                                //   controller.cartAddedProduct.length = 0;
                                                // }
                                                await PreferenceHelper
                                                    .saveCartData(controller
                                                    .cartAddedProduct);
                                              },
                                              child: Container(
                                                child: const Icon(
                                                  Icons.remove,
                                                  color: MyColors.white,
                                                  size: 18,
                                                ),
                                              ),
                                            ),
                                            // Obx(() {
                                            //   return
                                            Container(
                                              child: AnimatedSwitcher(
                                                duration: const Duration(
                                                    milliseconds: 300),
                                                transitionBuilder:
                                                    (Widget child,
                                                    Animation<double>
                                                    animation) {
                                                  return ScaleTransition(
                                                      scale: animation,
                                                      child: child);
                                                },
                                                child: SizedBox(
                                                  width: 20,
                                                  child: Text(
                                                    '${controller
                                                        .productList[index]
                                                        .qtycount.toInt()}',
                                                    key: ValueKey<int>(
                                                      controller
                                                          .productList[
                                                      index]
                                                          .qtycount
                                                          .toInt() ??
                                                          0,
                                                    ),
                                                    style: TextStyle(
                                                      fontFamily:
                                                      MyFont.myFont,
                                                      color:
                                                      MyColors.white,
                                                      fontSize: 16,
                                                    ),
                                                    textAlign:
                                                    TextAlign.center,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            // }),
                                            GestureDetector(
                                              onTap: () async {
                                                ProductModel?
                                                selectedProduct =
                                                controller.productList
                                                    .value[index];
                                                if (savedProduct.contains(
                                                    selectedProduct
                                                        .productCode)) {
                                                  var selectedIndex = controller
                                                      .cartAddedProduct
                                                      .indexWhere((element) =>
                                                  element
                                                      .productCode ==
                                                      selectedProduct
                                                          .productCode);

                                                  controller
                                                      .cartAddedProduct
                                                      .removeAt(
                                                      selectedIndex);
                                                  savedProduct.remove(
                                                      selectedProduct
                                                          .productCode);
                                                }
                                                setState(() {
                                                  controller.cartService
                                                      .addToCart(
                                                      product:
                                                      selectedProduct);
                                                  controller
                                                      .updateProductCount();
                                                });

                                                if (selectedProduct
                                                    .qtycount !=
                                                    0) {
                                                  bool isAlreadyAdded = controller
                                                      .cartAddedProduct
                                                      .any((element) =>
                                                  element
                                                      .productCode ==
                                                      selectedProduct
                                                          .productCode);

                                                  if (!isAlreadyAdded) {
                                                    controller
                                                        .cartAddedProduct
                                                        .add(
                                                        selectedProduct);
                                                  }
                                                }
                                                await PreferenceHelper
                                                    .saveCartData(controller
                                                    .cartAddedProduct);
                                              },
                                              child: const Icon(
                                                Icons.add,
                                                color: MyColors.white,
                                                size: 18,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )),
                    );
                  });
            }),
          ),
          if (controller.status.isLoadingMore)
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      );
    } else if (controller.status.isLoadingMore || controller.status.isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 150),
          child: Text("No product Found"),
        ),
      );
    }
    // if (controller.status.isLoadingMore || controller.status.isLoading) {
    //   return Container();
    // }
    // return const Center(
    //   child: Padding(
    //     padding: EdgeInsets.symmetric(vertical: 150),
    //     child: Text("No product Found"),
    //   ),
    // );
  }

  bottomAppBar(index) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: MyColors.mainTheme,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        onPressed: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                '${controller.productList[index].qtycount} items  |  \$ ${controller.productList[index].sellingCost?.toStringAsFixed(2)}  ',
                style: TextStyle(
                  fontFamily: MyFont.myFont,
                  fontWeight: FontWeight.bold,
                  color: MyColors.white,
                  fontSize: 16,
                ),
              ),
              Text(
                '\$ ${123.toStringAsFixed(2)}    ',
                style: TextStyle(
                  fontFamily: MyFont.myFont,
                  fontWeight: FontWeight.bold,
                  color: MyColors.black1,
                  decoration: TextDecoration.lineThrough,
                  fontSize: 13,
                ),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.shopping_cart,
                    color: MyColors.white,
                    size: 25,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'view',
                    style: TextStyle(
                        fontFamily: MyFont.myFont,
                        fontWeight: FontWeight.bold,
                        color: MyColors.white,
                        fontSize: 18),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///sub-sub category
  subSubCategoryListView() {
    return Obx(() {
      return (controller.subSubCategoryList.value != null)
          ? ListView.builder(
              itemCount: controller.subSubCategoryList.value?.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              // padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: GestureDetector(
                    onTap: () async {
                      setState(
                        () {
                          issubSubSelected = index;

                        },
                      );
                      controller.subSubcategory.value = index;
                      controller.currentPage = 1;
                      controller.totalPages = 1;
                      controller.productList.clear();
                      if (index == 0) {
                        selectedSubSubCategoryId = "";
                        setState(() {
                          controller.getProductByCategoryId(
                              categoryId: catrogryModel?.code ?? '',
                              subCategoryId: slectedSubCategoryId,
                              isPagination: false,
                              subCategoryL2Name: '');
                        });
                      } else {
                        selectedSubSubCategoryId = controller.subSubCategoryList.value?[index].code ?? "";
                        await controller.getProductByCategoryId(
                            categoryId: catrogryModel?.code ?? '',
                            subCategoryId: slectedSubCategoryId,
                            isPagination: false,
                            subCategoryL2Name: selectedSubSubCategoryId);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Column(
                        children: [
                          Container(
                            margin: issubSubSelected == index
                                ? const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20)
                                : const EdgeInsets.only(
                                    top: 10,
                                    bottom: 10,
                                    right: 5,
                                    left: 5,
                                  ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5,
                            ),
                            decoration: issubSubSelected == index
                                ? const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(100),
                                        bottomRight: Radius.circular(100)),
                                    color: MyColors.mainTheme,
                                  )
                                : BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: MyColors.lightGreen4,
                                  ),
                            height: 50,
                            width: 50,
                            child: Container(
                              clipBehavior: Clip.hardEdge,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: SizedBox(
                                child: (controller
                                            .subSubCategoryList
                                            .value?[index]
                                            .subCategoryL2ImageFilePath !=
                                        null)
                                    ? ("${controller.subSubCategoryList.value?[index].subCategoryL2ImageFilePath}"
                                            .isNotEmpty)
                                        ? Image.network(
                                            '${controller.subSubCategoryList.value?[index].subCategoryL2ImageFilePath}',
                                            height: height(context) / 200,
                                            width: width(context) / 200,
                                            fit: BoxFit.contain,
                                          )
                                        : Image.asset(
                                            Assets.noImage,
                                            height: height(context) / 200,
                                            width: width(context) / 200,
                                            fit: BoxFit.contain,
                                          )
                                    : Image.asset(
                                        Assets.noImage,
                                        height: height(context) / 200,
                                        width: width(context) / 200,
                                        fit: BoxFit.contain,
                                      ),
                                //     Image.asset(
                                //   Assets.noImage,
                                //   height: height(context) / 200,
                                //   width: width(context) / 200,
                                //   fit: BoxFit.contain,
                                // ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width(context) / 5,
                            child: Text(
                              controller
                                      .subSubCategoryList.value?[index].name ??
                                  " ",
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              style: TextStyle(
                                  fontFamily: Constant.myFont,
                                  fontWeight: FontWeight.w500,
                                  color: MyColors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              })
          : Container();
    });
  }
}
