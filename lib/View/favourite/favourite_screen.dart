import 'package:Catchyfive/Const/approutes.dart';
import 'package:Catchyfive/Const/assets.dart';
import 'package:Catchyfive/Const/colors.dart';
import 'package:Catchyfive/Const/font.dart';
import 'package:Catchyfive/Const/size.dart';
import 'package:Catchyfive/View/dashboard/dashboard_controller.dart';
import 'package:Catchyfive/View/sub_categories/subcategory_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Helper/preferenceHelper.dart';
import '../../Model/catagroy/ProductModel.dart';
import 'FavScreenApiController.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  late DashBoardController dashBoardController;
  late SubCategoryController controller;
  late FavScreenController favScreenController;
  List<String> savedProduct = [];

  @override
  void initState() {
    print("qwertyui");
    super.initState();
    dashBoardController = Get.put(DashBoardController());
    controller = Get.put(SubCategoryController());
    favScreenController = Get.put(FavScreenController());
    controller.cartService.cartChangeStream.listen((_) {
      setState(() {});
    });
    initData();
  }

  initData() async {
    favScreenController.productList.value.length = 0;
    await favScreenController.GetFavProduct();
  }

  Future<void> _refreshData() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      dashBoardController = Get.find<DashBoardController>();
      controller = Get.put(SubCategoryController());
      favScreenController = Get.put(FavScreenController());
      initData();
    });
  }

  @override
  Widget build(BuildContext context) {
    controller.updateProductCount();
    // initData();
    return GetBuilder<FavScreenController>(builder: (state) {
      if (favScreenController.isproductLoading.value == true) {
        return Scaffold(
          body: Container(
            color: MyColors.white,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      }
      return Scaffold(
        backgroundColor: MyColors.white,
        appBar: AppBar(
          toolbarHeight: 70,
          leading: IconButton(
            onPressed: () {
              Get.offAndToNamed(AppRoutes.bottomNavBar0);
            },
            icon:
            const Icon(Icons.arrow_back_ios_rounded, color: MyColors.white),
          ),
          title: Text(
            'Favourite',
            style: TextStyle(
                fontFamily: MyFont.myFont,
                fontWeight: FontWeight.w900,
                fontSize: 19,
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
            buildAppBarCartButton(),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: _refreshData,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height(context) / 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    'Your Favourite Picks',
                    style: TextStyle(
                      fontFamily: MyFont.myFont,
                      fontWeight: FontWeight.w900,
                      fontSize: 19,
                    ),
                  ),
                ),
                SizedBox(height: height(context) / 50),
                Container(
                  // height: height(context),
                  // color: MyColors.w,
                  child: yourFavouritePicksList(),
                ),
                if (favScreenController.productList.isEmpty)
                  SizedBox(
                      height: height(context) / 2,
                      child: Center(
                          child: Text("No Favourite Product Found"))),
                if (favScreenController.productList.isEmpty)
                  SizedBox(
                      height: height(context) / 2.6,
                      child: Center(
                          child: Text(" ")))
              ],
            ),
          ),
        ),
      );
    });
  }

  yourFavouritePicksList() {
    return GridView.builder(
      physics: const ScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: .7,
      ),
      itemCount: favScreenController.productList.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(left: 5, right: 5),
          child: Card(
              elevation: 5,
              shadowColor: MyColors.black,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              horizontal: 8, vertical: 3),
                          child: Text(
                            "30 % Off",
                            style: TextStyle(
                              fontFamily: MyFont.myFont,
                              fontWeight: FontWeight.bold,
                              color: MyColors.white,
                              fontSize: 9,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 8),
                        child: GestureDetector(
                          onTap: () {
                            favScreenController.productList.value[index]
                                .isfavourite =
                            !favScreenController
                                .productList.value[index].isfavourite;
                            if (favScreenController.productList
                                .value[index].isfavourite ==
                                true) {
                              favScreenController.UnFavProduct(
                                  productModel: favScreenController
                                      .productList.value[index]);
                            } else {
                              favScreenController.changeFavProduct(
                                  productModel: favScreenController
                                      .productList.value[index]);
                            }
                          },
                          child: Icon(
                            (favScreenController
                                .productList.value[index].isfavourite)
                                ? Icons.favorite_outline_rounded
                                : Icons.favorite_outlined,
                            color: MyColors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height(context) / 50),
                  GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.aboutProductScreen,
                            arguments: favScreenController
                                .productList.value[index]);
                      },
                      child: SizedBox(
                        child: (favScreenController
                            .productList[index].productImagePath!
                            .startsWith("/Content/images/"))
                            ? Image.asset(
                          Assets.noImage,
                          height: height(context) / 9,
                          width: width(context) / 5,
                        )
                            : (favScreenController.productList[index]
                            .productImagePath !=
                            null)
                            ? ("${favScreenController.productList[index].productImagePath}"
                            .isNotEmpty)
                            ? Image.network(
                          '${favScreenController.productList[index].productImagePath}',
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
                    padding: const EdgeInsets.fromLTRB(15, 5, 10, 5),
                    child: Text(
                      "${favScreenController.productList[index].productName}",
                      maxLines: 2,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: MyFont.myFont,
                        fontWeight: FontWeight.w800,
                        fontSize: 10,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(15, 0, 10, 3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '1000 g',
                          style: TextStyle(
                            fontFamily: MyFont.myFont,
                            fontWeight: FontWeight.bold,
                            color: MyColors.grey,
                            fontSize: 10,
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 5, 10, 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '100',
                              style: TextStyle(
                                fontFamily: MyFont.myFont,
                                color: MyColors.grey,
                                decoration: TextDecoration.lineThrough,
                                fontSize: 10,
                              ),
                            ),
                            Text(
                              "${favScreenController.productList[index].sellingCost}",
                              style: TextStyle(
                                fontFamily: MyFont.myFont,
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: (favScreenController
                            .productList[index].qtycount ==
                            0)
                            ? GestureDetector(
                          onTap: () async {
                            ProductModel? selectedProduct =
                            favScreenController
                                .productList.value[index];
                            if (savedProduct.contains(
                                selectedProduct.productCode)) {
                              var selectedIndex = controller
                                  .cartAddedProduct
                                  .indexWhere((element) =>
                              element.productCode ==
                                  selectedProduct.productCode);

                              controller.cartAddedProduct
                                  .removeAt(selectedIndex);
                              savedProduct.remove(
                                  selectedProduct.productCode);
                            }
                            setState(() {
                              controller.cartService.addToCart(
                                  product: selectedProduct);
                              controller.updateProductCount();
                            });

                            if (selectedProduct.qtycount != 0) {
                              bool isAlreadyAdded = controller
                                  .cartAddedProduct
                                  .any((element) =>
                              element.productCode ==
                                  selectedProduct.productCode);

                              if (!isAlreadyAdded) {
                                controller.cartAddedProduct
                                    .add(selectedProduct);
                              }
                            }
                            await PreferenceHelper.saveCartData(
                                controller.cartAddedProduct);
                          },
                          child: Card(
                            color: MyColors.mainTheme,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(6)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 8),
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
                            padding: const EdgeInsets.symmetric(
                                horizontal: 1, vertical: 5.5),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceAround,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    ProductModel? selectedProduct =
                                    favScreenController
                                        .productList[index];

                                    setState(() {
                                      controller.cartService
                                          .removeFromCart(
                                          product:
                                          selectedProduct);
                                      controller
                                          .updateProductCount();
                                    });

                                    if (selectedProduct.qtycount ==
                                        0) {
                                      if (controller
                                          .cartAddedProduct
                                          .any((element) =>
                                      element.productCode ==
                                          selectedProduct
                                              .productCode)) {
                                        var selectedIndex = controller
                                            .cartAddedProduct
                                            .indexWhere((element) =>
                                        element
                                            .productCode ==
                                            selectedProduct
                                                .productCode);

                                        controller.cartAddedProduct
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
                                        '${favScreenController.productList[index].qtycount.toInt()}',
                                        key: ValueKey<int>(
                                          favScreenController
                                              .productList[
                                          index]
                                              .qtycount
                                              .toInt() ??
                                              0,
                                        ),
                                        style: TextStyle(
                                          fontFamily: MyFont.myFont,
                                          color: MyColors.white,
                                          fontSize: 16,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                                // }),
                                GestureDetector(
                                  onTap: () async {
                                    ProductModel? selectedProduct =
                                    favScreenController
                                        .productList
                                        .value[index];
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
                                      controller
                                          .updateProductCount();
                                    });

                                    if (selectedProduct.qtycount !=
                                        0) {
                                      bool isAlreadyAdded =
                                      controller
                                          .cartAddedProduct
                                          .any((element) =>
                                      element
                                          .productCode ==
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
      },
    );
    // : SizedBox(
    //     height: height(context) / 2,
    //     child: const Center(child: Text("No Favourite Product Found")));
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
                // initData();
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
}
