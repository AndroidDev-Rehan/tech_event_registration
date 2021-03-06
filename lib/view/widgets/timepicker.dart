import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_event_registration/controllers/addevent.dart';


class TimePickerRow extends StatefulWidget {
  final String? title;
  const TimePickerRow({Key? key, this.title}) : super(key: key);

  @override
  State<TimePickerRow> createState() => _TimePickerRowState();
}

class _TimePickerRowState extends State<TimePickerRow> {
  AddEventController _controller=Get.put(AddEventController());


  @override
  Widget build(BuildContext context) {
    _controller.starttime = TimeOfDay.now();
    // final format = TimeOfDayFormat.H_colon_mm;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Time',
            style: TextStyle(color: Colors.grey, fontSize: 20)),
        const SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 16),
          child: InkWell(
            onTap: () async{
              TimeOfDay? newTime = await showTimePicker(context: context, initialTime: TimeOfDay.now());
              if(newTime!=null ){
                setState(() {
                  _controller.starttime = newTime;
                });
              }
            },
            child: Container(
              width: Get.width*0.42,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black.withOpacity(0.8)),
                  borderRadius: BorderRadius.circular(5)
              ),
              child:  Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                child: Text("${_controller.starttime!.hour}:${_controller.starttime!.minute}"),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

