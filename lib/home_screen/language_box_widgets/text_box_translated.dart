import 'package:flutter/material.dart';
import '../../styling/custom_text_style.dart';

class TranslatedBox extends StatelessWidget {
  const TranslatedBox({Key? key, required this.translatedText}) : super(key: key);

  final Future<String> translatedText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 215,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: FutureBuilder<String>(
          future: translatedText,
          builder:
              (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data!);
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return CustomTextStyle(text: 'Waiting for user input');
            }
          }),
    );
  }
}
