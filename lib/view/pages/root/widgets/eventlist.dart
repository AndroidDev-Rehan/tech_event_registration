import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tech_event_registration/view/pages/root/widgets/eventwidget.dart';
class Events extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.6,
      child: FutureBuilder(
          future: DefaultAssetBundle.of(context)
              .loadString('assets/json/feature.json'),
          builder: (context, snapshot) {
            List kFeatureData = json.decode(snapshot.data.toString());
            List<Widget> l = [];
            if (snapshot.hasData) {
              print(kFeatureData.length);
              return ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, i) {
                  if (i % 2 == 0 && i == kFeatureData.length - 1) {
                    return Column(
                      children: [
                        buildEvent(kFeatureData[i]),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    );
                  } else if (i % 2 == 0) {
                    return EventWidget(kFeatureData: kFeatureData, index: i);
                  } else if (i == kFeatureData.length - 1)
                    return Container(
                      height: 20,
                    );
                  return Container();
                },
                itemCount: kFeatureData.length,
              );
            }
            return Container();
          }),
    );
  }
}
