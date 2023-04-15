import 'package:flutter/material.dart';

class TranslationButton extends StatelessWidget {
  const TranslationButton({
    Key? key,
    required this.translateLanguage,
  }) : super(key: key);

  final Function translateLanguage;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () => translateLanguage(),
        child: const Text('Translate'));
  }
}


