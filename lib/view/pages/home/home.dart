import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_event_registration/utils/const/colors.dart';
import 'package:tech_event_registration/view/pages/root/event_detail_screen.dart';
import 'package:tech_event_registration/view/pages/root/widgets/eventlist.dart';
import 'package:tech_event_registration/view/pages/root/widgets/feature.dart';

import '../../../controllers/auth_controller.dart';
import '../../../controllers/event.dart';
import '../root/widgets/drwaer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  getUser() async{
    AuthController controller = Get.find();
    if(controller.userModel == null) {
      await controller.getUser(FirebaseAuth.instance.currentUser!.uid);
    }


  }

  EventController _eventcontroller=Get.put(EventController());
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
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting)
                {
                  return Center(child: CircularProgressIndicator(),);
                }
                else {return Container
                  (
                    height: Get.height,width: Get.width,
                    child: Stack(overflow:Overflow.visible,
                      children: [
                        Positioned(child: Container(

                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child: InkWell(
                                        onTap: (){
                                          scaffoldKey.currentState!.openDrawer();
                                        },
                                        child: Icon(Icons.menu, color: Colors.white,)),
                                  ),
                                  Spacer(),
                                  Image.asset('assets/images/logo.png',color: Colors.white,height: 80,width: 200,),
                                  Spacer()
                                ],
                              ),
                              Feature(),

                            ],
                          ),
                          height: Get.height/2.1,
                          width: Get.width,

                          decoration: const BoxDecoration(gradient: LinearGradient(
                            colors: [ColorResources.COLOR_PRIMARY, Color(0x9C6127FF)],
                            begin: Alignment.bottomRight,end: Alignment.topLeft,
                            stops: [0.1, 0.6],
                          ),

                          ),
                        ),top: 0,left: 0,),
                        Positioned(child:  Container(decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40))),
                            width: Get.width,child: Events()
                        ),top:Get.height/2.35 ,left: 0,),
                        EventDetailScreen()

                      ],
                    ))
                ;}
              }
                )
          );

        }
      ),
    );
  }
}

