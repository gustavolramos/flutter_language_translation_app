import 'package:flutter/material.dart';
import 'package:riverpod_language_translate/api_requests/text_translation_service.dart';

import 'drop_down_button.dart';

class LanguageSelectionRowMobile extends StatefulWidget {
  const LanguageSelectionRowMobile({
    Key? key,
    required this.onSourceLanguageChanged,
    required this.onTargetLanguageChanged,
  }) : super(key: key);

  final Function(String) onSourceLanguageChanged;
  final Function(String) onTargetLanguageChanged;

  @override
  State<LanguageSelectionRowMobile> createState() => _LanguageSelectionRowMobileState();
}

class _LanguageSelectionRowMobileState extends State<LanguageSelectionRowMobile> {

  List<String> _items = [];
  String _sourceDropDownValue = '';
  String _targetDropDownValue = '';
  TextTranslationService textTranslationMethods = TextTranslationService();

  @override
  void initState() {
    super.initState();
    _initializeDropDownButtons();
  }

  Future<void> _initializeDropDownButtons() async {
    final languages = await textTranslationMethods.getLanguage();
    setState(() {
      _items = languages;
      _sourceDropDownValue = _items.first;
      _targetDropDownValue = _items.first;
    });
  }

  void _sourceDropDownCallBack(String? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        _sourceDropDownValue = selectedValue;
      });
      widget.onSourceLanguageChanged(selectedValue);
    }
  }

  void _targetDropDownCallBack(String? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        _targetDropDownValue = selectedValue;
      });
      widget.onTargetLanguageChanged(selectedValue);
    }
  }

  void _switchLanguages() {
    setState(() {
      String temporary = _sourceDropDownValue;
      _sourceDropDownValue = _targetDropDownValue;
      _targetDropDownValue = temporary;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.max,
      children: [
        _items.isEmpty
            ? const CircularProgressIndicator()
            : LanguageDropDownButton(items: _items, dropDownValue: _sourceDropDownValue, dropDownCallBack: _sourceDropDownCallBack),
        IconButton(
          icon: const Icon(Icons.compare_arrows),
          onPressed: _switchLanguages,
          color: Colors.blue,
        ),
        _items.isEmpty
            ? const CircularProgressIndicator()
            : LanguageDropDownButton(items: _items, dropDownValue: _targetDropDownValue, dropDownCallBack: _targetDropDownCallBack),
      ],
    );
  }
}