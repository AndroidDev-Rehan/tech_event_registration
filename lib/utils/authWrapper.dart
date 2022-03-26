import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tech_event_registration/view/pages/auth/get_user_info_screen.dart';
import 'package:tech_event_registration/view/pages/auth/login_page.dart';
import '../controllers/auth_controller.dart';
import '../controllers/user_controller.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<UserController>(
      builder: (UserController controller) {
        AuthController controller = Get.find();
        User? user = Get.find<AuthController>().user;

        if(user==null){
          log("user is null from traditional sign in method");
          user = FirebaseAuth.instance.currentUser;
        }

        if(controller.firstTimeLogin){
          print('----------------------------------');
          return GetUserInfoScreen();
        }

        if(user == null){
          log("user is still not login");
          return LoginPage();
//          return OnboardingPage();
          // return Scaffold(body:SplashScreen(),);
        }else{
         // controller.getCurrentUser(user.uid);
          ///   return RootPage();
          return Scaffold(
            body: Center(
                child: InkWell(
                    child: const Text('LOG OUT'),
                    onTap: () {
                  controller.signOut();
              }
            )),
          );
        }
      },
    );
  }
}





