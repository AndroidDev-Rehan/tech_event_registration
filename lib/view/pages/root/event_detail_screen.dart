import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:tech_event_registration/controllers/auth_controller.dart';
import 'package:tech_event_registration/view/pages/payment.dart';
import 'package:tech_event_registration/view/pages/root/widgets/eventdetailcontroller.dart';
import '../../../controllers/event.dart';
import '../../../utils/const/colors.dart';
import '../home/bidingpage.dart';

class EventDetailScreen extends StatelessWidget {
var degree=["Matric", "Intermediate","Undergraduate", "Graduate"];
var age=["Under 18", "Above 18","Above 25", "Above 35"];

  AuthController _authController=Get.find();
  EventDetailScreen({Key? key}) : super(key: key);
  EventDetailController _controller = Get.put(EventDetailController());
  @override
  Widget build(BuildContext context) {

    return
      GetBuilder<EventController>( // specify type as Controller
       init:EventController() ,
        builder: (_eventcontroller) =>
      SlidingUpPanel(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(40), topRight: const Radius.circular(40)),
        maxHeight: Get.height * 0.75,
        controller: _controller.panelController,
        minHeight: 0,
        panelSnapping: true,
        panel: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
                child: Image.network(
                  _eventcontroller.selectedevent.Image,
                  height: Get.height * 0.3,
                  width: Get.width,
                  fit: BoxFit.cover,
                )),
const SizedBox(height: 8,),
            Padding(
              padding: const EdgeInsets.fromLTRB(15,5,25,5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(_eventcontroller.selectedevent.title ,overflow: TextOverflow.ellipsis,style: const TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: ColorResources.COLOR_PRIMARY),),
                    ],
                  ),
                  const SizedBox(height:10),
                  Row(
                    children: const [
//                      Text('•',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: ColorResources.COLOR_PRIMARY),),
                      Text('Description',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: ColorResources.COLOR_PRIMARY),),
                    ],
                  ),
                  SizedBox(height:50,width:Get.width,child: Text(_eventcontroller.selectedevent.description ,style: const TextStyle(fontSize: 16),maxLines: 3,),),
                  const SizedBox(height: 15,),
                  Row(
                    children: const [
//                      Text('•',style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold,color: ColorResources.COLOR_PRIMARY),),

                      Text('Start Time',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: ColorResources.COLOR_PRIMARY),),
                   Spacer(),
//                      Text('•',style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold,color: ColorResources.COLOR_PRIMARY),),
                      Text('Date',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: ColorResources.COLOR_PRIMARY),),
                    ],
                  ),
                  Row(
                    children: [

                      Text("       ${_eventcontroller.selectedevent.starttime}",style: const TextStyle(fontSize: 19),),const Spacer(),                   Text("${_eventcontroller.selectedevent.endtime}",style: const TextStyle(fontSize: 19)),
                    ],
                  ),
                  const SizedBox(height: 20,),


                  Row(
                    children: [
//                      Text('•',style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold,color: ColorResources.COLOR_PRIMARY),),
                      Row(
                        children: [
                          const Text('Venue:    ',style: const TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: ColorResources.COLOR_PRIMARY),),
                          Text(_eventcontroller.selectedevent.venue,style: const TextStyle(fontSize: 19),),

                        ],
                      ),
                    ],
                  ),


                ],
              ),
            ),
            const SizedBox(height: 16,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _authController.userModel!.category=='Participant'?degree.indexOf(_eventcontroller.selectedevent.educriteria)<=degree.indexOf(_authController.userModel!.degree!)&&age.indexOf(_eventcontroller.selectedevent.agecriteria)<=age.indexOf(_authController.userModel!.age!)?
                ElevatedButton(
                    onPressed: () async {Payment payment = Payment();await payment.makePayment(_eventcontroller.selectedevent.price);
},
                    child: Container(
                      height: Get.height*0.07,width: Get.width/1.2,
                      child: const Center(
                        child: Text(
                          'Pay',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold,fontSize: 22),
                        ),
                      ),
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all<Color>(ColorResources.COLOR_PRIMARY),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            )))) :Text('Not Eligible',style: TextStyle(color: Colors.red,fontSize: 20,fontWeight: FontWeight.bold),)    :_authController.userModel!.category=='Sponsor'? ElevatedButton(
                    onPressed: ()  {Get.to(()=>BiddingPage());
                    },
                    child: Container(
                      height: Get.height*0.07,width: Get.width/1.2,
                      child: const Center(
                        child: Text(
                          'Select Stalls',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold,fontSize: 22),
                        ),
                      ),
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all<Color>(ColorResources.COLOR_PRIMARY),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            )))):    SizedBox()       ],
            ),
          ],

        )));
  }


}
