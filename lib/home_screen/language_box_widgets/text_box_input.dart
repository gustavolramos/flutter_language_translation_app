import 'package:flutter/material.dart';

class InputBox extends StatelessWidget {
  const InputBox({Key? key, required this.controller, required this.function}) : super(key: key);

  final TextEditingController controller;
  final Function(String) function;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      textAlign: TextAlign.start,
      onSubmitted: function,
      textAlignVertical: TextAlignVertical.top,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Digite seu texto aqui',
        contentPadding: EdgeInsets.symmetric(vertical: 100),
      ),
    );
  }
}
