import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_event_registration/utils/const/colors.dart';
import 'package:tech_event_registration/utils/const/dimension.dart';
import 'package:tech_event_registration/view/pages/splash/splash_page.dart';

import '../../../utils/const/images.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: OrientationBuilder(
        builder: (context, snapshot) {
          return Scaffold(
            body: Container(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      Images.onboard_image,
                      height: Get.height / 1.9,
                      width: Get.width,
                      fit: BoxFit.cover,
                    ),

                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),

                      child: Text(
                        'Ready to\nStart?',
                        style: TextStyle(
                            fontSize: 35,
                            color:ColorResources.COLOR_PRIMARY,
                            fontWeight: FontWeight.bold),
                      ),
                    ),

                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0,vertical: 5),
                    child: Text('Welcome to the new era of event management',style: TextStyle(color:ColorResources.COLOR_PRIMARY,fontWeight: FontWeight.w600,fontSize: 18),),
                  ),

                    _buildSignIn(),
                    _buildSignUp()
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
  _buildSignIn(){return  Padding(
    padding: const EdgeInsets.symmetric(vertical: 15.0),
    child: Align(
      alignment: Alignment.center,
      child: ElevatedButton(
          onPressed: () {},
          child:Container(
            height: Get.height*0.07,width: Get.width/1.2,
            child: const Center(
              child: Text(
                'Sign In',
                style: TextStyle(
                    color: ColorResources.COLOR_PRIMARY, fontWeight: FontWeight.bold,fontSize: 22),
              ),
            ),
          ),
          style: ButtonStyle(
              backgroundColor:
              MaterialStateProperty.all<Color>(Colors.white),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      side: const BorderSide(color: ColorResources.COLOR_PRIMARY))))),
    ),
  );}
  _buildSignUp(){return  Align(
    alignment: Alignment.center,
    child: ElevatedButton(
        onPressed: () {Get.to(()=>SplashScreen());},
        child: Container(
          height: Get.height*0.07,width: Get.width/1.2,
          child: const Center(
            child: Text(
              'Sign Up',
              style: TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold,fontSize: 22),
            ),
          ),
        ),
        style: ButtonStyle(
            backgroundColor:
            MaterialStateProperty.all<Color>(ColorResources.COLOR_PRIMARY),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                )))),
  );}
}
