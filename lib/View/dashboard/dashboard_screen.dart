import 'package:Catchyfive/Const/approutes.dart';
import 'package:Catchyfive/Const/assets.dart';
import 'package:Catchyfive/Const/colors.dart';
import 'package:Catchyfive/Const/font.dart';
import 'package:Catchyfive/Const/size.dart';
import 'package:Catchyfive/Helper/preferencehelper.dart';
import 'package:Catchyfive/Model/login/login_model.dart';
import 'package:Catchyfive/View/dashboard/dashboard_controller.dart';
import 'package:Catchyfive/View/sub_categories/subcategory_controller.dart';
import 'package:Catchyfive/Widget/searchTextField.dart';
import 'package:Catchyfive/constructors/constructors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Model/catagroy/ProductModel.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  List<String> offerImage = [
    Assets.offerImage,
  ];

  late DashBoardController dashBoardController;
  late SubCategoryController controller;
  String? customerName;
  String? customerId;
  B2cLoginModel? b2cLoginModel;
  late final List<ProductModel> localData;
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
  }

  initData() async {
    b2cLoginModel = await PreferenceHelper.getUserData();
    // dashBoardController.onInit();
    customerName = b2cLoginModel?.b2CCustomerName;
    customerId = b2cLoginModel?.b2CCustomerId;
    localData = await PreferenceHelper.getCartData();
    if (localData != null) {
      for (int i = 0; i < localData.length; i++) {
        savedProduct.add(localData[i].productCode!);
      }
      controller.cartAddedProduct.clear();
      controller.cartAddedProduct.addAll(localData);
    }

  }

  Future<void> _refreshData() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      dashBoardController.productList.value.length = 0;
      dashBoardController = Get.put(DashBoardController())
        ..getCurrentDateTime()..GetFavProduct();
      controller = Get.put(SubCategoryController());
      initData();
      dashBoardController.updateProductCount();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashBoardController>(builder: (state) {
      if (state.isLoadings.value == true) {
        return Container(
          color: MyColors.white,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
      return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: RefreshIndicator(
          onRefresh: _refreshData,
          child: Scaffold(
            backgroundColor: MyColors.white,
            body: CustomScrollView(
              controller: dashBoardController.customScrollViewController,
              slivers: <Widget>[
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  expandedHeight: 130,
                  toolbarHeight: 70,
                  floating: true,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    expandedTitleScale: 1,
                    titlePadding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    title: Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: SearchTextField(
                            readOnly: false,
                            inputBorder: InputBorder.none,
                            controller: dashBoardController.searchController,
                            keyboardType: TextInputType.none,
                            onTap: () {
                              Get.toNamed(AppRoutes.SearchController);
                            },
                            hintText: "Search for over all products",
                            prefixIcon: const Icon(Icons.search,size:25),
                            // prefixIcon: Image.asset(
                            //   Assets.searchIcon,
                            //   scale: 0.9,
                            //   color: MyColors.black,
                            // ),
                            fillColor: MyColors.white,
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 10, left: 5),
                              child: buildAppBarCartButton(),
                            ))
                      ],
                    ),
                    background: Container(
                      color: MyColors.mainTheme,
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        margin: const EdgeInsets.only(top: 20),
                        child: Column(
                          children: [
                            Image.asset(
                              Assets.logo, scale: 15,
                              // height: height(context) / 9,
                              // width: width(context) / 5,
                            ),
                          ],
                        ),
                      ), // Flexible(
                      //   child: GestureDetector(
                      //     onTap: () {
                      //       setState(() {
                      //         locationPermission();
                      //       });
                      //     },
                      //     child: Row(
                      //       children: [
                      //         Padding(
                      //           padding: const EdgeInsets.all(3),
                      //           child: Container(
                      //             child: Row(
                      //               children: [
                      //                 Padding(
                      //                   padding: const EdgeInsets.only(
                      //                     left: 15,
                      //                   ),
                      //                   child: Text(
                      //                     dashBoardController.placeName,
                      //                     overflow: TextOverflow.ellipsis,
                      //                     style: TextStyle(
                      //                         fontFamily: MyFont.myFont,
                      //                         fontWeight: FontWeight.normal,
                      //                         fontSize: 15,
                      //                         color: MyColors.white),
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //           ),
                      //         ),
                      //          Icon(Icons.pin_drop,
                      //             color: MyColors.white)
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // buildAppBarCartButton(),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: 1,
                    (BuildContext context, int index) {
                      return SingleChildScrollView(
                        physics: const ScrollPhysics(),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: MyColors.white,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(40.0),
                              topLeft: Radius.circular(40.0),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // offerImageListView(),
                              (dashBoardController.bannerImageList.isNotEmpty)
                                  ? Column(children: [
                                      const SizedBox(height: 15),
                                      buildBannerWidget(context),
                                      const SizedBox(height: 15),
                                    ])
                                  : Container(),
                              (dashBoardController.productList.isNotEmpty)
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: Text(
                                            'Your Favourite Picks',
                                            style: TextStyle(
                                              fontFamily: MyFont.myFont,
                                              fontWeight: FontWeight.w900,
                                              fontSize: 19,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        Container(
                                          height: 280,
                                          child: Obx(() {
                                            return yourFavouritePicksList();
                                          }),
                                        ),
                                      ],
                                    )
                                  : Container(),
                              const SizedBox(height: 15),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Text(
                                  'Explore By Categories',
                                  style: TextStyle(
                                    fontFamily: MyFont.myFont,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 19,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15),
                              // categoryHeadGrid(),
                              categorySubGrid(),
                              const SizedBox(height: 15),

                              // Padding(
                              //   padding: const EdgeInsets.all(10),
                              //   child: SizedBox(
                              //       child: Image.asset(
                              //     Assets.thisWeekendOffer,
                              //   )),
                              // ),
                              // const SizedBox(height: 15),
                              // gridview(),
                              // buildBannerWidget(context),
                              // const SizedBox(height: 15),
                              // Padding(
                              //   padding: const EdgeInsets.symmetric(horizontal: 15),
                              //   child: Text(
                              //     'Explore New Launch Products',
                              //     style: TextStyle(
                              //       fontFamily: MyFont.myFont,
                              //       fontWeight: FontWeight.w900,
                              //       fontSize: 19,
                              //     ),
                              //   ),
                              // ),
                              // const SizedBox(height: 15),
                              // exploreNewLaunchProducts(),
                              // const SizedBox(height: 15),
                              // Padding(
                              //   padding: const EdgeInsets.symmetric(horizontal: 15),
                              //   child: Text(
                              //     'Explore New Categories',
                              //     style: TextStyle(
                              //       fontFamily: MyFont.myFont,
                              //       fontWeight: FontWeight.w900,
                              //       fontSize: 19,
                              //     ),
                              //   ),
                              // ),
                              // const SizedBox(height: 15),
                              // exploreNewCategoriesList(),
                              // const SizedBox(height: 20),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: [
                              //     InkWell(
                              //       onTap: () {
                              //         Get.toNamed(AppRoutes.SuggestProductScreen);
                              //       },
                              //       child: Container(
                              //         alignment: Alignment.center,
                              //         padding: const EdgeInsets.symmetric(
                              //             horizontal: 15, vertical: 15),
                              //         decoration: BoxDecoration(
                              //           color: MyColors.mainTheme,
                              //           borderRadius: BorderRadius.circular(20),
                              //         ),
                              //         child: Center(
                              //             child: Text(
                              //           'Suggested Products',
                              //           style: TextStyle(
                              //             fontFamily: MyFont.myFont,
                              //             fontWeight: FontWeight.w600,
                              //             fontSize: 15,
                              //             color: MyColors.white,
                              //           ),
                              //         )),
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              // const SizedBox(height: 30),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  ///NewLaunchList
  List<NewLaunchList> newLaunchList = [
    NewLaunchList(
        image: Assets.logo,
        name: 'Fresh Vegtables Fresh Vegtables Fresh Vegtables',
        weight: '1 KG',
        rupees: '\$ 50'),
    NewLaunchList(
        image: Assets.logo,
        name: 'Fresh Vegtables Fresh Vegtables Fresh Vegtables',
        weight: '1 KG',
        rupees: '\$ 50'),
    NewLaunchList(
        image: Assets.logo,
        name: 'Fresh Vegtables Fresh Vegtables Fresh Vegtables',
        weight: '1 KG',
        rupees: '\$ 50'),
    NewLaunchList(
        image: Assets.logo,
        name: 'Fresh Vegtables Fresh Vegtables Fresh Vegtables',
        weight: '1 KG',
        rupees: '\$ 50'),
    NewLaunchList(
        image: Assets.logo,
        name: 'Fresh Vegtables Fresh Vegtables Fresh Vegtables',
        weight: '1 KG',
        rupees: '\$ 50'),
  ];

  /// Sliding Images
  List<Banners> banners = [
    Banners(
      name: 'Order Now',
      image: Assets.frame1,
      offer: "upto 30 % Off",
    ),
    Banners(
      name: 'Order Now',
      image: Assets.frame1,
      offer: "upto 30 % Off",
    ),
    Banners(
      name: 'Order Now',
      image: Assets.frame1,
      offer: "upto 30 % Off",
    ),
  ];

  ///OfferListViewBuilder
  List<OfferList> offerList = [
    OfferList(
      image: Assets.welcome,
      mainLine: 'Get Instant Discount for \n Biscuits & Cookies',
      subLine: 'Discover Now >>',
    ),
    OfferList(
      image: Assets.logo,
      mainLine: 'Get Instant Discount for \n meats',
      subLine: 'Discover Now >>',
    ),
    OfferList(
      image: Assets.logo,
      mainLine: 'Get Instant Discount for \n Fruits & Vegetables',
      subLine: 'Discover Now >>',
    )
  ];

  ///CategorySubGridViewList
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
    SubCategoryGrid(name: 'Stationary', image: Assets.onion),
    SubCategoryGrid(name: 'Stationary', image: Assets.onion),
    SubCategoryGrid(name: 'Stationary', image: Assets.onion),
    SubCategoryGrid(name: 'Stationary', image: Assets.onion),
  ];

  List<CategoryHeadGrid> exploreGrid = [
    CategoryHeadGrid(name: 'Season Fruits', image: Assets.onion),
    CategoryHeadGrid(name: 'Season  ', image: Assets.onion),
  ];

  List<Grid> grid = [
    Grid(name: 'Sweet \nCarvings', image: Assets.onion),
    Grid(name: 'FrozenFood\n& IceCream', image: Assets.onion),
    Grid(name: 'Dairy,Bread\nEggs', image: Assets.onion),
    Grid(name: 'Cold Drinks\nJuices', image: Assets.onion),
    Grid(name: 'Munchies', image: Assets.onion),
    Grid(name: 'Meat,Fish\nFood', image: Assets.onion),
  ];
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
  List<Grid> exploreNewCategories = [
    Grid(name: 'Sweet \nCarvings', image: Assets.onion),
    Grid(name: 'FrozenFood\n& IceCream', image: Assets.onion),
    Grid(name: 'Dairy,Bread\nEggs', image: Assets.onion),
    Grid(name: 'Cold Drinks\nJuices', image: Assets.onion),
    Grid(name: 'Munchies', image: Assets.onion),
    Grid(name: 'Meat,Fish\nFood', image: Assets.onion),
  ];

  offerImageListView() {
    return SizedBox(
      height: height(context) / 12,
      width: double.infinity,
      child: CarouselSlider.builder(
        itemCount: offerImage.length,
        itemBuilder: (context, itemIndex, realIndex) {
          return Image.asset(
            offerImage[itemIndex],
            fit: BoxFit.fitWidth,
            width: double.maxFinite,
          );
        },
        carouselController: dashBoardController.carouselController,
        options: CarouselOptions(
          aspectRatio: 1,
          viewportFraction: 1,
          onPageChanged: (index, reason) {
            setState(() {
              dashBoardController.currentIndex = index;
            });
          },
        ),
      ),
    );
  }

  buildBannerWidget(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: height(context) / 80),
        SizedBox(
          height: height(context) / 6,
          width: double.infinity,
          child: CarouselSlider.builder(
            itemCount: dashBoardController.bannerImageList.length,
            itemBuilder: (context, index, realIndex) {
              return (dashBoardController
                          .bannerImageList[index].bannerImageFilePath ==
                      null)
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: SizedBox(
                          width: double.infinity,
                          child: Image.network(
                            dashBoardController
                                .bannerImageList[index].bannerImageFilePath!
                                .toString(),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
            },
            carouselController: dashBoardController.carouselController,
            options: CarouselOptions(
              autoPlay: true,
              viewportFraction: 0.85,
              onPageChanged: (index, reason) {
                setState(() {
                  dashBoardController.currentIndex = index;
                });
              },
              height: 150,
              enlargeCenterPage: false,
              aspectRatio: 1,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
            ),
          ),
        ),
        SizedBox(height: height(context) / 50),
      ],
    );
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
                        Assets.frame2,
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
    return Container(
      padding: const EdgeInsets.all(10),
      child: GridView.builder(
          padding: const EdgeInsets.all(0),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: dashBoardController.categoryList.value?.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.8,
          ),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Get.toNamed(AppRoutes.subCategoriesScreen,
                    arguments:
                        dashBoardController.categoryList.value![index]);
              },
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      Assets.frame3,
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
                            dashBoardController
                                    .categoryList.value?[index].name ??
                                " ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: MyFont.myFont,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: MyColors.black,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height(context) / 110,
                        ),
                        SizedBox(
                          child: (dashBoardController.categoryList.value?[index]
                                      .categoryImageFilePath !=
                                  null)
                              ? ("${dashBoardController.categoryList.value?[index].categoryImageFilePath}"
                                      .isNotEmpty)
                                  ? Image.network(
                                      height: height(context) / 18,
                                      alignment: Alignment.center,
                                      dashBoardController
                                              .categoryList
                                              .value?[index]
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
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }

  yourFavouritePicksList() {
    return ListView.builder(
      physics: const ScrollPhysics(),
      itemCount: dashBoardController.productList.length,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(left: 5, right: 5),
          child: SizedBox(
            width: width(context) / 2.8,
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
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: GestureDetector(
                            onTap: () {
                              // dashBoardController.productList.value[index]
                              //     .isfavourite =
                              // !dashBoardController
                              //     .productList.value[index].isfavourite;
                              // if (dashBoardController.productList.value[index]
                              //     .isfavourite ==
                              //     true) {
                              dashBoardController.UnFavProduct(
                                  productModel: dashBoardController
                                      .productList.value[index]);
                              _refreshData();
                              // } else {
                              //   dashBoardController.changeFavProduct(
                              //       productModel: dashBoardController
                              //           .productList.value[index]);
                              // }
                            },
                            child: const Icon(
                              // (dashBoardController.productList.value[index].isfavourite)
                              //     ? Icons.favorite_outline_rounded :
                              Icons.favorite_outlined,
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
                              arguments:
                                  dashBoardController.productList.value[index]);
                        },
                        child: SizedBox(
                          child: (dashBoardController
                                  .productList[index].productImagePath!
                                  .startsWith("/Content/images/"))
                              ? Image.asset(
                                  Assets.noImage,
                                  height: height(context) / 9,
                                  width: width(context) / 5,
                                )
                              : (dashBoardController.productList[index]
                                          .productImagePath !=
                                      null)
                                  ? ("${dashBoardController.productList[index].productImagePath}"
                                          .isNotEmpty)
                                      ? Image.network(
                                          '${dashBoardController.productList[index].productImagePath}',
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
                        "${dashBoardController.productList[index].productName}",
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
                                "${dashBoardController.productList[index].sellingCost}",
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
                          child: (dashBoardController
                                      .productList[index].qtycount ==
                                  0)
                              ? GestureDetector(
                                  onTap: () async {
                                    ProductModel? selectedProduct =
                                        dashBoardController
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
                                      savedProduct
                                          .remove(selectedProduct.productCode);
                                    }
                                    setState(() {
                                      controller.cartService
                                          .addToCart(product: selectedProduct);
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
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(6)),
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6)),
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
                                                dashBoardController
                                                    .productList[index];

                                            setState(() {
                                              controller.cartService
                                                  .removeFromCart(
                                                      product: selectedProduct);
                                              controller.updateProductCount();
                                            });

                                            if (selectedProduct.qtycount == 0) {
                                              if (controller.cartAddedProduct
                                                  .any((element) =>
                                                      element.productCode ==
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
                                                if (controller
                                                    .cartAddedProduct.isEmpty) {
                                                  controller.cartAddedProduct
                                                      .clear();
                                                }
                                              }
                                            }
                                            // bottomAppBar(index);
                                            // if (controller.productList[index].qtycount == 0) {
                                            //   controller.cartAddedProduct.length = 0;
                                            // }
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
                                        // Obx(() {
                                        //   return
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
                                              width: 20,
                                              child: Text(
                                                '${dashBoardController.productList[index].qtycount.toInt()}',
                                                key: ValueKey<int>(
                                                  dashBoardController
                                                          .productList[index]
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
                                            ProductModel?
                                            selectedProduct =
                                            dashBoardController
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
          ),
        );
      },
    );
  }

  gridview() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GridView.builder(
          padding: const EdgeInsets.all(0),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: grid.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.8,
          ),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {},
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      Assets.frame4,
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
                          height: height(context) / 26,
                          alignment: Alignment.center,
                          child: Text(
                            grid[index].name,
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
                            child: Image.asset(
                          height: height(context) / 12,
                          alignment: Alignment.center,
                          grid[index].image,
                        ))
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }

  subBannersListView() {
    return Container(
      padding: const EdgeInsets.only(
        top: 18,
      ),
      child: CarouselSlider.builder(
        itemCount: banners.length,
        itemBuilder: (context, itemIndex, realIndex) {
          return Stack(children: [
            Container(
              height: 200,
              width: 300,
              margin: const EdgeInsets.only(
                  left: 12, top: 12, bottom: 12, right: 12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(
                        banners[itemIndex].image,
                      ))),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Image.asset(
                  Assets.onion,
                  scale: 2,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  left: 15.25, top: 12, bottom: 12, right: 12),
              decoration: const BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10))),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Text(
                "Upto 30% Off",
                style: TextStyle(
                  fontFamily: MyFont.myFont,
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                  color: MyColors.black,
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: width(context) / 4.3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Card(
                      color: MyColors.primaryCustom,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Text(
                          banners[itemIndex].name,
                          style: TextStyle(
                            fontFamily: MyFont.myFont,
                            fontWeight: FontWeight.bold,
                            color: MyColors.white,
                            fontSize: 9,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]);

          Stack(alignment: Alignment.center, children: [
            Container(
              padding: const EdgeInsets.all(20),
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: AssetImage(
                    banners[itemIndex].image,
                  ))),
              child: Image.asset(
                Assets.onion,
                width: double.maxFinite,
              ),
            ),
            SizedBox(
              height: 130,
              width: 270,

              // color: MyColors.lightGreen2,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: Card(
                      color: MyColors.primaryCustom,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Text(
                          banners[itemIndex].offer,
                          style: TextStyle(
                            fontFamily: MyFont.myFont,
                            fontWeight: FontWeight.bold,
                            color: MyColors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(
                  //     height: height(context) / 12.5,
                  //     width: width(context) / 5,
                  //     child: Image.asset(
                  //       alignment: Alignment.center,
                  //       Assets.onion,
                  //       scale: 3,
                  //     )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Card(
                          color: MyColors.primaryCustom,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Text(
                              banners[itemIndex].name,
                              style: TextStyle(
                                fontFamily: MyFont.myFont,
                                fontWeight: FontWeight.bold,
                                color: MyColors.white,
                                fontSize: 9,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ]);
        },
        carouselController: dashBoardController.carouselController,
        options: CarouselOptions(
          // autoPlay: true,
          viewportFraction: 0.715,
          onPageChanged: (index, reason) {
            setState(() {
              dashBoardController.currentIndex = index;
            });
          },
          height: 150,
          enlargeCenterPage: false,
          aspectRatio: 1,
          autoPlayCurve: Curves.fastOutSlowIn,
          enableInfiniteScroll: true,
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
        ),
      ),
    );
  }

  exploreNewLaunchProducts() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GridView.builder(
          padding: const EdgeInsets.all(0),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: subGrid.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.8,
          ),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {},
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      Assets.frame6,
                      fit: BoxFit.fill,
                      height: height(context) / 0.5,
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
                          height: height(context) / 80,
                        ),
                        SizedBox(
                            child: Image.asset(
                          height: height(context) / 12,
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

  exploreNewCategoriesList() {
    return SizedBox(
      height: 160,
      child: ListView.builder(
        itemCount: exploreNewCategories.length,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.only(top: 15, left: 8),
              alignment: Alignment.center,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 140,
                    width: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        Assets.frame4,
                        fit: BoxFit.fill,
                        width: double.maxFinite,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: height(context) / 26,
                          alignment: Alignment.center,
                          child: Text(
                            exploreNewCategories[index].name,
                            style: TextStyle(
                              fontFamily: MyFont.myFont,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                              color: MyColors.black,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height(context) / 110,
                        ),
                        SizedBox(
                            height: height(context) / 13,
                            child: Image.asset(
                              alignment: Alignment.center,
                              exploreNewCategories[index].image,
                              scale: 1.6,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
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
          padding: const EdgeInsets.only(
            right: 11.0,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 11.0, top: 10),
                child: Icon(
                  Icons.shopping_cart_outlined,
                  color: MyColors.white,
                ),
              ),
              if (controller.cartAddedProduct.isNotEmpty)
                Positioned(
                  top: 0,
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
