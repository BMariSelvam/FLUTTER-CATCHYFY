import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Const/approutes.dart';
import '../../Const/assets.dart';
import '../../Const/colors.dart';
import '../../Const/font.dart';
import '../../Const/size.dart';
import '../../Helper/preferenceHelper.dart';
import '../../Model/catagroy/ProductModel.dart';
import '../sub_categories/subcategory_controller.dart';
import 'SearchProductController.dart';

class ProductSearchScreen extends StatefulWidget {
  const ProductSearchScreen({Key? key}) : super(key: key);

  @override
  State<ProductSearchScreen> createState() => _ProductSearchScreenState();
}

class _ProductSearchScreenState extends State<ProductSearchScreen> {
  late SearchProductController productController;
  final ScrollController _scrollController = ScrollController();

  late SubCategoryController controller;
  final _scrollThreshold = 200.0;
  String TypeValue = "";
  List<String> savedProduct = [];

  @override
  void initState() {
    super.initState();
    productController = Get.put(SearchProductController());
    controller = Get.put(SubCategoryController());
    _scrollController.addListener(_scrollListener);
    controller.cartService.cartChangeStream.listen((_) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    productController.productList.clear();
    _scrollController.dispose();
    productController.searchController.clear();
  }

  Future<void> _scrollListener() async {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      if (productController.currentPage <= productController.totalPages &&
          !productController.status.isLoadingMore) {
        productController.getProductByCategoryId(
            isPagination: true, Text: TypeValue);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        leading: IconButton(
          onPressed: () {
            Get.offAndToNamed(AppRoutes.bottomNavBar0);
          },
          icon: const Icon(Icons.arrow_back_ios_rounded, color: MyColors.white),
        ),
        title: Text(
          'Search Products',
          style: TextStyle(
              fontFamily: MyFont.myFont,
              fontWeight: FontWeight.w900,
              fontSize: 19,
              color: MyColors.white),
        ),
        actions: [
          buildAppBarCartButton(),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (text) {
                TypeValue = text;
                productController.searchController.text = text;
                productController.currentPage = 1;
                
                productController.getProductByCategoryId(
                    Text: text, isPagination: false,
                );
                if (text.isEmpty) {
                  productController.productList.clear();
                }
              },
              controller: productController.searchController,
              decoration: InputDecoration(
                  hintText: 'Search products',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        productController.searchController.clear();
                      });

                      if (productController.searchController.text.isEmpty) {
                        productController.productList.clear();
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(right: 11.0, top: 10),
                      child: Icon(
                        Icons.clear,
                        color: MyColors.red,
                      ),
                    ),
                  )),
            ),
          ),
          Expanded(
            child: Obx(
              () {
                if (productController.productList.isEmpty) {
                  return const Center(
                    child: Text('No products found.'),
                  );
                } else {
                  return GridView.builder(
                    controller: _scrollController,
                    physics: const ScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: .8,
                    ),
                    itemCount: productController.productList.length,
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
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: GestureDetector(
                                        onTap: () {
                                             setState(() {
                                               productController.productList
                                                   .value[index].isfavourite =
                                               !productController.productList
                                                   .value[index].isfavourite;
                                               if (productController.productList
                                                   .value[index].isfavourite ==
                                                   true) {
                                                 productController.changeFavProduct(
                                                     productModel: productController
                                                         .productList.value[index]);
                                               } else {
                                                 productController.UnFavProduct(
                                                     productModel: productController
                                                         .productList.value[index]);
                                               }
                                             });
                                        },
                                        child: Icon(
                                          (productController.productList
                                                  .value[index].isfavourite)
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
                                      Get.toNamed(AppRoutes.aboutProductScreen,
                                          arguments: productController
                                              .productList.value[index]);
                                    },
                                    child: SizedBox(
                                      child: (productController
                                              .productList[index]
                                              .productImagePath!
                                              .startsWith("/Content/images/"))
                                          ? Image.asset(
                                              Assets.noImage,
                                              height: height(context) / 9,
                                              width: width(context) / 5,
                                            )
                                          : (productController
                                                      .productList[index]
                                                      .productImagePath !=
                                                  null)
                                              ? ("${productController.productList[index].productImagePath}"
                                                      .isNotEmpty)
                                                  ? Image.network(
                                                      '${productController.productList[index].productImagePath}',
                                                      height:
                                                          height(context) / 9,
                                                      width: width(context) / 5,
                                                    )
                                                  : Image.asset(
                                                      Assets.noImage,
                                                      height:
                                                          height(context) / 9,
                                                      width: width(context) / 5,
                                                    )
                                              : const Icon(Icons.error),
                                    )),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding:
                                      const EdgeInsets.fromLTRB(15, 5, 10, 5),
                                  child: Text(
                                    "${productController.productList[index].productName}",
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
                                  padding:
                                      const EdgeInsets.fromLTRB(15, 0, 10, 3),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          15, 5, 10, 5),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '100',
                                            style: TextStyle(
                                              fontFamily: MyFont.myFont,
                                              color: MyColors.grey,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              fontSize: 10,
                                            ),
                                          ),
                                          Text(
                                            "${productController.productList[index].sellingCost}",
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
                                      child: (productController
                                                  .productList[index]
                                                  .qtycount ==
                                              0)
                                          ? GestureDetector(
                                              onTap: () async {
                                                ProductModel? selectedProduct =
                                                    productController
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
                                              child: Card(
                                                color: MyColors.mainTheme,
                                                shape:
                                                    const RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(6)),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 10,
                                                      vertical: 8),
                                                  child: Text(
                                                    "Add",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily: MyFont.myFont,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: MyColors.white,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Card(
                                              color: MyColors.mainTheme,
                                              shape:
                                                  const RoundedRectangleBorder(
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
                                                            productController
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
                                                        duration:
                                                            const Duration(
                                                                milliseconds:
                                                                    300),
                                                        transitionBuilder:
                                                            (Widget child,
                                                                Animation<
                                                                        double>
                                                                    animation) {
                                                          return ScaleTransition(
                                                              scale: animation,
                                                              child: child);
                                                        },
                                                        child: SizedBox(
                                                          width: 20,
                                                          child: Text(
                                                            '${productController.productList[index].qtycount.toInt()}',
                                                            key: ValueKey<int>(
                                                              productController
                                                                      .productList[
                                                                          index]
                                                                      .qtycount
                                                                      .toInt() ??
                                                                  0,
                                                            ),
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  MyFont.myFont,
                                                              color: MyColors
                                                                  .white,
                                                              fontSize: 16,
                                                            ),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    // }),
                                                    GestureDetector(
                                                      onTap: () async {
                                                        ProductModel?
                                                            selectedProduct =
                                                            productController
                                                                .productList
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
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
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
                message: "Please select at least one product",
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
