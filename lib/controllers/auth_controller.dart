import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_event_registration/controllers/user_controller.dart';
import '../models/user.dart';
import '../services/user_db.dart';
import '../utils/authWrapper.dart';



class AuthController extends GetxController{

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController =  TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  Rx<String>? selectedRole="".obs;
  String? age;
  String? degree;

  ///Forgot Password
  TextEditingController forgotPasswordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance ;
  final Rxn<User> _firebaseUser = Rxn<User>() ;
  User? get user => _firebaseUser.value ;

  final _loading = false.obs ;
  bool get loading => _loading.value ;


  /// Obscure Text
  var _signUpObscureText = true.obs ;
  bool get getSignUpObscureText => _signUpObscureText.value ;
  void setSignUpObscureText() => _signUpObscureText.value = !_signUpObscureText.value ;


  /// Profile Setup
  TextEditingController userNameController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  var _userProfileURL = "".obs ;
  String get userProfileURL => _userProfileURL.value ;


  UserController _userController = Get.find<UserController>() ;


  @override
  void onInit() {
    _firebaseUser.bindStream(_auth.authStateChanges());
    super.onInit();
  }

  void signUp()async {
    try{
      _loading.value = true ;
      UserCredential userCredential =  await _auth.createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text);
      final user = UserModel(
        email: emailController.text,
          id: userCredential.user!.uid,
          name: userNameController.text,
          createdAt: DateTime.now(),
          modifiedAt: DateTime.now(),
        category: selectedRole!.value,
        phoneNumber: phoneNumberController.text,
        degree: degree,
        age: age
      );
      await UserDatabase().createUser(user);
      Get.off(()=>AuthWrapper());
      clearControllers();
      _loading.value = false ;
    }
    catch(e){
      _loading.value = false ;
      Get.snackbar("Error", e.toString(),snackPosition: SnackPosition.BOTTOM);
      print(e);
    }
  }

  void login() async {
    _loading.value = true ;
    try{
      await _auth.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
    ///  Get.to(()=>AuthWrapper(),transition: Transition.fadeIn);
      clearControllers();
      _loading.value = false ;
    }
    catch(e){
      _loading.value = false ;
      Get.snackbar("Error", e.toString(),snackPosition: SnackPosition.BOTTOM);
      print(e);
    }
  }

  void sendPasswordResetEmail() async {
    try{
      _loading.value = true ;
      await _auth.sendPasswordResetEmail(email:forgotPasswordController.text);
      Get.back();
      Get.snackbar("Success","Check Your Inbox",snackPosition: SnackPosition.BOTTOM);
      _loading.value = false ;
    }
    catch(e){
      _loading.value = false ;
      Get.snackbar("Error",e.toString(),snackPosition: SnackPosition.BOTTOM);
    }
  }

  void resetEmail() async{
    try{

      _loading.value = true ;
      User firebaseUser = _auth.currentUser! ;
      firebaseUser.updateEmail(emailController.text);

      _loading.value = false ;

      Get.back();
      Get.snackbar("Success","Email Updated",snackPosition: SnackPosition.BOTTOM);
    }
    catch(e){
      _loading.value = false ;
      Get.snackbar("Error",e.toString(),snackPosition: SnackPosition.BOTTOM);
    }
  }

  void setUpUser() async{
    _loading.value = true ;
    String id = _firebaseUser.value!.uid ;
    var user = UserModel(name: nameController.text);
    try {
      await FirebaseFirestore.instance.collection("Users").doc(id).update({
        "name" : user.name,
      });
      _userController.updateUserController(user);
   ///   Get.offAll(()=>AuthWrapper());
      _loading.value =false;

    }catch(e){
      print(e);
      Get.snackbar("Error", e.toString(),snackPosition: SnackPosition.BOTTOM);
      _loading.value = false ;

    }
  }


  void signOut() async {
    try{
      await _auth.signOut() ;
      Get.find<UserController>().clear();
      Get.back();
    }
    catch(e){
      print(e);
      Get.snackbar("Error", e.toString(),snackPosition: SnackPosition.BOTTOM);
      print(e);

    }
  }



  void clearControllers(){
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

}