import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';
import 'package:tech_event_registration/services/user_db.dart';

import 'listwidget.dart';

class Feature extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: FutureBuilder(
          future: UserDatabase.getfeature(),
          builder: (context,AsyncSnapshot<List> kFeatureData) {

            List<Widget> l=[];
            if(kFeatureData.hasData)
            {print(kFeatureData.data![0]);
              for (int i = 0; i < kFeatureData.data!.length; i++) {
                l.add(ListViews(kFeatureData:kFeatureData.data![0], index: i));
              }
              return CarouselSlider(
                options: CarouselOptions( autoPlay: true,
                  autoPlayInterval: Duration(seconds: 6),
                  autoPlayAnimationDuration: Duration(seconds: 1),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  height: 240.0,
                  enlargeCenterPage: true,
                  viewportFraction: 0.7,
                  aspectRatio: 8.0,
                  initialPage: 0,),
                items: l,
              );
            }
            return Shimmer.fromColors(direction: ShimmerDirection.ltr,
              baseColor: Colors.grey.shade400,
              highlightColor: Colors.white,
              period: Duration(microseconds: 1000),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, __) => Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(height: 60,width: 250,decoration: BoxDecoration(borderRadius:BorderRadius.all(Radius.circular(10)) ,color: Colors.white),)
                ),
                itemCount: 6,
              ),
            );



          }),
    );
  }
}
