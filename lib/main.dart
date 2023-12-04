import 'dart:convert';
import 'package:Catchyfive/Const/colors.dart';
import 'package:Catchyfive/locator/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'Const/approutes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupDependencies();
  Stripe.publishableKey = "pk_test_51N00U8FFReMpJzWzSL2lAHaCnQneRLTpZFtzIhnDdAyqNci4iSEJXrKCehecCCTrfWwBdgneBPXKh5KYSNtdgMUJ00k1doHzNY";
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: MyColors.primaryCustom),
      initialRoute: AppRoutes.splash,
      getPages: pages,
    );
  }
}


// class TestPaymentScreen extends StatefulWidget {
//   const TestPaymentScreen({Key? key}) : super(key: key);
//
//   @override
//   State<TestPaymentScreen> createState() => _TestPaymentScreenState();
// }
//
// class _TestPaymentScreenState extends State<TestPaymentScreen> {
//   Map<String,dynamic>? paymentIntent;
//   //
//   // Future<void> makePayment() async {
//   //   print("00001100101010");
//   //   try {
//   //     //STEP 1: Create Payment Intent
//   //     paymentIntent = await createPaymentIntent('100', 'USD');
//   //     print("0202002020202002");
//   //
//   //     // var gpay = const PaymentSheetGooglePay(merchantCountryCode: "US",currencyCode: "US",testEnv: true);
//   //
//   //     //STEP 2: Initialize Payment Sheet
//   //     await Stripe.instance.initPaymentSheet(
//   //         paymentSheetParameters: SetupPaymentSheetParameters(
//   //             paymentIntentClientSecret: paymentIntent!['client_secret'], //Gotten from payment intent
//   //             style: ThemeMode.light,
//   //             merchantDisplayName: 'santhosh',
//   //             // googlePay: gpay
//   //         ))
//   //         .then((value) {});
//   //
//   //     //STEP 3: Display Payment sheet
//   //     displayPaymentSheet();
//   //   } catch (err) {
//   //     throw Exception(err);
//   //   }
//   // }
//   //
//   // displayPaymentSheet() async {
//   //   print("33333333333333");
//   //   try {
//   //     await Stripe.instance.presentPaymentSheet().then((value) {
//   //       showDialog(
//   //           context: context,
//   //           builder: (_) => const AlertDialog(
//   //             content: Column(
//   //               mainAxisSize: MainAxisSize.min,
//   //               children: [
//   //                 Icon(
//   //                   Icons.check_circle,
//   //                   color: Colors.green,
//   //                   size: 100.0,
//   //                 ),
//   //                 SizedBox(height: 10.0),
//   //                 Text("Payment Successful!"),
//   //               ],
//   //             ),
//   //           ));
//   //
//   //       paymentIntent = null;
//   //     }).onError((error, stackTrace) {
//   //       print("444444444444444444");
//   //       throw Exception(error);
//   //     });
//   //   } on StripeException catch (e) {
//   //     print('Error is:---> $e');
//   //     print("5555555555555");
//   //     const AlertDialog(
//   //       content: Column(
//   //         mainAxisSize: MainAxisSize.min,
//   //         children: [
//   //           Row(
//   //             children: [
//   //               Icon(
//   //                 Icons.cancel,
//   //                 color: Colors.red,
//   //               ),
//   //               Text("Payment Failed"),
//   //             ],
//   //           ),
//   //         ],
//   //       ),
//   //     );
//   //   } catch (e) {
//   //     print("66666666666666666666");
//   //     print('$e');
//   //   }
//   // }
//   //
//   // createPaymentIntent(String amount, String currency) async {
//   //   print("2222222222222222222");
//   //   try {
//   //     //Request body
//   //     Map<String, dynamic> body = {
//   //       'amount': amount,
//   //       'currency': currency,
//   //     };
//   //     //Make post request to Stripe
//   //     var response = await http.post(
//   //       Uri.parse('https://api.stripe.com/v1/payment_intents'),
//   //       headers: {
//   //         'Authorization': 'Bearer ${Constant.STRIPE_SECRET}',
//   //         'Content-Type': 'application/x-www-form-urlencoded'
//   //       },
//   //       body: body,
//   //     );
//   //     print("111111111${response.body}1111111");
//   //     return json.decode(response.body);
//   //   } catch (err) {
//   //     print("1111111111111111");
//   //     throw Exception(err.toString());
//   //   }
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       appBar: AppBar(
//         title: Text("chekcing"),
//       ),
//         body: Center(
//           child: ElevatedButton(onPressed: () {
//             // makePayment();
//           },
//               child: const Text("pay")),
//         ),
//       );
//   }
// }
