import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tech_event_registration/models/user.dart';
import 'package:tech_event_registration/view/pages/auth/get_user_info_screen.dart';
import 'package:tech_event_registration/view/pages/auth/login_page.dart';
import 'package:tech_event_registration/view/pages/home/home.dart';
import 'package:tech_event_registration/view/pages/root/sponsor_home.dart';
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

        if (user == null) {
          log("user is null from traditional sign in method");
          user = FirebaseAuth.instance.currentUser;
        }

        if (controller.firstTimeLogin) {
          print('----------------------------------');

          return GetUserInfoScreen();
        }

        if (user == null) {
          log("user is still not login");

          return LoginPage();
//          return OnboardingPage();
          // return Scaffold(body:SplashScreen(),);
        } else {
          AuthController controller = Get.find();

          controller.getUser(FirebaseAuth.instance.currentUser!.uid);
          return FutureBuilder(
            future: controller.getUser(FirebaseAuth.instance.currentUser!.uid),
            builder: (context, AsyncSnapshot<UserModel> snapshot) {
              controller.userModel = snapshot.data;
              if (snapshot.hasData) {
                if (controller.userModel!.category == 'Sponsor')
                  return SponsorHomeScreen();
                else
                  return HomePage();
              }
              return Scaffold(body: Center(child: CircularProgressIndicator(),),);
            },
          );

          // return Scaffold(
          //   body: Center(
          //       child: InkWell(
          //           child: const Text('LOG OUT'),
          //           onTap: () {
          //             controller.signOut();
          //           }
          //       )),
          // );
        }
      },
    );
  }
}
