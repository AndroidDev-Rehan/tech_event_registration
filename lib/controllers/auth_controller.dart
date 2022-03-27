import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tech_event_registration/controllers/user_controller.dart';
import 'package:tech_event_registration/view/pages/auth/login_page.dart';
import 'package:tech_event_registration/view/pages/home/home.dart';
import 'package:tech_event_registration/view/pages/root/sponsor_home.dart';
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

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Rxn<User> _firebaseUser = Rxn<User>();
  User? get user => _firebaseUser.value ;
 setuser(){
   _firebaseUser.value=null;
 }

  UserModel? userModel;

  final _loading = false.obs ;
  bool get loading => _loading.value ;


  /// Obscure Text
  final _signUpObscureText = true.obs ;
  bool get getSignUpObscureText => _signUpObscureText.value ;
  void setSignUpObscureText() => _signUpObscureText.value = !_signUpObscureText.value ;


  /// Profile Setup
  TextEditingController userNameController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  final _userProfileURL = "".obs ;
  String get userProfileURL => _userProfileURL.value ;


  final UserController _userController = Get.find<UserController>() ;


  @override
  void onInit() {
    _firebaseUser.bindStream(_auth.authStateChanges());
    super.onInit();
  }

  void signUp()async {
    try{
      _loading.value = true ;
      UserCredential userCredential =  await _auth.createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text);
      userModel = UserModel(
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
      await UserDatabase().createUser(userModel!);
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
      Get.off(()=>const AuthWrapper(),transition: Transition.fadeIn);
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
      FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text);
      _loading.value = false ;
      Get.back();
      Get.snackbar("Success","Email Updated",snackPosition: SnackPosition.BOTTOM);
    }
    catch(e){
      _loading.value = false ;
      Get.snackbar("Error",e.toString(),snackPosition: SnackPosition.BOTTOM);
    }
  }

  // void setUpUser() async{
  //   _loading.value = true ;
  //   String id = _firebaseUser.value!.uid ;
  //   var user = UserModel(name: nameController.text);
  //   try {
  //     await FirebaseFirestore.instance.collection("Users").doc(id).update({
  //       "name" : user.name,
  //     });
  //     _userController.updateUserController(user);
  //  ///   Get.offAll(()=>AuthWrapper());
  //     _loading.value =false;
  //
  //   }catch(e){
  //     print(e);
  //     Get.snackbar("Error", e.toString(),snackPosition: SnackPosition.BOTTOM);
  //     _loading.value = false ;
  //
  //   }
  // }

  Future<UserModel>  getUser (String id) async {
    try{
      DocumentSnapshot doc = await FirebaseFirestore.instance.collection("Users").doc(id).get();
      userModel = UserModel.fromFirestore(doc);
      return userModel!;
    }
    catch(e){
      print(e);
      Get.snackbar("error", e.toString(),snackPosition: SnackPosition.BOTTOM ) ;
      rethrow ;
    }
  }



  void signOut() async {
    try{
      _loading.value = true;
      await _auth.signOut() ;
      await FirebaseAuth.instance.signOut();
      await GoogleSignIn().signOut();
      Get.find<UserController>().clear();

      Get.offAll(LoginPage());
    }
    catch(e){
      print(e);
      Get.snackbar("Error", e.toString(),snackPosition: SnackPosition.BOTTOM);
      print(e);
    }
    _loading.value = false;
  }



  void clearControllers(){
    emailController.clear();
    passwordController.clear();
    phoneNumberController.clear();
    userNameController.clear();
    confirmPasswordController.clear();
    selectedRole!.value = "Select Role";
    degree = null;
    age = null;
  }

  static Future<bool> checkUserExist(String docID) async {
    bool exists = false;
    try {
      await FirebaseFirestore.instance.doc("Users/$docID").get().then((doc) {
        if (!doc.exists)
          exists = false;
        else
          exists = true;
      });
      return exists;
    } catch (e) {
      Get.snackbar("Error", e.toString());
      return false;
    }
  }

  bool firstTimeLogin = false;

   Future<User?> signInWithGoogle() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    final GoogleSignIn googleSignIn = GoogleSignIn();

    _loading.value = true;

      final GoogleSignInAccount? googleSignInAccount =
      await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        try {
          final UserCredential userCredential =
          await auth.signInWithCredential(credential);

          user = userCredential.user;
          _loading.value = false;
          firstTimeLogin = !(await checkUserExist(user!.uid));
          AuthController controller = Get.find();

          userModel = await controller.getUser(FirebaseAuth.instance.currentUser!.uid);
          Get.off(const AuthWrapper());
        } on FirebaseAuthException catch (e) {
          if (e.code == 'account-exists-with-different-credential') {
            Get.snackbar("Error", 'The account already exists with a different credential',);
          } else if (e.code == 'invalid-credential') {
            Get.snackbar("Error", 'Error occurred while accessing credentials. Try again.',);
          }
        } catch (e) {
          Get.snackbar("Error", 'Error occurred using Google Sign In. Try again.',);
        }
      }

       // notFirstTimeLogin =false;
       // print(notFirstTimeLogin);


      return user;
  }


  postUserData() async{
     if(FirebaseAuth.instance.currentUser == null)
       {
         print("user null");
       }
    try{
      _loading.value = true ;
      userModel = UserModel(
          email: FirebaseAuth.instance.currentUser!.email,
          id: FirebaseAuth.instance.currentUser!.uid,
          name: FirebaseAuth.instance.currentUser!.displayName,
          createdAt: DateTime.now(),
          modifiedAt: DateTime.now(),
          category: selectedRole!.value,
          phoneNumber: phoneNumberController.text,
          degree: degree,
          age: age
      );
      await UserDatabase().createUser(userModel!);
      clearControllers();
      _loading.value = false ;
      Get.offAll(()=> HomePage());
    }
    catch(e){
      _loading.value = false ;
      Get.snackbar("Error", e.toString(),snackPosition: SnackPosition.BOTTOM);
      print(e);
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    userNameController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }


}