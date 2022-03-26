import 'package:flutter/material.dart';
import 'package:tech_event_registration/models/feature.dart';

class ListViews extends StatelessWidget {
  ListViews({Key? key, required this.kFeatureData, required this.index})
      : super(key: key);
 Feature kFeatureData;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 15,horizontal: 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: new BorderRadius.only(
                topRight: const Radius.circular(5),
                topLeft: const Radius.circular(5)),
            child: Image.network(
              '' + kFeatureData.Image,
              height: 140.0,
              width: MediaQuery.of(context).size.width / 1.4,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            alignment: Alignment.center,

            child: Padding(
              padding: EdgeInsets.only(top: 20,),
              child: Text(
                '' + kFeatureData.title,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,

                    fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
