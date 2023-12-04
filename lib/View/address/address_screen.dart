
import 'package:Catchyfive/Const/approutes.dart';
import 'package:Catchyfive/Const/colors.dart';
import 'package:Catchyfive/Const/font.dart';
import 'package:Catchyfive/Const/size.dart';
import 'package:Catchyfive/View/address/address_controller.dart';


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Const/assets.dart';
import 'GetAddressController.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({Key? key}) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  late GetAddressController locationFetchController;

  @override
  void initState() {
    super.initState();
    locationFetchController = Get.put(GetAddressController());
    locationFetchController.getAddress();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GetAddressController>(builder: (logic) {
      if (logic.isLoading.value == true) {
        return Container(
          color: MyColors.white,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
      return Scaffold(
        backgroundColor: MyColors.white,
        appBar: AppBar(
          backgroundColor: MyColors.mainTheme,
          elevation: 0,
          iconTheme: const IconThemeData(color: MyColors.white),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              // Get.back();
               Get.offAndToNamed(AppRoutes.bottomNavBar3);
            },
          ),
          title: Text(
            'Delivery Address',
            style: TextStyle(
              fontFamily: MyFont.myFont,
              fontWeight: FontWeight.bold,
              color: MyColors.white,
            ),
          ),
        ),
        body: SingleChildScrollView(
            child: addressList() ),
        bottomNavigationBar: Container(
          height: 60,
          margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
          child: GestureDetector(
            onTap: () {
              Get.toNamed(AppRoutes.enterAddressDetailsScreen,arguments: false);
            },
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: MyColors.mainTheme,
                // border: Border.all(color: MyColors.mainTheme, width: 2),
              ),
              child: Center(
                  child: Text(
                'Add New Address',
                style: TextStyle(
                  fontFamily: MyFont.myFont,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: MyColors.white,
                ),
              )),
            ),
          ),
        ),
      );
    });
  }

  addressList() {
    return  (locationFetchController.addressList.value != null &&locationFetchController.addressList.value?.length !=  0) ? ListView.builder(
      itemCount: locationFetchController.addressList.value?.length,
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        String? address =
            "${locationFetchController.addressList.value?[index].addressLine1},${locationFetchController.addressList.value?[index].addressLine2},${locationFetchController.addressList.value?[index].addressLine3}";
        return Container(
          padding: const EdgeInsets.fromLTRB(15, 10, 15, 18),
          margin: const EdgeInsets.fromLTRB(15, 15, 15, 18),
          decoration: const BoxDecoration(
            color: MyColors.lightGreen2,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Image.asset(Assets.locationIcon),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      locationFetchController.addressList.value?[index].phone ??
                          "",
                      // 'Home',
                      style: TextStyle(
                        fontFamily: MyFont.myFont,
                        fontWeight: FontWeight.w900,
                        fontSize: 15,
                        color: MyColors.black,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    width: width(context) / 1.6,
                    child: Text(
                      address,
                      // 'Home 1/44, Kuppam road, Valimiki Nagar, Raja Garden,Kottivakkam, Chennai, Tamil nadu- 600041',
                      style: TextStyle(
                        fontFamily: MyFont.myFont,
                        fontWeight: FontWeight.w500,
                        fontSize: 10,
                        color: MyColors.black,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(5),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child:  GestureDetector(
                        onTap:(){
                          Get.toNamed(AppRoutes.enterAddressDetailsScreen,
                            arguments: {
                              'address1': locationFetchController.addressList.value?[index].addressLine1.toString(),
                              'address2': locationFetchController.addressList.value?[index].addressLine2.toString(),
                              'address3': locationFetchController.addressList.value?[index].addressLine1.toString(),
                              'postalCode': locationFetchController.addressList.value?[index].postalCode.toString(),
                              // Add other fields as needed
                            },);
                        },
                        child:Image.asset(Assets.editIcon),)
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: GestureDetector(
                        onTap: () {
                       locationFetchController.RemoveDeliveryAddress(locationFetchController.addressList.value![index].customerId, locationFetchController.addressList.value?[index].deliveryId, locationFetchController.addressList.value?[index].name);
                        },
                          child: Image.asset(Assets.delete)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    ): Center(child: Text("Add your Delivery Address"),);
  }
}
