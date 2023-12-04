import 'package:Catchyfive/View/Registration/registration_successfully_screen.dart';
import 'package:Catchyfive/View/Splash/welcomescreen.dart';
import 'package:Catchyfive/View/about_product/about_product_screen.dart';
import 'package:Catchyfive/View/address/address_screen.dart';
import 'package:Catchyfive/View/address/enter_address_details.dart';
import 'package:Catchyfive/View/address/location/location_information_screen.dart';
import 'package:Catchyfive/View/address/location/location_screen.dart';
import 'package:Catchyfive/View/cart/cart_screen.dart';
import 'package:Catchyfive/View/cart/conformation_screen.dart';
import 'package:Catchyfive/View/cart/empty_cart%20_screen.dart';
import 'package:Catchyfive/View/categories/categories_screen.dart';
import 'package:Catchyfive/View/favourite/favourite_screen.dart';
import 'package:Catchyfive/View/forget_password/forget_password_screen.dart';
import 'package:Catchyfive/View/notification/notofication_screen.dart';
import 'package:Catchyfive/View/order_list/order_details/order_details_screen.dart';
import 'package:Catchyfive/View/order_list/order_empty_screen.dart';
import 'package:Catchyfive/View/order_list/order_list_screen.dart';
import 'package:Catchyfive/View/otp/otp_screen.dart';
import 'package:Catchyfive/View/payment/payment_screen.dart';
import 'package:Catchyfive/View/profile/edit_profile/edit_profile_screen.dart';
import 'package:Catchyfive/View/refunds/refunds_screen.dart';
import 'package:Catchyfive/View/reset_password/reset_password_screen.dart';
import 'package:Catchyfive/View/setting/customer_support/customer_support.dart';
import 'package:Catchyfive/View/setting/faqs/faqs_feedback_suggestions.dart';
import 'package:Catchyfive/View/setting/faqs/faqs_general_inquiry.dart';
import 'package:Catchyfive/View/setting/faqs/faqs_order.dart';
import 'package:Catchyfive/View/setting/faqs/faqs_order_and_product_related.dart';
import 'package:Catchyfive/View/setting/faqs/faqs_payment_related.dart';
import 'package:Catchyfive/View/setting/faqs/faqs_scheduled_delivery_related.dart';
import 'package:Catchyfive/View/sub_categories/sub_categories_screen.dart';
import 'package:Catchyfive/View/suggest_product/suggest_product_screen.dart';
import 'package:Catchyfive/Widget/bottomnavbar.dart';
import 'package:get/get.dart';

import '../View/Login/loginscreen.dart';
import '../View/Registration/registrationscreen.dart';
import '../View/SearchProduct/searchProductScreen.dart';
import '../View/Splash/splashscreen.dart';
import '../View/dashboard/dashboard_screen.dart';
import '../View/forrgotPasswordScreen/FrogotPasswordScreen.dart';

class AppRoutes {
  static const String splash = "/Splash";
  static const String login = "/Login";
  static const String dashBoard = "/DashBoard";
  static const String registration = "/Registration";
  static const String subCategoriesScreen = "/SubCategoriesScreen";
  static const String categoriesScreen = "/CategoriesScreen";
  static const String aboutProductScreen = "/AboutProductScreen";
  static const String bottomNavBar = "/BottomNavBar";
  static const String cartScreen = "/CartScreen";
  static const String orderListScreen = "/OrderListScreen";
  static const String orderEmptyScreen = "/OrderEmptyScreen";
  static const String addressScreen = "/AddressScreen";
  static const String refundScreen = "/RefundScreen";
  static const String editProfileScreen = "/EditProfileScreen";
  static const String notificationScreen = "/NotificationScreen";
  static const String enterAddressDetailsScreen = "/EnterAddressDetailsScreen";
  static const String cartEmptyScreen = "/CartEmptyScreen";
  static const String locationScreen = "/LocationScreen";
  static const String confirmingOrderScreen = "/ConfirmingOrderScreen";
  static const String favouriteScreen = "/FavouriteScreen";
  static const String customerSupportScreen = "/CustomerSupportScreen";
  static const String orderDetailsListScreen = "/OrderDetailsListScreen";
  static const String paymentScreen = "/PaymentScreen";
  static const String locationInformationScreen = "/LocationInformationScreen";
  static const String FaqsOrderScreen = "/FaqsOrderScreen";
  static const String FaqsGeneralInquiryScreen = "/FaqsGeneralInquiryScreen";
  static const String FaqsFeedbackSuggestionsScreen =
      "/FaqsFeedbackSuggestionsScreen";
  static const String FaqsPaymentRelatedScreen = "/FaqsPaymentRelatedScreen";
  static const String FaqsScheduledDeliveryRelatedScreen =
      "/FaqsScheduledDeliveryRelatedScreen";
  static const String FaqsOrderAndProductRelatedScreen =
      "/FaqsOrderAndProductRelatedScreen";
  static const String ForgetPasswordScreen = "/ForgetPasswordScreen";
  static const String ResetPasswordScreen = "/ResetPasswordScreen";
  static const String forgotPAsswordScreen = "/ForgotPAsswordScreen";
  static const String OtpScreen = "/OtpScreen";
  static const String RegistrationSuccessfullyScreen = "/RegistrationSuccessfullyScreen";
  static const String SuggestProductScreen = "/SuggestProductScreen";
  static const String welcomeScreen = "/WelcomeScreen";
  static const String bottomNavBar1 = "/BottomNavBar1";
  static const String bottomNavBar2 = "/BottomNavBar2";
  static const String bottomNavBar3 = "/BottomNavBar3";
  static const String bottomNavBar0 = "/BottomNavBar0";
  static const String SearchController = "/SearchController";
  // static const String TestPaymentScreen = "/TestPaymentScreen";
}

