import 'package:flutter/material.dart';
import 'package:language_translation_app/home_screen/home_page_widgets/translation_button.dart';
import '../../helper_classes/text_translation_service.dart';
import '../language_box_widgets/text_box_input.dart';
import '../language_box_widgets/text_box_translated.dart';
import '../language_selection_widgets/language_selection_row.dart';

class LanguageTranslationBodyMobile extends StatefulWidget {
  const LanguageTranslationBodyMobile({super.key});

  @override
  State<StatefulWidget> createState() => _LanguageTranslationBodyMobileState();
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
      _translatedText = _textTranslationMethods
        .translateLanguage(_inputText, _targetLanguage, _sourceLanguage);
    });
    return _translatedText;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(height: 20),
            LanguageSelectionRow(
              onSourceLanguageChanged: _onSourceLanguageChanged,
              onTargetLanguageChanged: _onTargetLanguageChanged,
            ),
            const SizedBox(height: 20),
            Expanded(
              flex: 7,
              child: InputBox(
                controller: _languageController,
                function: _controllerCallBack,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TranslationButton(translateLanguage: _translateText),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
                flex: 7, child: TranslatedBox(translatedText: _translatedText)),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}