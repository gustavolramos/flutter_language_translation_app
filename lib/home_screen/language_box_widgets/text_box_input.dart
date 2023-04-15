import 'package:flutter/material.dart';

class InputBox extends StatelessWidget {
  const InputBox({Key? key, required this.controller, required this.function}) : super(key: key);

  final TextEditingController controller;
  final Function(String) function;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 215,
      child: TextField(
        controller: controller,
        onSubmitted: function,
        maxLines: null,
        expands: true,
        textAlign: TextAlign.start,
        textAlignVertical: TextAlignVertical.top,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Digite seu texto aqui, com no máximo 500 caracteres',
        ),
      ),
    );
  }
}
