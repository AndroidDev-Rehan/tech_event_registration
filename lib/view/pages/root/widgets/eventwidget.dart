import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_event_registration/controllers/event.dart';
import 'package:tech_event_registration/models/events.dart';
import 'package:tech_event_registration/utils/const/colors.dart';
import 'package:tech_event_registration/view/pages/root/event_detail_screen.dart';
import 'package:tech_event_registration/view/pages/root/widgets/eventdetailcontroller.dart';

class EventWidget extends StatelessWidget {
  EventWidget({Key? key, required this.kFeatureData, required this.index})
      : super(key: key);
  List kFeatureData;
  final int index;


  @override
  Widget build(BuildContext context) {
print(index);print(index+1);
print(kFeatureData[index]);print(kFeatureData[index+1]);
print('next');

    return Center(
      child: Row(
        children: [
          SizedBox(width: 20,),
          buildEvent(kFeatureData[index])
          ,SizedBox(width: 20,),
          if(kFeatureData[index+1]!=null)
          Column(children: [SizedBox(height: 60,),
            buildEvent(kFeatureData[index+1]),],)
        ],
      ),
    );
  }

}
 buildEvent(Events data){

   EventDetailController _controller=Get.put(EventDetailController());
  return GestureDetector(
    onTap: (){EventController _eventcontroller=Get.put(EventController());
    _eventcontroller.setevent(data);

      _controller.panelController.open();

      },
    child: Card(
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
              '' + data.Image,
              height: Get.height*0.15,
              width:Get.width*0.42,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            decoration: BoxDecoration(gradient: LinearGradient(
              colors: [ColorResources.COLOR_PRIMARY, Color(0x9C6127FF)],
              begin: Alignment.bottomRight,end: Alignment.topLeft,
              stops: [0.1, 0.6],
            ),
                color:ColorResources.COLOR_PRIMARY,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(3),
                    bottomRight: Radius.circular(3))),
            alignment: Alignment.centerLeft,
            width:Get.width*0.42,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 10, left: 20),
                  child: Text(
                    '' + data.title,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Semibold',
                        fontSize: 13),
                  ),
                ),
                SizedBox(height: 5,),
                Padding(
                  padding: EdgeInsets.only( left: 20),
                  child: Text(
                    'At: ' + data.venue,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Semibold',
                        fontSize: 13),
                  ),
                ),
                SizedBox(height: 5,),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
