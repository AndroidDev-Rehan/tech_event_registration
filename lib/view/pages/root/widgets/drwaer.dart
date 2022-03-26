import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_event_registration/controllers/auth_controller.dart';
import 'package:tech_event_registration/controllers/user_controller.dart';
import 'package:tech_event_registration/utils/const/colors.dart';

class MyDrawer extends StatelessWidget {


  AuthController authController = Get.find();

   MyDrawer();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: ColorResources.COLOR_PRIMARY,
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.white,),
              padding: EdgeInsets.zero,
              child: UserAccountsDrawerHeader(
                margin: EdgeInsets.zero,
                accountName: Text(authController.userModel!.name!, style: TextStyle(fontSize: 16),),
                accountEmail: Text(FirebaseAuth.instance.currentUser!.email!,style: TextStyle(fontSize: 16)),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage("assets/images/person.png",),
                ),
              ),
            ),
            Expanded(
              child: Container(
             color: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: Icon(
                        CupertinoIcons.home,
                        color: ColorResources.COLOR_PRIMARY,
                      ),
                      title: Text(
                        "Home",
                        textScaleFactor: 1.5,
                        style: TextStyle(
                          color: ColorResources.COLOR_PRIMARY,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        CupertinoIcons.profile_circled,
                        color: ColorResources.COLOR_PRIMARY,
                      ),
                      title: Text(
                        "Profile",
                        textScaleFactor: 1.5,
                        style: TextStyle(
                          color: ColorResources.COLOR_PRIMARY,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        CupertinoIcons.mail,
                        color: ColorResources.COLOR_PRIMARY,
                      ),
                      title: Text(
                        "Email me",
                        textScaleFactor: 1.5,
                        style: TextStyle(
                          color: ColorResources.COLOR_PRIMARY,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
    //   }
    // );
  }
}