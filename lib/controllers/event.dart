import 'package:get/get.dart';

import '../models/events.dart';

class EventController extends GetxController{
  Events selectedevent=Events(description: 'fghj',endtime: 'dddd',Image: 'dddd',starttime: 'ssss',title: 'hhhh',venue: 'ghjkl',stall: '10',price: '10',agecriteria: '0000',educriteria: '0000');
setevent(Events data){selectedevent=data;
update();}
}