import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:tech_event_registration/view/pages/payment.dart';
import 'package:tech_event_registration/view/pages/root/widgets/eventdetailcontroller.dart';
import '../../../controllers/event.dart';
import '../../../models/events.dart';
import '../../../utils/const/colors.dart';

class EventDetailScreen extends StatelessWidget {
  EventController _eventcontroller=Get.find();
  EventDetailScreen({Key? key}) : super(key: key);
  EventDetailController _controller = Get.put(EventDetailController());
  @override
  Widget build(BuildContext context) {
    print(_eventcontroller.selectedevent!.Image);
    return SlidingUpPanel(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40), topRight: Radius.circular(40)),
        maxHeight: Get.height * 0.75,
        controller: _controller.panelController,
        minHeight: 0,
        panelSnapping: true,
        panel: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
                child: Image.network(
                  _eventcontroller.selectedevent!.Image,
                  height: Get.height * 0.3,
                  width: Get.width,
                  fit: BoxFit.cover,
                )),
SizedBox(height: 8,),
            Padding(
              padding: const EdgeInsets.fromLTRB(15,5,25,5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(_eventcontroller.selectedevent!.title ,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: ColorResources.COLOR_PRIMARY),),
                    ],
                  ),
                  SizedBox(height:10),
                  Row(
                    children: [
//                      Text('•',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: ColorResources.COLOR_PRIMARY),),
                      Text('Description',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: ColorResources.COLOR_PRIMARY),),
                    ],
                  ),
                  SizedBox(height:50,width:Get.width,child: Text(_eventcontroller.selectedevent!.description ,style: TextStyle(fontSize: 16),maxLines: 3,),),
                  SizedBox(height: 15,),
                  Row(
                    children: [
//                      Text('•',style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold,color: ColorResources.COLOR_PRIMARY),),

                      Text('Start Time',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: ColorResources.COLOR_PRIMARY),),
                   Spacer(),
//                      Text('•',style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold,color: ColorResources.COLOR_PRIMARY),),
                      Text('End Time',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: ColorResources.COLOR_PRIMARY),),
                    ],
                  ),
                  Row(
                    children: [

                      Text("       ${_eventcontroller.selectedevent!.starttime}",style: TextStyle(fontSize: 19),),Spacer(),                   Text("${_eventcontroller.selectedevent!.endtime}      ",style: TextStyle(fontSize: 19)),
                    ],
                  ),
                  SizedBox(height: 20,),


                  Row(
                    children: [
//                      Text('•',style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold,color: ColorResources.COLOR_PRIMARY),),
                      Row(
                        children: [
                          Text('Venue:    ',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: ColorResources.COLOR_PRIMARY),),
                          Text(_eventcontroller.selectedevent!.venue,style: TextStyle(fontSize: 19),),

                        ],
                      ),
                    ],
                  ),


                ],
              ),
            ),
            SizedBox(height: 16,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () async {Payment payment = Payment();await payment.makePayment(_eventcontroller.selectedevent!.price);},
                    child: Container(
                      height: Get.height*0.07,width: Get.width/1.2,
                      child: const Center(
                        child: Text(
                          'Payment',
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
                            ))))                    ],
            ),
          ],

        ));
  }


}
