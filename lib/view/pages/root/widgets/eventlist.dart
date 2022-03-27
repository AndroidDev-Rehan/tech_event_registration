import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_event_registration/services/user_db.dart';

import 'package:tech_event_registration/view/pages/root/widgets/eventwidget.dart';
class Events extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.6,
      child: FutureBuilder(
          future: UserDatabase.getevents(),
          builder: (context,AsyncSnapshot<List> kFeatureData) {
            List<Widget> l = [];
            if (kFeatureData.hasData) {
              print('indexxxxxxxxxxxx'+kFeatureData.data!.length.toString());
              return ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, i) {
                  if (i % 2 == 0 && i == kFeatureData.data!.length - 1) {
                    return Column(
                      children: [
                        buildEvent(kFeatureData.data![i]),
                        SizedBox(
                          height: 100,
                        )
                      ],
                    );
                  } else if (i % 2 == 0) {
                    return EventWidget(kFeatureData: kFeatureData.data!, index: i);
                  } else if (i == kFeatureData.data!.length-1)
                    return Container(
                      height: 100,
                    );

                  return Container();
                },
                itemCount: kFeatureData.data!.length,
              );
            }
            return Container();
          }),
    );
  }
}
