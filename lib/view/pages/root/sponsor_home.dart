import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_event_registration/utils/const/colors.dart';
import '../../../utils/const/globals.dart';

class SponsorHomeScreen extends StatelessWidget {
  const SponsorHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
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
                child: eventsList(),

            )


            // Positioned(
            //     top: 80,
            //     left: 0,
            //     child: eventsList())
          ],
        ),
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

  eventDetailContainerForSponsor() {
    return Padding(
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
                  children:  const [
                    Text(
                      "App Development Competition",
                      style: textStyle_22_600,
                    ),
                    SizedBox(height: 10,),
                    Text("All event details will be shown here.All event details will be shown here.All event details will be shown here.All event details will be shown here."),
                    SizedBox(height: 10,),
                    Text("27th January, 2021", style: TextStyle(fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
              Expanded(
                child: Image.asset("assets/images/app_dev.jpeg"),
              )
            ],
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
        children: const [
          Text(
            "Events for SPONSORS",
            style: TextStyle(color: Colors.white, fontSize: 20),
          )
        ],
      ),
    );
  }

  eventsList() {
    return SingleChildScrollView(
      child: Column(
        children: [
          eventDetailContainerForSponsor(),
          eventDetailContainerForSponsor(),
          eventDetailContainerForSponsor(),
          eventDetailContainerForSponsor(),

        ],
      ),
    );

    // return ListView.builder(
    //     itemCount: 1,
    //     itemBuilder: eventDetailContainerForSponsor()
    //
    // );
  }
}
