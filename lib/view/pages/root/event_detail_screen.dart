import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:tech_event_registration/view/pages/root/widgets/eventdetailcontroller.dart';
import '../../../utils/const/colors.dart';

class EventDetailScreen extends StatelessWidget {
  EventDetailScreen({Key? key}) : super(key: key);
  EventDetailController _controller = Get.put(EventDetailController());
  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40), topRight: Radius.circular(40)),
        maxHeight: Get.height * 0.8,
        controller: _controller.panelController,
        minHeight: 0,
        panelSnapping: true,
        panel: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
                child: Image.asset(
                  'assets/images/app_dev.jpeg',
                  height: Get.height * 0.3,
                  width: Get.width,
                  fit: BoxFit.cover,
                )),
SizedBox(height: 8,),
            SizedBox(child: Text('Softech eventsdfghjkkkdtgggggggggggggggggggg' ,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: ColorResources.COLOR_PRIMARY),)),
            Row(
              children: [
                Text('•',style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold,color: ColorResources.COLOR_PRIMARY),),
                Text(' Description',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: ColorResources.COLOR_PRIMARY),),
              ],
            ),
            SizedBox(height:50,width:Get.width,child: Text('oftech evenStoftech evenoftech evenoftech evenoftech evenoftech evenoftech evenoftech evenoftech evenoftech evenoftech evenoftech evenoftech evenoftech evenoftech evenoftech even' ,style: TextStyle(fontSize: 15),maxLines: 3,),),
            Row(
              children: [
                Text('•',style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold,color: ColorResources.COLOR_PRIMARY),),
                Text(' Date & Time',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: ColorResources.COLOR_PRIMARY),),
              ],
            ),
            Row(
              children: [
                Text("Start Time: 2:00 pm"),Spacer(),Text("End Time: 2:05 pm"),
              ],
            ),
            Text("At 9th March 2021"),
            Row(
              children: [
                Text('•',style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold,color: ColorResources.COLOR_PRIMARY),),
                Text(' Venue',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: ColorResources.COLOR_PRIMARY),),
              ],
            ),
            Text("Fast Nu fuck of now"),
          ],

        ));
  }

  twoBoxes() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Material(
          borderRadius: BorderRadius.circular(10),
          elevation: 10,
          child: Container(
            decoration: BoxDecoration(
              color: ColorResources.COLOR_PRIMARY,
//            color: Colors.green[500],
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.fromLTRB(16, 16, 16, 20),
            width: (Get.width / 2) - 30,
            child: const Text(
              "Event Head:\n\n Mr Zia ul Haq",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Container(
          decoration: BoxDecoration(
            color: ColorResources.COLOR_PRIMARY,
//            color: Colors.green[500],
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.fromLTRB(16, 16, 16, 20),
          width: (Get.width / 2) - 40,
          child: const Text(
            "Event Venue:\n\n Fast University",
            style: TextStyle(color: Colors.white),
          ),
        )
      ],
    );
  }

  purpleCurveContainer() {
    return Container(
      height: Get.height / 5,
      decoration: const BoxDecoration(
        color: ColorResources.COLOR_PRIMARY,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),),
    );
  }

  appBarRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            "App Development",
            style: TextStyle(color: Colors.white, fontSize: 20),
          )
        ],
      ),
    );
  }
}
