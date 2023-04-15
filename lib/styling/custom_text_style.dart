import 'package:flutter/material.dart';

class CustomTextStyle extends StatelessWidget {
  const CustomTextStyle({Key? key, required this.text}) : super(key: key);

  final String text;

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