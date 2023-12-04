import 'package:Catchyfive/Const/approutes.dart';
import 'package:Catchyfive/Const/assets.dart';
import 'package:Catchyfive/Const/colors.dart';
import 'package:Catchyfive/Const/font.dart';
import 'package:Catchyfive/Const/size.dart';
import 'package:Catchyfive/View/categories/category_controller.dart';
import 'package:Catchyfive/View/sub_categories/subcategory_controller.dart';
import 'package:Catchyfive/constructors/constructors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Helper/preferenceHelper.dart';
import '../../Model/catagroy/ProductModel.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  late CategoryController categoryController;
  late SubCategoryController controller;
  late final List<ProductModel> localData;
  List<String> savedProduct = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    categoryController = Get.put(CategoryController());
    controller = Get.put(SubCategoryController());
    controller.cartService.cartChangeStream.listen((_) {
      setState(() {});
    });
    initData();
  }

  Future<void> initData() async {
    categoryController.getAllCategoryList();
    localData = await PreferenceHelper.getCartData();
    print("==========================localData.length");
    print(localData.length);
    if (localData != null) {
      for (int i = 0; i < localData.length; i++) {
        savedProduct.add(localData[i].productCode!);
      }
      controller.cartAddedProduct.clear();
      controller.cartAddedProduct.addAll(localData);
    }
  }


  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(builder: (logic) {
      if (logic.isLoading.value == true) {
        return const Center(
          child: CircularProgressIndicator(),
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
            'All Categories',
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
                  Get.toNamed(AppRoutes.favouriteScreen);
                },
                child: const Icon(
                  Icons.favorite,
                  color: MyColors.red,
                ),
              ),
            ),
            buildAppBarCartButton(),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // categoryHeadGrid(),
              categorySubGrid(),
            ],
          ),
        ),
      );
    });
  }

  categoryHeadGrid() {
    return Container(
      height: height(context) / 5,
      padding: const EdgeInsets.all(10),
      child: GridView.builder(
          padding: const EdgeInsets.all(0),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: exploreGrid.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {},
              child: Stack(
                children: [
                  SizedBox(
                    height: height(context) / 6,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        Assets.frame7,
                        fit: BoxFit.fill,
                        width: double.maxFinite,
                        height: height(context) / 1,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    child: Column(
                      children: [
                        Container(
                          width: width(context) / 3,
                          height: height(context) / 35,
                          alignment: Alignment.center,
                          child: Text(
                            exploreGrid[index].name,
                            style: TextStyle(
                              fontFamily: MyFont.myFont,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: MyColors.black,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height(context) / 40,
                        ),
                        Container(
                            alignment: Alignment.center,
                            child: Image.asset(
                              height: height(context) / 13,
                              exploreGrid[index].image,
                              alignment: Alignment.center,
                              scale: 2,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }

  categorySubGrid() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GridView.builder(
          padding: const EdgeInsets.all(0),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: categoryController.categoryList.value?.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 0.7,
          ),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Get.toNamed(AppRoutes.subCategoriesScreen,
                    arguments:categoryController.categoryList.value?[index] ?? "");
              },
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 3),
                    margin: EdgeInsets.only(bottom: 5, left: 1),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        Assets.frame8,
                        fit: BoxFit.fill,
                        width: double.maxFinite,
                        height: height(context) / 1,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 5),
                        padding:
                            const EdgeInsets.only(left: 5, top: 2, right: 5),
                        height: height(context) / 26,
                        alignment: Alignment.center,
                        child: Text(
                          categoryController.categoryList.value?[index].name ??
                              " ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: MyFont.myFont,
                            fontWeight: FontWeight.bold,
                            fontSize: 8,
                            color: MyColors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height(context) / 150,
                      ),
                      (categoryController.categoryList.value?[index]
                                  .categoryImageFilePath !=
                              null)
                          ? ("${categoryController.categoryList.value?[index].categoryImageFilePath}"
                                  .isNotEmpty)
                              ? Image.network(
                                  height: height(context) / 18,
                                  alignment: Alignment.center,
                                  categoryController.categoryList.value?[index]
                                          .categoryImageFilePath ??
                                      "",
                                  fit: BoxFit.fill,
                                  scale: 2,
                                )
                              : Image.asset(
                                  Assets.noImage,
                                  height: height(context) / 18,
                                  alignment: Alignment.center,
                                  fit: BoxFit.fill,
                                  scale: 2,
                                )
                          : const Icon(Icons.error),
                    ],
                  ),
                ],
              ),
            );
          }),
    );
  }

  List<SubCategoryGrid> subCategory = [
    SubCategoryGrid(
      name: 'Masala & \nDry Fruits',
      image: Assets.onion,
    ),
    SubCategoryGrid(name: 'Sweet \nCarvings', image: Assets.onion),
    SubCategoryGrid(name: 'FrozenFood\n& IceCream', image: Assets.onion),
    SubCategoryGrid(name: 'Dairy,Bread\nEggs', image: Assets.onion),
    SubCategoryGrid(name: 'Cold Drinks\nJuices', image: Assets.onion),
    SubCategoryGrid(name: 'Munchies', image: Assets.onion),
    SubCategoryGrid(name: 'Meat,Fish\nFood', image: Assets.onion),
    SubCategoryGrid(name: 'breakfast', image: Assets.onion),
    SubCategoryGrid(name: 'Tea,Coffee', image: Assets.onion),
    SubCategoryGrid(name: 'Biscuits', image: Assets.onion),
    SubCategoryGrid(name: 'Home Needs', image: Assets.onion),
    SubCategoryGrid(name: 'Stationary', image: Assets.onion),
    SubCategoryGrid(name: 'Tea,Coffee', image: Assets.onion),
    SubCategoryGrid(name: 'Biscuits', image: Assets.onion),
    SubCategoryGrid(name: 'Home Needs', image: Assets.onion),
    SubCategoryGrid(name: 'Stationary', image: Assets.onion),
    SubCategoryGrid(name: 'Sweet \nCarvings', image: Assets.onion),
    SubCategoryGrid(name: 'FrozenFood\n& IceCream', image: Assets.onion),
    SubCategoryGrid(name: 'Dairy,Bread\nEggs', image: Assets.onion),
    SubCategoryGrid(name: 'Cold Drinks\nJuices', image: Assets.onion),
    SubCategoryGrid(name: 'Munchies', image: Assets.onion),
    SubCategoryGrid(name: 'Meat,Fish\nFood', image: Assets.onion),
    SubCategoryGrid(name: 'breakfast', image: Assets.onion),
    SubCategoryGrid(name: 'Tea,Coffee', image: Assets.onion),
  ];

  List<CategoryHeadGrid> exploreGrid = [
    CategoryHeadGrid(name: 'Season Fruits ', image: Assets.onion),
    CategoryHeadGrid(name: 'Season  ', image: Assets.onion),
  ];

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
