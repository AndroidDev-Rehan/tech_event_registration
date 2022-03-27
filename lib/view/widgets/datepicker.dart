import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import '../../controllers/addevent.dart';



class DatePickerRow extends StatefulWidget {
  const DatePickerRow({Key? key}) : super(key: key);

  @override
  State<DatePickerRow> createState() => _DatePickerRowState();
}

class _DatePickerRowState extends State<DatePickerRow> {
  AddEventController _controller=Get.put(AddEventController());


  @override
  Widget build(BuildContext context) {
    _controller.date = DateTime.now();
    final format = DateFormat("dd MMMM, yyyy");

    return Padding(
      padding: const EdgeInsets.only(left: 8.0, bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          const Text('Date',
              style: TextStyle(color: Colors.grey, fontSize: 20)),
          SizedBox(height: 10,),
          InkWell(
            onTap: () async{
              DateTime? newDate = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(1980), lastDate: DateTime.now());
              if(newDate!=null ){
                setState(() {
                  _controller.date = newDate;
                });
              }
//              DatePickerDialog(initialDate: DateTime.now(), firstDate: DateTime(1980), lastDate: DateTime.now());
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
                child: Text(format.format(_controller.date!)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
