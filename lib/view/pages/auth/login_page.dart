import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
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
            child: Column(
              children:  [
                SizedBox(height: 20,),
                Icon(Icons.login, color: Colors.blue,),
                SizedBox(height: 20,),
                signInContainer(),

              ],
            ),
          ),
        ),
      ),
    );
  }

  signInContainer(){
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Material(
        elevation: 10,
        child: Container(
          padding: EdgeInsets.fromLTRB(16, 24, 16, 16),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: const [
                    Text("Sign in", style: textStyle_20_600,),
                  ],
                ),
                SizedBox(height: 4,),
                Row(
                  children: [
                    Text("to continue", style: textStyle_20_600),
                  ],
                ),
                SizedBox(height: 4,),
                textFieldsColumn(),
                loginButton("Login"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  textFieldsColumn(){
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        customTextField("login", TextEditingController(), Icons.person),
        customTextField("password", TextEditingController(), Icons.lock),

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
          prefixIcon: Icon(prefixIcon),
        ),
      ),
    );
  }

  loginButton(String text){
    return ElevatedButton(
        onPressed: (){},
        child: Text(text)
    );
  }


}
