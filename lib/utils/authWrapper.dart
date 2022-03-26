import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_event_registration/view/pages/auth/login_page.dart';
import 'package:tech_event_registration/view/pages/home/home.dart';
import 'package:tech_event_registration/view/pages/onboard/onborading_page.dart';
import 'package:tech_event_registration/view/pages/splash/splash_page.dart';
import '../controllers/auth_controller.dart';
import '../controllers/user_controller.dart';
import '../view/pages/payment.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<UserController>(
      builder: (UserController controller) {
        AuthController controller = Get.find();
        User? user = Get.find<AuthController>().user;
        if(user == null){
          return HomePage();
          // return Scaffold(body:SplashScreen(),);
        }else{
         // controller.getCurrentUser(user.uid);
          ///   return RootPage();
          return Scaffold(
            body: HomePage(),
            // body: Center(child: InkWell(
            //     child: const Text('check'),
            //   onTap: () async {
            //     Payment payment = Payment();
            //     await payment.makePayment();
            //   }
            //
            // )),

          );
        }
      },
    );
  }
}



