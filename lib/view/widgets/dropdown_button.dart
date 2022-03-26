import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tech_event_registration/controllers/auth_controller.dart';

String? categorySelectedValue = null;


class MyDropDownButton extends StatefulWidget {

  String dropdownValue;
  final List<String> items;

  MyDropDownButton({Key? key, required this.dropdownValue, required this.items}) : super(key: key);

  @override
  State<MyDropDownButton> createState() => _MyDropDownButtonState();
}

class _MyDropDownButtonState extends State<MyDropDownButton> {
  // String dropdownValue = widget.dropdownValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      isExpanded: true,
      value: widget.dropdownValue,
      dropdownColor: Colors.white,
      icon:  Icon(
        Icons.keyboard_arrow_down_sharp,
        color: Colors.black.withOpacity(0.6),
      ),
      // elevation: 16,
      // style: const TextStyle(color: Colors.deepPurple),
      underline: const SizedBox(
        height: 0,
        width: 0,
      ),
      onChanged: (String? newValue) {
        setState(() {
          AuthController controller = Get.find();
          if(widget.items[0] == "Select Role") {
            controller.selectedRole!.value = newValue!;
            categorySelectedValue = newValue;
          }
          else if (widget.items[0] == "Select Age") {
            controller.age = newValue;
          }
          else if (widget.items[0] == "Select Degree") {
            controller.degree = newValue;

          }

          widget.dropdownValue = newValue!;
        });
      },
      items: widget.items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: TextStyle(color: Colors.black.withOpacity(0.6)),
          ),
        );
      }).toList(),
    );
  }
}
