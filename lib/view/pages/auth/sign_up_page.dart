import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_event_registration/view/pages/auth/login_page.dart';
import 'package:tech_event_registration/view/widgets/dropdown_button.dart';
import '../../../utils/const/globals.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

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
                        Text("I already have an account.  ", style: TextStyle(color: Colors.black.withOpacity(0.7)),),
                        InkWell(
                            onTap: (){
                              Get.to(()=>const LoginPage());
                            },
                            child: const Text("Sign In", style: TextStyle(color: Colors.purple, fontWeight: FontWeight.w600),)),
                      ],
                    ),
                  )
//                  belowContainer(),
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
                  Text("Create New", style: textStyle_22_600,),
                ],
              ),
              const SizedBox(height: 7,),
              Row(
                children: const [
                  Text("Account", style: textStyle_22_600),
                ],
              ),
              const SizedBox(height: 20,),
              textFieldsColumn(),
//              const SizedBox(height: 10,),
              Container(
                 color: Colors.grey.withOpacity(0.2),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: MyDropDownButton(dropdownValue: "Select Role", items: ["Select Role","Manager", "Participant","Sponsor"])),
              const SizedBox(height: 30,),
              signUpButton("Create new Account")
//              forgotPassword(),
//              loginButton("Login"),
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
        customTextField("Enter Email", TextEditingController(), Icons.email_outlined),
        customTextField("Enter Phone Number", TextEditingController(), Icons.phone),
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

  signUpButton(String text){
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          onPressed: (){

          },
          child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
          style: ElevatedButton.styleFrom(
            fixedSize: const Size(double.infinity, 50),
          )
      ),
    );
  }

}


