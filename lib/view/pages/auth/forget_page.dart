import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tech_event_registration/controllers/auth_controller.dart';
import 'package:tech_event_registration/utils/const/colors.dart';
import 'package:tech_event_registration/utils/const/globals.dart';

class ForgetPage extends StatelessWidget {
  const ForgetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: OrientationBuilder(
        builder: (context, snapshot) {
          return Scaffold(
            body: SingleChildScrollView(
              child: SizedBox(
                width: Get.width,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children:  [
                      const SizedBox(height: 20,),
                      Image.asset("assets/images/logo.png", scale: 3,),
                      const SizedBox(height: 20,),
                      signInContainer(),
                      const SizedBox(height: 20,),
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Remember? ", style: TextStyle(color: Colors.black.withOpacity(0.7)),),
                            const InkWell(child: Text("Login", style: TextStyle(color: Colors.purple, fontWeight: FontWeight.w600),)),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
          );
        }
      ),
    );
  }

  signInContainer(){
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
        decoration:  BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),

        ),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: const [
                  Text("Reset Password", style: textStyle_22_600,),
                ],
              ),
              const SizedBox(height: 20,),
              textFieldsColumn(),
              const SizedBox(height: 20,),
              loginButton("Reset"),
            ],
          ),
        ),
      ),
    );
  }

  textFieldsColumn(){
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        customTextField("Enter Email", Get.find<AuthController>().emailController, Icons.person),
      ],
    );
  }

  customTextField(String hint,TextEditingController controller, IconData prefixIcon  ){
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextFormField(controller: Get.find<AuthController>().emailController,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          border: InputBorder.none,
//          prefix: Icon(prefixIcon),
          prefixIcon: Icon(prefixIcon),

        ),
      ),
    );
  }

  loginButton(String text){
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          onPressed: (){
AuthController _controller=Get.find();
_controller.resetEmail();
          },
          child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
          style: ElevatedButton.styleFrom(
            fixedSize: const Size(double.infinity, 50),
          )
      ),
    );
  }

  forgotPassword(){
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: const [
        Text("Forgot Password?", style: TextStyle(color: ColorResources.COLOR_PRIMARY, fontWeight: FontWeight.bold, fontSize: 16),),
      ],
    );
  }




}
