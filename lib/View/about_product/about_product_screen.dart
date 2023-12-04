import 'package:Catchyfive/Const/approutes.dart';
import 'package:Catchyfive/Const/assets.dart';
import 'package:Catchyfive/Const/colors.dart';
import 'package:Catchyfive/Const/font.dart';
import 'package:Catchyfive/Const/size.dart';
import 'package:Catchyfive/Model/catagroy/ProductModel.dart';
import 'package:Catchyfive/View/dashboard/dashboard_controller.dart';
import 'package:Catchyfive/View/sub_categories/subcategory_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../Helper/preferenceHelper.dart';

class AboutProductScreen extends StatefulWidget {
  const AboutProductScreen({super.key});

  @override
  State<AboutProductScreen> createState() => _AboutProductScreenState();

}

class _AboutProductScreenState extends State<AboutProductScreen> {
  late DashBoardController dashBoardController;
  late SubCategoryController controller;
  late ProductModel productModel;
  List<String> savedProduct = [];

  @override
  void initState() {
    super.initState();
    dashBoardController = Get.put(DashBoardController());
    controller = Get.put(SubCategoryController());
    controller.cartService.cartChangeStream.listen((_) {
      setState(() {});
    });
    initData();
    controller.updateProductCount();
  }

  initData() async {
    productModel = Get.arguments as ProductModel;
  }