final pages = [
  GetPage(name: AppRoutes.splash, page: () => const SplashScreen()),
  GetPage(name: AppRoutes.login, page: () => const LoginScreen()),
  GetPage(name: AppRoutes.dashBoard, page: () => const DashBoardScreen()),
  GetPage(name: AppRoutes.registration, page: () => const RegistrationScreen()),
  GetPage(
      name: AppRoutes.subCategoriesScreen,
      page: () => const SubCategoriesScreen()),
  GetPage(
      name: AppRoutes.categoriesScreen, page: () => const CategoriesScreen()),
  GetPage(
      name: AppRoutes.aboutProductScreen,
      page: () => const AboutProductScreen()),
  GetPage(name: AppRoutes.bottomNavBar, page: () => BottomNavBar()),
  GetPage(name: AppRoutes.cartScreen, page: () => const CartScreen()),
  GetPage(name: AppRoutes.orderListScreen, page: () => const OrderListScreen()),
  GetPage(
      name: AppRoutes.orderEmptyScreen, page: () => const OrderEmptyScreen()),
  GetPage(name: AppRoutes.addressScreen, page: () => const AddressScreen()),
  GetPage(name: AppRoutes.refundScreen, page: () => const RefundScreen()),
  GetPage(
      name: AppRoutes.editProfileScreen, page: () => const EditProfileScreen()),
  GetPage(
      name: AppRoutes.notificationScreen,
      page: () => const NotificationScreen()),
  GetPage(
      name: AppRoutes.enterAddressDetailsScreen,
      page: () => const EnterAddressDetailsScreen()),
  GetPage(name: AppRoutes.cartEmptyScreen, page: () => const CartEmptyScreen()),
  GetPage(name: AppRoutes.locationScreen, page: () => const LocationScreen()),
  GetPage(
      name: AppRoutes.confirmingOrderScreen,
      page: () => const ConfirmingOrderScreen()),
  GetPage(name: AppRoutes.favouriteScreen, page: () => const FavouriteScreen()),
  GetPage(
      name: AppRoutes.customerSupportScreen,
      page: () => const CustomerSupportScreen()),
  GetPage(
      name: AppRoutes.orderDetailsListScreen,
      page: () => const OrderDetailsListScreen()),
  GetPage(name: AppRoutes.paymentScreen, page: () => const PaymentScreen()),
  GetPage(
      name: AppRoutes.locationInformationScreen,
      page: () => const LocationInformationScreen()),
  GetPage(name: AppRoutes.FaqsOrderScreen, page: () => const FaqsOrderScreen()),
  GetPage(
      name: AppRoutes.FaqsGeneralInquiryScreen,
      page: () => const FaqsGeneralInquiryScreen()),
  GetPage(
      name: AppRoutes.FaqsFeedbackSuggestionsScreen,
      page: () => const FaqsFeedbackSuggestionsScreen()),
  GetPage(
      name: AppRoutes.FaqsPaymentRelatedScreen,
      page: () => const FaqsPaymentRelatedScreen()),
  GetPage(
      name: AppRoutes.FaqsScheduledDeliveryRelatedScreen,
      page: () => const FaqsScheduledDeliveryRelatedScreen()),
  GetPage(
      name: AppRoutes.FaqsOrderAndProductRelatedScreen,
      page: () => const FaqsOrderAndProductRelatedScreen()),
  GetPage(
      name: AppRoutes.ForgetPasswordScreen,
      page: () => const ForgetPasswordScreen()),
  GetPage(
      name: AppRoutes.ResetPasswordScreen,
      page: () => const ResetPasswordScreen()),
  GetPage(name: AppRoutes.OtpScreen, page: () => const OtpScreen()),
  GetPage(
      name: AppRoutes.RegistrationSuccessfullyScreen,
      page: () => const RegistrationSuccessfullyScreen()),
  GetPage(
      name: AppRoutes.SuggestProductScreen,
      page: () => const SuggestProductScreen()),
  GetPage(name: AppRoutes.welcomeScreen, page: () => const WelcomeScreen()),
  GetPage(
      name: AppRoutes.bottomNavBar0,
      page: () => BottomNavBar(
            intex: 0,
          )),
  GetPage(
      name: AppRoutes.bottomNavBar1,
      page: () => BottomNavBar(
            intex: 1,
          )),
  GetPage(
      name: AppRoutes.bottomNavBar2,
      page: () => BottomNavBar(
            intex: 2,
          )),
  GetPage(name: AppRoutes.bottomNavBar3, page: () => BottomNavBar(intex: 3)),
  GetPage(name: AppRoutes.SearchController, page: () => ProductSearchScreen()),
  GetPage(name: AppRoutes.forgotPAsswordScreen, page: () => ForgotPAsswordScreen()),
  // GetPage(name: AppRoutes.TestPaymentScreen, page: () => TestPaymentScreen()),
];
