import 'package:flutter/material.dart';
import 'package:riverpod_language_translate/styling/custom_text_style.dart';
import 'package:riverpod_language_translate/api_requests/text_translation_service.dart';
import 'package:riverpod_language_translate/home_screen/language_selection_widgets/language_selection_row_desktop.dart';

class LanguageTranslationBodyDesktop extends StatefulWidget {
  const LanguageTranslationBodyDesktop({Key? key}) : super(key: key);

  @override
  State<LanguageTranslationBodyDesktop> createState() => _LanguageTranslationBodyDesktopState();
}

class _LanguageTranslationBodyDesktopState extends State<LanguageTranslationBodyDesktop> {

  final TextTranslationService _textTranslationService = TextTranslationService();
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
      _translatedText = _textTranslationService.translateLanguage(_inputText, _targetLanguage, _sourceLanguage);
    });
    return _translatedText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        LanguageSelectionRowDesktop(
          onSourceLanguageChanged: _onSourceLanguageChanged,
          onTargetLanguageChanged: _onTargetLanguageChanged,
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 7,
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
              const Expanded(
                  flex: 1,
                  child: SizedBox()
              ),
              Expanded(
                flex: 7,
                child: Container(
                  height: 215,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: FutureBuilder<String>(
                      future: _translatedText,
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
                ),
              )
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () => _translateText(),
                child: const Text('Translate'))
          ],
        ),
      ],
    );
  }
}