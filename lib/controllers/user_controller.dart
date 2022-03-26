
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../models/user.dart';
import '../services/user_db.dart';

class UserController extends GetxController {

  final  _userModel = UserModel().obs ;
  UserModel get userModel => _userModel.value ;
  set setUserModel(UserModel user) => this._userModel.value = user ;

  final _loading = false.obs ;
  bool get loading => _loading.value ;



  @override
  void onInit() {

    super.onInit();
  }

  void clear(){_userModel.value = UserModel();}

  getCurrentUser(String id) async {
    _userModel.value = await UserDatabase().getUser(id);
  }


  void updateUserController(UserModel userModel) {
    _userModel.update((val) {
      val?.name = userModel.name;

    });
  }

  void signOut(){
 ///   Get.offAll(()=>WelcomePage());
    FirebaseAuth.instance.signOut();
  }

  void updateUserProfilePhoto(String profileURL){
    _userModel.update((val) {
    });
  }


  void updateUserProfile(name,username,city)async{
    try {
      _userModel.update((val) {
        val?.name = name;

      });
      await FirebaseFirestore.instance.collection("Users").doc(_userModel.value.id).update({
        "name":name ,
        "city":city ,
        "modifiedOn" : DateTime.now() ,
      });
      Get.back();
      Get.snackbar("Success","Changes Saved",snackPosition: SnackPosition.BOTTOM);
    }catch(e){
      print(e);
    }
  }

}