import 'package:flutter/material.dart';

class ListViews extends StatelessWidget {
  ListViews({Key? key, required this.kFeatureData, required this.index})
      : super(key: key);
  final kFeatureData;
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
              '' + kFeatureData[index]['image'],
              height: 140.0,
              width: MediaQuery.of(context).size.width / 1.4,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            width: MediaQuery.of(context).size.width / 1.4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 10, left: 20),
                  child: Text(
                    '' + kFeatureData[index]['price'],
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Semibold',
                        fontSize: 13),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 2, left: 20, bottom: 10),
                  child: Text(
                    '' + kFeatureData[index]['location'],
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 10,
                        fontFamily: 'Regular'),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: Text(
                              '' + kFeatureData[index]['bedroom'],
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Semibold'),
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: Text(
                              '' + kFeatureData[index]['bathroom'],
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Semibold'),
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: Text(
                              '' + kFeatureData[index]['area'],
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Semibold'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
