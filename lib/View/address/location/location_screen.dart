import 'dart:async';

import 'package:Catchyfive/Const/approutes.dart';
import 'package:Catchyfive/Const/assets.dart';
import 'package:Catchyfive/Const/colors.dart';
import 'package:Catchyfive/Const/font.dart';
import 'package:Catchyfive/Const/size.dart';
import 'package:Catchyfive/Helper/constant.dart';
import 'package:Catchyfive/View/address/address_controller.dart';
import 'package:Catchyfive/Widget/CustomTextField.dart';
import 'package:Catchyfive/Widget/searchTextField.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late LocationFetchController addressController;

  @override
  void initState() {
    super.initState();
    addressController = Get.put(LocationFetchController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        backgroundColor: MyColors.mainTheme,
        elevation: 0,
        iconTheme: const IconThemeData(color: MyColors.white),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          'Your Location',
          style: TextStyle(
            fontFamily: MyFont.myFont,
            fontWeight: FontWeight.bold,
            color: MyColors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Get.toNamed(AppRoutes.cartEmptyScreen);
            },
            icon:
                const Icon(Icons.shopping_cart_outlined, color: MyColors.white),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: CustomTextField(
                inputBorder: const OutlineInputBorder(),
                controller: addressController.address1,
                keyboardType: TextInputType.text,
                hintText: 'Search a new address',
                readOnly: false,
                fillColor: MyColors.lightGreen2,
                prefixIcon: Image.asset(
                  Assets.searchIcon,
                  scale: 0.9,
                  color: MyColors.black,
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                await _fetchCurrentLocation(context);
                // Get.toNamed(AppRoutes.locationInformationScreen);
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(10),
                      child:
                          Icon(Icons.my_location_rounded, color: MyColors.red),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Current location ',
                          style: TextStyle(
                            fontFamily: MyFont.myFont,
                            fontWeight: FontWeight.w800,
                            fontSize: 15,
                            color: MyColors.red,
                          ),
                        ),
                        SizedBox(
                          height: height(context) / 150,
                        ),
                        Text(
                          'Using GPS',
                          style: TextStyle(
                            fontFamily: MyFont.myFont,
                            fontWeight: FontWeight.normal,
                            fontSize: 13,
                            color: MyColors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
              child: Text(
                'Saved location',
                style: TextStyle(
                  fontFamily: MyFont.myFont,
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                  color: MyColors.mainTheme,
                ),
              ),
            ),
            addressList(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 60,
        margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
        child: GestureDetector(
          onTap: () {
            Get.toNamed(AppRoutes.enterAddressDetailsScreen);
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
              'Add address to proceed',
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
  }

  addressList() {
    return ListView.builder(
      itemCount: 4,
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.fromLTRB(15, 10, 15, 18),
          margin: const EdgeInsets.fromLTRB(15, 10, 15, 18),
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
                      'Home',
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
                      'Home 1/44, Kuppam road, Valimiki Nagar, Raja Garden,Kottivakkam, Chennai, Tamil nadu- 600041',
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
                      child: Image.asset(Assets.editIcon),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Image.asset(Assets.delete),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _fetchCurrentLocation(context) async {
    PermissionStatus status = await Permission.location.request();

    if (status.isGranted) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PlacePicker(
            apiKey: Constant.googleApiKey,
            onPlacePicked: (result) {
              addressController.address1.text =
                  result.formattedAddress ?? '';
              // _businessRegModel.latitude = result.geometry?.location.lat;
              // _businessRegModel.longitude = result.geometry?.location.lng;
              Navigator.of(context).pop();
            },
            useCurrentLocation: true,
            initialPosition: LatLng(position.latitude, position.longitude),
            selectInitialPosition: true,
            resizeToAvoidBottomInset: false,
          ),
        ),
      );
    } else {
      openAppSettings();
    }
  }
}
