import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_event_registration/controllers/event.dart';
import 'package:tech_event_registration/models/events.dart';
import 'package:tech_event_registration/services/user_db.dart';
import 'package:tech_event_registration/utils/const/colors.dart';
import 'package:tech_event_registration/view/pages/root/event_detail_screen.dart';
import 'package:tech_event_registration/view/pages/root/widgets/drwaer.dart';
import '../../../controllers/auth_controller.dart';
import '../../../utils/const/globals.dart';
import 'widgets/eventdetailcontroller.dart';

class SponsorHomeScreen extends StatelessWidget {
  SponsorHomeScreen({Key? key}) : super(key: key);

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  List<Events> allEventsList = [];

  getUser()async{

    AuthController controller = Get.find();
    if(controller.userModel == null) {
      await controller.getUser(FirebaseAuth.instance.currentUser!.uid);
    }

    if(controller.userModel == null) {
      log("still null");
    }
    else {
      log("not null");
      log(controller.userModel!.name!);
    }

    allEventsList = await UserDatabase.getevents();

  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: OrientationBuilder(
        builder: (context, snapshot) {
          return Scaffold(
            key: scaffoldKey,
            drawer: MyDrawer(),
            body: FutureBuilder(
              future: getUser(),
              builder: (context,snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(

                    ),
                  );
                } else {
                  return Stack(
                  children: [

                    Column(
                      children: [
                        purpleCurveContainer(),
                      ],
                    ),
                    Positioned(
                        right: 0, left: 0, top: 20,
                        child: appBarRow()
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      top: 80,
                        child: eventsList(allEventsList),

                    ), EventDetailScreen()



                    // Positioned(
                    //     top: 80,
                    //     left: 0,
                    //     child: eventsList())
                  ],
                );
                }
              }
            ),
          );
        }
      ),
    );
  }

  purpleCurveContainer() {
    return Container(
      height: Get.height / 5,
      decoration: const BoxDecoration(
        color: ColorResources.COLOR_PRIMARY,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
      ),
    );
  }

  eventDetailContainerForSponsor(Events list ) {
    EventController _controller=Get.put(EventController());
    return GestureDetector(
      onTap: (){_controller.setevent(list);
      EventDetailController _vcontroller=Get.put(EventDetailController());
      _vcontroller.panelController.open();
        },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: Material(
          elevation: 10,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      Text(
                        list.title,
                        style: textStyle_22_600,
                      ),
                      SizedBox(height: 10,),
                      Text(list.description),
                      SizedBox(height: 10,),
                      Text(list.endtime, style: TextStyle(fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
                Expanded(
                  child: Image.network(list.Image,height: 100,width: 100,fit: BoxFit.cover,),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  appBarRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:  [
          InkWell(
              onTap: (){
                scaffoldKey.currentState!.openDrawer();
              },
              child: Icon(Icons.menu, color: Colors.white,)),
          Spacer(),
          Text(
            "Events for SPONSORS",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          Spacer()
        ],
      ),
    );
  }

  eventsList(List<Events> allEventsList) {
    return Container(height:Get.height-120,child: ListView.builder( shrinkWrap:true,itemBuilder:(context,index){return eventDetailContainerForSponsor(allEventsList[index]);},itemCount: allEventsList.length,));

  }
}
