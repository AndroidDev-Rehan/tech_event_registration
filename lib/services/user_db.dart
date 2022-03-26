
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tech_event_registration/models/events.dart';
import 'package:tech_event_registration/models/feature.dart';

import '../models/user.dart';

class UserDatabase{

  var userRef =  FirebaseFirestore.instance.collection("Users");

  Future<bool> createUser(UserModel user) async {
    try{
     await userRef.doc(user.id).set(user.toMap());
      return true ;
    }
    catch(e){
      print(e);
      Get.snackbar("error", e.toString(),snackPosition: SnackPosition.BOTTOM ) ;
      return false ;
    }
  }
  static Future<List<Feature>> getfeature() async {
    try{
      List<Feature> list=[];
      var data=await FirebaseFirestore.instance.collection("Adds").get();
     data.docs.forEach((element) { list.add(Feature.fromJson(element.data()));});
     return list;

    }
    catch(e){
      print(e);
      Get.snackbar("error", e.toString(),snackPosition: SnackPosition.BOTTOM ) ;
      return [] ;
    }
  }
  static Future<List<Events>> getevents() async {
    try{
      List<Events> list=[];
      var data=await FirebaseFirestore.instance.collection("Events").get();
      print(data);
       data.docs.forEach((element) { list.add(Events.fromJson(element.data()));});

      return list;

    }
    catch(e){
      print(e);
      Get.snackbar("error", e.toString(),snackPosition: SnackPosition.BOTTOM ) ;
      return [] ;
    }
  }
  Future<void> updateUserProfilePhoto(String id,String photoURL)async {
    try{
      await userRef.doc(id).update({
        "profileURL": photoURL ,
      });
    }
    catch(e){
      print(e);
      Get.snackbar("error", e.toString(),snackPosition: SnackPosition.BOTTOM ) ;
    }
  }

  Future<bool> updateCreatorField(String id) async {

    try{
     await userRef.doc(id).update({
        "isCreator": true ,
      });
      return true ;
    }
    catch(e){
      print(e);
      Get.snackbar("error", e.toString(),snackPosition: SnackPosition.BOTTOM ) ;
      return false ;
    }

  }

  Future<UserModel>  getUser (String id) async {
    try{
      DocumentSnapshot doc = await userRef.doc(id).get();
      return UserModel.fromFirestore(doc) ;
    }
    catch(e){
      print(e);
      Get.snackbar("error", e.toString(),snackPosition: SnackPosition.BOTTOM ) ;
      rethrow ;
    }
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
      return false;
    }
  }

}