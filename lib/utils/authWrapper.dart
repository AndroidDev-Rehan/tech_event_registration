import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_event_registration/view/pages/onboard/onborading_page.dart';
import '../controllers/auth_controller.dart';
import '../controllers/user_controller.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<UserController>(
      builder: (UserController controller) {
        User? user = Get.find<AuthController>().user;
        if(user == null){
          return Scaffold(body:OnboardingPage(),);
        }else{
         // controller.getCurrentUser(user.uid);
          ///   return RootPage();
          return Scaffold(body: Center(child: Text('check')),);
        }
      },
    );
  }
}



