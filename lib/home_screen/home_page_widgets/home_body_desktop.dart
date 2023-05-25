import 'package:flutter/material.dart';
import 'package:language_translation_app/home_screen/home_page_widgets/translation_button.dart';
import 'package:language_translation_app/home_screen/language_box_widgets/text_box_input.dart';
import 'package:language_translation_app/home_screen/language_box_widgets/text_box_translated.dart';
import '../../helper_classes/text_translation_service.dart';
import '../language_selection_widgets/language_selection_row.dart';

class LanguageTranslationBodyDesktop extends StatefulWidget {
  const LanguageTranslationBodyDesktop({Key? key}) : super(key: key);

  @override
  State<LanguageTranslationBodyDesktop> createState() =>
      _LanguageTranslationBodyDesktopState();
}

class _LanguageTranslationBodyDesktopState extends State<LanguageTranslationBodyDesktop> {

  final TextTranslationService _textTranslationService = TextTranslationService();
  final TextEditingController _languageController = TextEditingController();
  Future<String> _translatedText = Future.value('Awaiting translation...');
  String _inputText = '';
  String _sourceLanguage = '';
  String _targetLanguage = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _languageController.dispose();
  }

  void _controllerCallBack(String text) {
    text = _languageController.text;
    setState(() {
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
      _translatedText = _textTranslationService.translateLanguage(
          _sourceLanguage, _targetLanguage, _inputText);
    });
    return _translatedText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        LanguageSelectionRow(
          onSourceLanguageChanged: _onSourceLanguageChanged,
          onTargetLanguageChanged: _onTargetLanguageChanged,
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  flex: 7,
                  child: InputBox(
                      controller: _languageController,
                      function: _controllerCallBack)),
              const Expanded(flex: 1, child: SizedBox()),
              Expanded(
                  flex: 7,
                  child: TranslatedBox(translatedText: _translatedText)),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TranslationButton(translateLanguage: _translateText),
          ],
        ),
      ],
    );
  }
}
