import 'package:flutter/material.dart';

class DropDownButton extends StatefulWidget {
  String? dropdownValue;
  String? hintText = 'Hint';
  List<String> itemsList = ['L', 'XL', 'XXL', 'XXXL'];
  DropDownButton(
      {required this.dropdownValue,
      required this.itemsList,
      required this.hintText});

  @override
  State<DropDownButton> createState() => _DropDownButtonState();
}

class _DropDownButtonState extends State<DropDownButton> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      hint: Text(
        '${widget.hintText}',
        style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
        textAlign: TextAlign.start,
      ),
      value: widget.dropdownValue,
      icon: const Icon(Icons.arrow_drop_down_outlined),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      onChanged: (String? newValue) {
        setState(
          () {
            widget.dropdownValue = newValue!;
          },
        );
      },
      items: widget.itemsList.map<DropdownMenuItem<String>>(
        (String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        },
      ).toList(),
    );
  }
}
