import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tech_event_registration/controllers/auth_controller.dart';
import 'package:tech_event_registration/view/pages/auth/login_page.dart';
import 'package:tech_event_registration/view/widgets/dropdown_button.dart';
import '../../../utils/const/globals.dart';

class GetUserInfoScreen extends StatelessWidget {
  GetUserInfoScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> _signUpFormKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    log('/////////////////////////////////');

    return SafeArea(
      child: OrientationBuilder(
          builder: (context, snapshot) {
            return Scaffold(
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
                                SizedBox(
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("I already have an account.  ", style: TextStyle(color: Colors.black.withOpacity(0.7)),),
                                      InkWell(
                                          onTap: (){
                                            Get.to(()=>LoginPage());
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
                    );
                  }
              ),
            );
          }
      ),
    );
  }

  signInContainer(){

    AuthController authController = Get.find();

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
                  Text("Enter the following", style: textStyle_22_600,),
                ],
              ),
              const SizedBox(height: 7,),
              Row(
                children: const [
                  Text("Information", style: textStyle_22_600),
                ],
              ),
              const SizedBox(height: 20,),
              textFieldsColumn(),
//              const SizedBox(height: 10,),
              Container(
                  color: Colors.grey.withOpacity(0.2),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: MyDropDownButton(dropdownValue: "Select Role", items: const ["Select Role","Manager", "Participant","Sponsor"],)),
              const SizedBox(height: 10,),
              Obx(
                    ()=> Column(
                  children: [
                    authController.selectedRole!.value == "Participant" ?
                    Container(
                        color: Colors.grey.withOpacity(0.2),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: MyDropDownButton(dropdownValue: "Select Age", items: const ["Select Age","Under 18", "Above 18","Above 25", "Above 35"],))
                        : SizedBox(height: 0,),
                    const SizedBox(height: 10,),
                    authController.selectedRole!.value == "Participant" ?
                    Container(
                        color: Colors.grey.withOpacity(0.2),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: MyDropDownButton(dropdownValue: "Select Degree", items: const ["Select Degree","Matric", "Intermediate","Undergraduate", "Graduate"],))
                        : const SizedBox(height: 0,),
                  ],
                ),
              ),
              const SizedBox(height: 30,),
//              forgotPassword(),
            signUpButton("Create Account")
            ],
          ),
        ),
      ),
    );
  }

  textFieldsColumn(){
    AuthController controller = Get.find();
    return Form(
      key: _signUpFormKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          customTextField2("Enter UserName", controller.userNameController, Icons.person,
                (String? value){
              if (value == null) {
                return 'User Name is required';
              }
              return null;
            },
          ),
          customTextField2("Enter Phone Number", controller.phoneNumberController, Icons.phone,
                  (String? value){
                if (value == null) {
                  return 'Phone Number is required';
                }
                if (value.length < 11) {
                  return 'Invalid Number';
                }
                return null;
              },keyboardType: TextInputType.number
          ),

        ],
      ),
    );
  }

  customTextField2(String hint,TextEditingController controller, IconData prefixIcon, FormFieldValidator<String?> validator, {TextInputType? keyboardType} ){
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextFormField(
        keyboardType: keyboardType ?? TextInputType.text,
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

  bool selected(){

    AuthController controller = Get.find();

    if(categorySelectedValue==null || categorySelectedValue=="Select Role") {
      Get.snackbar("Error", "Please select a role.");
      return false;
    }
    else if((categorySelectedValue=="Participant")&&(controller.age == null || controller.age == "Select Age"))
    {
      Get.snackbar("Error", "Please select age");
      return false;
    }
    else if((categorySelectedValue=="Participant")&&(controller.degree == null || controller.age == "Select Degree"))
    {
      Get.snackbar("Error", "Please select degree");
      return false;
    }

    return true;
  }

  signUpButton(String text){
    AuthController controller = Get.find();

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          onPressed: (){

            if(_signUpFormKey.currentState!.validate() && selected()) {
              controller.postUserData();
            }
          },
          child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
          style: ElevatedButton.styleFrom(
            fixedSize: const Size(double.infinity, 50),
          )
      ),
    );
  }



}
