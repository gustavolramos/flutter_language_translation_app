import 'package:flutter/material.dart';

class LanguageDropDownButton extends StatelessWidget {
  const LanguageDropDownButton({
    Key? key,
    required this.items,
    required this.dropDownValue,
    required this.dropDownCallBack
  }) : super(key: key);

  final List<String> items;
  final String dropDownValue;
  final Function(String?) dropDownCallBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(color: Colors.blueGrey),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: dropDownValue,
          onChanged: dropDownCallBack,
          items: items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}