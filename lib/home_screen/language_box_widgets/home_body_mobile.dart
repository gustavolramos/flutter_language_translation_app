import 'package:flutter/material.dart';
import 'package:riverpod_language_translate/api_requests/text_translation_service.dart';
import '../language_selection_widgets/language_selection_row_mobile.dart';

class LanguageTranslationBodyMobile extends StatefulWidget {
  const LanguageTranslationBodyMobile({Key? key}) : super(key: key);

  @override
  State<LanguageTranslationBodyMobile> createState() => _LanguageTranslationBodyMobileState();
}

class _LanguageTranslationBodyMobileState extends State<LanguageTranslationBodyMobile> {

  final TextTranslationService _textTranslationMethods = TextTranslationService();
  late String _inputText;
  Future<String> _translatedText = Future.value('Awaiting translation...');
  String _sourceLanguage = '';
  String _targetLanguage = '';
  final TextEditingController _languageController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _languageController.dispose();
  }

  void _controllerCallBack(String text) {
    setState(() {
      text = _languageController.text;
      _inputText = text;
    });
  }

  void _onSourceLanguageChanged(String value) {
    setState(() {
      _sourceLanguage = value;
    });
  }

  void _onTargetLanguageChanged(String value) {
    setState(() {
      _targetLanguage = value;
    });
  }

  Future<String> _translateText() async {
    setState(() {
      _translatedText = _textTranslationMethods.translateLanguage(_inputText, _targetLanguage, _sourceLanguage);
    });
    return _translatedText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    mainAxisSize: MainAxisSize.max,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      const SizedBox(height: 20),
      Expanded(
        child: LanguageSelectionRowMobile(
          onSourceLanguageChanged: _onSourceLanguageChanged,
          onTargetLanguageChanged: _onTargetLanguageChanged,
        ),
      ),
      const SizedBox(height: 20),
      Expanded(
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: TextField(
            controller: _languageController,
            textAlign: TextAlign.start,
            onSubmitted: _controllerCallBack,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(vertical: 100),
              hintText: 'Digite seu texto aqui',
            ),
          ),
        ),
      ),
      Expanded(
        flex: 1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () => _translateText(),
                child: const Text('Translate'))
          ],
        ),
      ),
      Expanded(
        flex: 3,
        child: Container(
          height: 200,
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: FutureBuilder<String>(
                    future: _translatedText,
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      if (snapshot.hasData) {
                        return Text(snapshot.data!);
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return const Text('Waiting for input text');
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    ],
      );
  }
}