import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_event_registration/view/pages/onboard/onborading_page.dart';

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
    super.initState();
    startTime();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 2),)..repeat();
  }

  startTime() async {
    ///todo duration
    var duration = const Duration(milliseconds: 1850);
    return Timer(duration, route);
  }
  route() {
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => const OnboardingPage()
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
