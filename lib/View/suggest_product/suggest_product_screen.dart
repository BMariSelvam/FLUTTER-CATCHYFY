import 'package:Catchyfive/Const/approutes.dart';
import 'package:Catchyfive/Const/assets.dart';
import 'package:Catchyfive/Const/colors.dart';
import 'package:Catchyfive/Const/font.dart';
import 'package:Catchyfive/Const/size.dart';
import 'package:Catchyfive/View/dashboard/dashboard_controller.dart';
import 'package:Catchyfive/View/sub_categories/subcategory_controller.dart';
import 'package:Catchyfive/constructors/constructors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuggestProductScreen extends StatefulWidget {
  const SuggestProductScreen({super.key});

  @override
  State<SuggestProductScreen> createState() => _SuggestProductScreenState();
}

class _SuggestProductScreenState extends State<SuggestProductScreen> {
  late DashBoardController dashBoardController;
  late SubCategoryController controller;

  @override
  void initState() {
    super.initState();
    dashBoardController = Get.put(DashBoardController());
    controller = Get.put(SubCategoryController());
    controller.cartService.cartChangeStream.listen((_) {
      setState(() {});
    });

    // initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        leading: IconButton(
          onPressed: () {
            Get.toNamed(AppRoutes.bottomNavBar);
          },
          icon: const Icon(Icons.arrow_back_ios_rounded, color: MyColors.white),
        ),
        title: Text(
          'Suggest a Product',
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height(context) / 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Fresh of the Farms',
                    style: TextStyle(
                      fontFamily: MyFont.myFont,
                      fontWeight: FontWeight.w900,
                      fontSize: 19,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: InkWell(
                      onTap: () {},
                      child: Card(
                        elevation: 0,
                        color: MyColors.mainTheme,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 0),
                          child: Row(
                            children: [
                              Text(
                                "See All  ",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: MyFont.myFont,
                                  fontWeight: FontWeight.bold,
                                  color: MyColors.white,
                                  fontSize: 10,
                                ),
                              ),
                              const Icon(
                                Icons.arrow_right_alt_rounded,
                                color: MyColors.white,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: height(context) / 50),
            yourFavouritePicksList(),
            SizedBox(height: height(context) / 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Suggested for you',
                    style: TextStyle(
                      fontFamily: MyFont.myFont,
                      fontWeight: FontWeight.w900,
                      fontSize: 19,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: InkWell(
                      onTap: () {},
                      child: Card(
                        elevation: 0,
                        color: MyColors.mainTheme,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 0),
                          child: Row(
                            children: [
                              Text(
                                "See All  ",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: MyFont.myFont,
                                  fontWeight: FontWeight.bold,
                                  color: MyColors.white,
                                  fontSize: 10,
                                ),
                              ),
                              const Icon(
                                Icons.arrow_right_alt_rounded,
                                color: MyColors.white,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: height(context) / 50),
            subGridView()
          ],
        ),
      ),
    );
  }

  List<SubGrid> subGrid = [
    SubGrid(name: 'Sweet \nCarvings', image: Assets.onion, offer: " ${16.76}"),
    SubGrid(
        name: 'FrozenFood\n& IceCream',
        image: Assets.onion,
        offer: " ${16.76}"),
    SubGrid(name: 'Dairy,Bread\nEggs', image: Assets.onion, offer: " ${16.76}"),
    SubGrid(
        name: 'Cold Drinks\nJuices', image: Assets.onion, offer: " ${16.76}"),
    SubGrid(name: 'Munchies', image: Assets.onion, offer: " ${16.76}"),
    SubGrid(name: 'Meat,Fish\nFood', image: Assets.onion, offer: " ${16.76}"),
  ];
  yourFavouritePicksList() {
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

  subGridView() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GridView.builder(
          padding: EdgeInsets.all(0),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: subGrid.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.9,
          ),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {},
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      Assets.frame9,
                      fit: BoxFit.fill,
                      width: double.maxFinite,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    child: Column(
                      children: [
                        Container(
                          height: height(context) / 25,
                          alignment: Alignment.center,
                          child: Text(
                            subGrid[index].name,
                            style: TextStyle(
                              fontFamily: MyFont.myFont,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                              color: MyColors.black,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height(context) / 50,
                        ),
                        SizedBox(
                            height: height(context) / 10,
                            child: Image.asset(
                              alignment: Alignment.center,
                              subGrid[index].image,
                              scale: 1.3,
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
