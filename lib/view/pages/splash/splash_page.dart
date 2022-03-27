import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_event_registration/utils/authWrapper.dart';
import 'package:tech_event_registration/view/pages/onboard/onborading_page.dart';

import '../../../controllers/auth_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{
  late final AnimationController _controller;
  @override
  void initState() {
    // TODO: implement initState
//     AuthController controller = Get.find();
// if(controller.userModel==null)
//     controller.userModel=await controller.getUser(FirebaseAuth.instance.currentUser!.uid);
    super.initState();
    startTime();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 3),)..repeat();
  }

  startTime() async {
    ///todo duration
    var duration = const Duration(milliseconds: 3000);
    return Timer(duration, route);
  }
  route() {
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => const AuthWrapper()
    )
    );
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(

      builder: (context, snapshot) {
        return Scaffold(
          body: Container(
            width: Get.width,height: Get.height,
            child:  Center(
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (_, child) {
                    return Transform.rotate(
                      angle: _controller.value * 2 * 22/7,
                      child: child,
                    );
                  },
                  child: Image.asset("assets/images/logo.png"),
                ),)

            ),

        );
      }
    );
  }
}
