import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';

import 'listwidget.dart';

class Feature extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: FutureBuilder(
          future: DefaultAssetBundle.of(context)
              .loadString('assets/json/feature.json'),
          builder: (context, snapshot) {
            List kFeatureData = json.decode(snapshot.data.toString());
            List<Widget> l=[];
            if(snapshot.hasData)
            {
              for (int i = 0; i < kFeatureData.length; i++) {
                l.add(ListViews(kFeatureData: kFeatureData, index: i));
              }
              return CarouselSlider(
                options: CarouselOptions( autoPlay: true,
                  autoPlayInterval: Duration(seconds: 6),
                  autoPlayAnimationDuration: Duration(seconds: 1),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  height: 400.0,
                  enlargeCenterPage: true,
                  viewportFraction: 0.7,
                  aspectRatio: 2.0,
                  initialPage: 0,),
                items: l,
              );
            }
            return Shimmer.fromColors(direction: ShimmerDirection.ltr,
              baseColor: Colors.grey.shade400,
              highlightColor: Colors.white,
              period: Duration(microseconds: 500),
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
