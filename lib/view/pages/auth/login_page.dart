import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:get/get.dart';
import 'package:tech_event_registration/controllers/auth_controller.dart';
import 'package:tech_event_registration/controllers/user_controller.dart';
import 'package:tech_event_registration/utils/const/colors.dart';
import 'package:tech_event_registration/utils/const/globals.dart';
import 'package:tech_event_registration/view/pages/auth/sign_up_page.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatelessWidget {
   LoginPage({Key? key}) : super(key: key);

  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetX(
          builder: (AuthController controller) {
            return ModalProgressHUD(
              inAsyncCall: controller.loading,
              child: SingleChildScrollView(
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
                        belowContainer(),

                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        ),
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
                  Text("Sign in", style: textStyle_22_600,),
                ],
              ),
              const SizedBox(height: 7,),
              Row(
                children: const [
                  Text("to continue", style: textStyle_22_600),
                ],
              ),
              const SizedBox(height: 20,),
              textFieldsColumn(),
              const SizedBox(height: 30,),
              forgotPassword(),
              const SizedBox(height: 20,),
              loginButton("Login"),
            ],
          ),
        ),
      ),
    );
  }

  textFieldsColumn(){
    AuthController authController = Get.find();
    return Form(
      key: _loginFormKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          customTextField("Enter Email", authController.emailController, Icons.person,
                  (String? value){
                if (value == null) {
                  return 'Email is required';
                }
                if (value.isEmpty) {
                  return 'Email is required';
                }
                if (!GetUtils.isEmail(value)) {
                  return "Invalid Format";
                }
                return null;
              }
              ),
          customTextField("Enter Password", authController.passwordController, Icons.lock,
                  (String? value) {
                if (value==null) {
                  return 'password is required';
                }
                if(value.isEmpty){
                  return 'password is required';
                }
                return null;
              }

          ),
        ],
      ),
    );
  }

  customTextField(String hint,TextEditingController controller, IconData prefixIcon, FormFieldValidator<String?> validator ){
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextFormField(
        controller: controller,
        validator: validator,
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
    AuthController controller = Get.find();
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          onPressed: (){
            if(_loginFormKey.currentState!.validate()) {
              controller.login();
            }
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
               InkWell(
                  onTap: (){
                    Get.to(()=>SignUpScreen());
                  },
                  child: Text("Create new account", style: TextStyle(color: Colors.purple, fontWeight: FontWeight.w600),)),
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
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
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

// (String? value) {
// if (value == null) {
// return 'Email is required';
// }
// if (value.isEmpty) {
// return 'Email is required';
// }
// if (!GetUtils.isEmail(value)) {
// return "Invalid Format";
// }
// return null;
// }