  bool _isAbout = false;
  @override
  Widget build(BuildContext context) {
    controller.updateProductCount();
    return GetBuilder<SubCategoryController>(builder: (state) {
      return Scaffold(
        backgroundColor: MyColors.white,
        appBar: AppBar(
          backgroundColor: MyColors.mainTheme,
          toolbarHeight: 70,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
                Icons.arrow_back_ios_rounded, color: MyColors.white),
          ),
          iconTheme: const IconThemeData(color: MyColors.white),
          title: Text(
            'Products',
            style: TextStyle(
                fontFamily: MyFont.myFont,
                fontWeight: FontWeight.normal,
                color: MyColors.white),
          ),
          actions: [
            buildAppBarCartButton(),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(height: height(context) / 50),
                  SizedBox(
                      child: Row(
                        children: [
                          // IconButton(
                          //     onPressed: () {}, icon: const Icon(Icons.share)),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  productModel.isfavourite =
                                  !productModel.isfavourite;
                                  if (productModel.isfavourite == true) {
                                    controller.changeFavProduct(
                                        productModel: productModel);
                                  } else {
                                    controller.UnFavProduct(
                                        productModel: productModel);
                                  }
                                });
                              },
                              icon: Icon(
                                (productModel.isfavourite)
                                    ? Icons.favorite_outlined
                                    : Icons.favorite_outline_rounded,
                                color: MyColors.red,
                              ))
                        ],
                      )),
                ],
              ),
              SizedBox(
                height: height(context) / 4,
                width: width(context),
                child: PageView.builder(
                  itemCount: 2,
                  controller: dashBoardController.productController,
                  itemBuilder: (context, pagePosition) {
                    return Container(
                      margin: const EdgeInsets.fromLTRB(50, 5, 50, 5),
                      decoration: BoxDecoration(
                        color: MyColors.background,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: (productModel.productImagePath != null)
                          ? ("${productModel.productImagePath}".isNotEmpty)
                          ? Image.network('${productModel.productImagePath}',
                          fit: BoxFit.contain)
                          : Image.asset(Assets.noImage)
                          : const Icon(Icons.error),
                    );
                  },
                ),
              ),
              SizedBox(height: height(context) / 50),
              Center(
                child: SmoothPageIndicator(
                  controller: dashBoardController.productController,
                  count: 2,
                  effect: const SlideEffect(
                    activeDotColor: MyColors.mainTheme,
                    dotWidth: 6,
                    dotHeight: 5,
                    spacing: 4,
                  ),
                ),
              ),
              SizedBox(
                height: height(context) / 50,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                child: Text(
                  productModel.productName.toString(),
                  style: TextStyle(
                    fontFamily: MyFont.myFont,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: MyColors.mainTheme,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(25, 0, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("",
                      // productModel.weight.toString(),
                      style: TextStyle(
                        fontFamily: MyFont.myFont,
                        fontWeight: FontWeight.bold,
                        color: MyColors.grey,
                        fontSize: 12,
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: (productModel.qtycount == 0)
                          ? GestureDetector(
                        onTap: () async {
                          ProductModel? selectedProduct = productModel;
                          if (savedProduct.contains(
                              selectedProduct.productCode)) {
                            var selectedIndex = controller
                                .cartAddedProduct
                                .indexWhere((element) =>
                            element.productCode ==
                                selectedProduct
                                    .productCode);

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
                                selectedProduct
                                    .productCode);
                            if (!isAlreadyAdded) {
                              controller.cartAddedProduct
                                  .add(selectedProduct);
                            }
                          }
                          await PreferenceHelper.saveCartData(controller
                              .cartAddedProduct);
                        },
                        child: Card(
                          color: MyColors.mainTheme,
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(6)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 8),
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
                          borderRadius:
                          BorderRadius.all(Radius.circular(6)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 5.5),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  bool isAlreadyAdded = controller
                                      .cartAddedProduct
                                      .any((element) =>
                                  element.productCode ==
                                      productModel.productCode);

                                  if (productModel.qtycount != 0) {
                                    if (!isAlreadyAdded) {
                                      controller.cartAddedProduct
                                          .add(productModel);
                                    }
                                  }
                                  setState(() {
                                    controller.cartService
                                        .removeFromCart(
                                        product: productModel);
                                    controller
                                        .updateProductCount();
                                  });
                                  if (controller
                                      .cartAddedProduct[controller
                                      .selectedIndex.value]
                                      .qtycount ==
                                      0) {
                                    if (controller.cartAddedProduct.any(
                                            (element) =>
                                        element.productCode ==
                                            productModel.productCode)) {
                                      var selectedIndex = controller
                                          .cartAddedProduct
                                          .indexWhere((element) =>
                                      element.productCode ==
                                          productModel.productCode);

                                      controller.cartAddedProduct
                                          .removeAt(selectedIndex);
                                    }
                                  }
                                  await PreferenceHelper.saveCartData(
                                      controller.cartAddedProduct);
                                },
                                child: Container(
                                  child: const Icon(
                                    Icons.remove,
                                    color: MyColors.white,
                                    size: 18,
                                  ),
                                ),
                              ),
                              Container(
                                child: AnimatedSwitcher(
                                  duration:
                                  const Duration(milliseconds: 300),
                                  transitionBuilder: (Widget child,
                                      Animation<double> animation) {
                                    return ScaleTransition(
                                        scale: animation, child: child);
                                  },
                                  child: SizedBox(
                                    width: 30,
                                    child: Text(
                                      '${productModel.qtycount.toInt()}',
                                      key: ValueKey<int>(
                                        productModel.qtycount.toInt(),
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
                              GestureDetector(
                                onTap: () async {
                                  bool isAlreadyAdded = controller
                                      .cartAddedProduct
                                      .any((element) =>
                                  element.productCode ==
                                      productModel.productCode);

                                  if (productModel.qtycount != 0) {
                                    if (!isAlreadyAdded) {
                                      controller.cartAddedProduct
                                          .add(productModel);
                                    }
                                  }
                                  setState(() {
                                    controller.cartService.addToCart(
                                        product: productModel);
                                    controller.updateProductCount();
                                  });
                                  if (controller
                                      .cartAddedProduct[controller
                                      .selectedIndex.value]
                                      .qtycount ==
                                      0) {
                                    if (controller.cartAddedProduct.any(
                                            (element) =>
                                        element.productCode ==
                                            productModel.productCode)) {
                                      var selectedIndex = controller
                                          .cartAddedProduct
                                          .indexWhere((element) =>
                                      element.productCode ==
                                          productModel.productCode);

                                      controller.cartAddedProduct
                                          .removeAt(selectedIndex);
                                    }
                                  }
                                  await PreferenceHelper.saveCartData(
                                      controller.cartAddedProduct);
                                },
                                child: Container(
                                  child: const Icon(
                                    Icons.add,
                                    color: MyColors.white,
                                    size: 18,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(23, 0, 20, 0),
                    child: Row(
                      children: [
                        Text(
                          "\$ ${productModel.sellingCost.toString()}",
                          style: TextStyle(
                            fontFamily: MyFont.myFont,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: MyColors.mainTheme,
                          ),
                        ),
                        SizedBox(
                          width: width(context) / 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 3, 10, 0),
                          child: Text(
                            "\$ ${productModel.averageCost.toString()}",
                            style: TextStyle(
                              fontFamily: MyFont.myFont,
                              fontWeight: FontWeight.bold,
                              color: MyColors.lightGreen3,
                              decoration: TextDecoration.lineThrough,
                              fontSize: 11,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width(context) / 80,
                        ),
                        Card(
                          color: MyColors.mainTheme,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Text(
                              "9% Off",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: MyFont.myFont,
                                fontWeight: FontWeight.bold,
                                color: MyColors.white,
                                fontSize: 9,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: height(context) / 50),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isAbout = !_isAbout;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  height: height(context) / 20,
                  color: MyColors.lightGreen2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'About Product',
                        style: TextStyle(
                          fontFamily: MyFont.myFont,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Icon(_isAbout
                          ? Icons.keyboard_arrow_up_outlined
                          : Icons.keyboard_arrow_down_outlined),
                    ],
                  ),
                ),
              ),
              SizedBox(height: height(context) / 50),
              _isAbout
                  ? Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: height(context) / 100),
                      Text(
                        "Types of onions: There are several types of onions, each with distinct characteristics. Common varieties include yellow onions (all-purpose onions with a strong flavor), red onions (milder and slightly sweeter), white onions (milder and slightly tangy), and sweet onions (such as Vidalia and Walla Walla, which are less pungent and have a higher sugar content)",
                        style: TextStyle(
                          fontFamily: MyFont.myFont,
                          fontSize: 15,
                          color: MyColors.greyText,
                        ),
                      ),
                    ],
                  ),
                ),
              )
                  : Container(),
              // Padding(
              //   padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              //   child: Text(
              //     'Similar Products',
              //     style: TextStyle(
              //       fontFamily: MyFont.myFont,
              //       fontWeight: FontWeight.bold,
              //       fontSize: 15,
              //     ),
              //   ),
              // ),
              // SizedBox(height: height(context) / 80),
              // similarProductList(),
              // SizedBox(height: height(context) / 80),
              // Padding(
              //   padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              //   child: Text(
              //     'You Might Also Like',
              //     style: TextStyle(
              //       fontFamily: MyFont.myFont,
              //       fontWeight: FontWeight.bold,
              //       fontSize: 15,
              //     ),
              //   ),
              // ),
              // SizedBox(height: height(context) / 80),
              // youMightAlsoLikeList(),
              // SizedBox(height: height(context) / 80),
            ],
          ),
        ),
      );
    });
  }

  similarProductList() {
    return ListView.builder(
      itemCount: 5,
      scrollDirection: Axis.vertical,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(10, 15, 0, 5),
              decoration: BoxDecoration(
                color: MyColors.background,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset(
                height: height(context) / 10,
                Assets.onion,
                fit: BoxFit.fill,
                scale: 5,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width(context) / 1.7,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.fromLTRB(20, 0, 10, 5),
                              child: Text(
                                "Tomato",
                                style: TextStyle(
                                  fontFamily: MyFont.myFont,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: MyColors.mainTheme,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.fromLTRB(25, 0, 20, 0),
                              child: Text(
                                '1 Kg',
                                style: TextStyle(
                                  fontFamily: MyFont.myFont,
                                  fontWeight: FontWeight.bold,
                                  color: MyColors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 0,
                            bottom: 0,
                            right: 20,
                          ),
                          child: (dashBoardController.counter == 0)
                              ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      dashBoardController.increment();
                                    });
                                  },
                                  child: Card(
                                    color: MyColors.mainTheme,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(6)),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 18, vertical: 8),
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 5.5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              dashBoardController.decrement();
                                            });
                                          },
                                          child: Container(
                                            child: const Icon(
                                              Icons.remove,
                                              color: MyColors.white,
                                              size: 18,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: AnimatedSwitcher(
                                            duration: const Duration(
                                                milliseconds: 300),
                                            transitionBuilder: (Widget child,
                                                Animation<double> animation) {
                                              return ScaleTransition(
                                                  scale: animation,
                                                  child: child);
                                            },
                                            child: SizedBox(
                                              width: 30,
                                              child: Text(
                                                '${dashBoardController.counter}',
                                                key: ValueKey<int>(
                                                  dashBoardController.counter,
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
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              dashBoardController.increment();
                                            });
                                          },
                                          child: Container(
                                            child: const Icon(
                                              Icons.add,
                                              color: MyColors.white,
                                              size: 18,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(23, 0, 20, 0),
                    child: Row(
                      children: [
                        Text(
                          '\$ 16.76 ',
                          style: TextStyle(
                            fontFamily: MyFont.myFont,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: MyColors.mainTheme,
                          ),
                        ),
                        SizedBox(
                          width: width(context) / 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 3, 10, 0),
                          child: Text(
                            '\$ 20.76 ',
                            style: TextStyle(
                              fontFamily: MyFont.myFont,
                              fontWeight: FontWeight.bold,
                              color: MyColors.lightGreen3,
                              decoration: TextDecoration.lineThrough,
                              fontSize: 11,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width(context) / 80,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: Text(
                            "9% Off",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: MyFont.myFont,
                              fontWeight: FontWeight.bold,
                              color: MyColors.black,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  youMightAlsoLikeList() {
    return SizedBox(
      height: height(context) / 3,
      child: ListView.builder(
        itemCount: 4,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(left: 2, top: 2, bottom: 2, right: 2),
            width: width(context) / 2.4,
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
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: GestureDetector(
                            onTap: () {
                              Get.toNamed(AppRoutes.favouriteScreen);
                            },
                            child: const Icon(
                              Icons.favorite,
                              color: MyColors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height(context) / 50),
                    GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.aboutProductScreen);
                        },
                        child: Image.asset(
                          Assets.onion,
                          height: height(context) / 9,
                          width: width(context) / 5,
                        )),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.fromLTRB(15, 5, 10, 5),
                      child: Text(
                        "Tomato",
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: MyFont.myFont,
                          fontWeight: FontWeight.w800,
                          fontSize: 12,
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
                                '50',
                                style: TextStyle(
                                  fontFamily: MyFont.myFont,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: (dashBoardController.counter == 0)
                              ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      dashBoardController.increment();
                                    });
                                  },
                                  child: Card(
                                    color: MyColors.mainTheme,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(6)),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 18, vertical: 8),
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 5.5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              dashBoardController.decrement();
                                            });
                                          },
                                          child: Container(
                                            child: const Icon(
                                              Icons.remove,
                                              color: MyColors.white,
                                              size: 18,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: AnimatedSwitcher(
                                            duration: const Duration(
                                                milliseconds: 300),
                                            transitionBuilder: (Widget child,
                                                Animation<double> animation) {
                                              return ScaleTransition(
                                                  scale: animation,
                                                  child: child);
                                            },
                                            child: SizedBox(
                                              width: 30,
                                              child: Text(
                                                '${dashBoardController.counter}',
                                                key: ValueKey<int>(
                                                  dashBoardController.counter,
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
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              dashBoardController.increment();
                                            });
                                          },
                                          child: Container(
                                            child: const Icon(
                                              Icons.add,
                                              color: MyColors.white,
                                              size: 18,
                                            ),
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
      ),
    );
  }

  buildAppBarCartButton() {
    return Obx(() {
      return GestureDetector(
        onTap: () async {
          print("Coar count==============================");
          print(controller.cartAddedProduct.length);
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
}
