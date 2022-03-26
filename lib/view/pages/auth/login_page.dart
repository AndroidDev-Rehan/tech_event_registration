import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tech_event_registration/utils/const/colors.dart';
import 'package:tech_event_registration/utils/const/globals.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            width: Get.width,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children:  [
                  SizedBox(height: 20,),
                  Image.asset("assets/images/logo.png", scale: 3,),
                  SizedBox(height: 20,),
                  signInContainer(),
                  SizedBox(height: 20,),
                  belowContainer(),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  signInContainer(){
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: EdgeInsets.fromLTRB(16, 24, 16, 16),
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
                  Text("Sign in", style: textStyle_22_600,),
                ],
              ),
              const SizedBox(height: 7,),
              Row(
                children: const [
                  Text("to continue", style: textStyle_22_600),
                ],
              ),
              SizedBox(height: 20,),
              textFieldsColumn(),
              SizedBox(height: 30,),
              forgotPassword(),
              SizedBox(height: 20,),
              loginButton("Login"),
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
        customTextField("Enter Username", TextEditingController(), Icons.person),
        customTextField("Enter Password", TextEditingController(), Icons.lock),
      ],
    );
  }

  customTextField(String hint,TextEditingController controller, IconData prefixIcon  ){
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextFormField(
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

          },
          child: Text(text, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
        style: ElevatedButton.styleFrom(
          fixedSize: Size(double.infinity, 50),
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

  belowContainer(){
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Don't have an account? ", style: TextStyle(color: Colors.black.withOpacity(0.7)),),
              InkWell(child: Text("Create new account", style: const TextStyle(color: Colors.purple, fontWeight: FontWeight.w600),)),
            ],
          ),
        ),
        const SizedBox(height: 20,),
        Row(
          children: [
            Expanded(
              child: Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey.withOpacity(0.2)
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text("Or"),
            ),
            Expanded(
              child: Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey.withOpacity(0.2)
              ),
            )                ],
        ),
        const SizedBox(height: 20,),
        ClipRRect(
//          borderRadius: BorderRadius.circular(20),
          child: SignInButton(
            Buttons.Google,
//            elevation: 20,
            text: "Sign in with Google",
            onPressed: () {},
//          mini: true,

          ),
        )
      ],
    );
  }



}
