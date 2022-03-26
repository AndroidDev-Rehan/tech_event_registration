import 'package:flutter/material.dart';

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
      underline: SizedBox(
        height: 0,
        width: 0,
      ),
      onChanged: (String? newValue) {
        setState(() {
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
