import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/const/colors.dart';

class EventDetailScreen extends StatelessWidget {
  const EventDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(height: 20,),
                twoBoxes(),
              ],
            ),
          ),
      ),
    );
  }

  twoBoxes(){
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
            width: (Get.width/2) - 30,
            child: const Text(
              "Event Head:\n\n Mr Zia ul Haq",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        SizedBox(width: 10,),
        Container(
          decoration: BoxDecoration(
            color: ColorResources.COLOR_PRIMARY,
//            color: Colors.green[500],
            borderRadius: BorderRadius.circular(10),

          ),
          padding: EdgeInsets.fromLTRB(16, 16, 16, 20),
          width: (Get.width/2) - 40,
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
            bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
      ),
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
