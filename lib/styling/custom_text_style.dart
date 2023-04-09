import 'package:flutter/material.dart';

class CustomTextStyle extends StatelessWidget {
  CustomTextStyle({Key? key, required this.text}) : super(key: key);

  String text;

  @override
  Widget build(BuildContext context) {
    return Text(
        text,
      style: TextStyle(
        color: Colors.grey.shade700,
        fontSize: 16,
        fontFamily: 'Open Sans',
      ),
    );
  }
}