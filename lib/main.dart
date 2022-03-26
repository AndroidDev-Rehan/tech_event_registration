import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:tech_event_registration/view/pages/root/event_detail_screen.dart';
import 'package:tech_event_registration/view/pages/root/sponsor_home.dart';
import 'package:tech_event_registration/view/pages/splash/splash_page.dart';

import 'controllers/bindings/binding.dart';
import 'utils/authWrapper.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Stripe.publishableKey ='pk_test_51KhdLXDJF8BD6oeLeyzCDhYpLjXPpLlNzAEsDN2R92hoZjxBoz15q07DnpbiB6t04HyhT4DMtZcv06c2ja0chsyi00rC7e7Dp1';
   Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';
  Stripe.urlScheme = 'flutterstripe';
  await Stripe.instance.applySettings().then((value) => print('configer'));
      runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      title: "Care-Corner",
      theme: ThemeData(
        primarySwatch: Colors.purple
      ),
      initialBinding: AuthBinding(),
      debugShowCheckedModeBanner: false,
      // home: EventDetailScreen(),
      home: AuthWrapper(),
    );
  }
}
