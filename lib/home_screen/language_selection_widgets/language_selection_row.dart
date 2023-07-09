import 'package:flutter/material.dart';
import 'package:language_translation_app/home_screen/language_selection_widgets/drop_down_button.dart';
import '../../helper_classes/text_translation_service.dart';

class LanguageSelectionRow extends StatefulWidget {
  const LanguageSelectionRow({
    Key? key,
    required this.onSourceLanguageChanged,
    required this.onTargetLanguageChanged,
  }) : super(key: key);

  final Function(String) onSourceLanguageChanged;
  final Function(String) onTargetLanguageChanged;

  @override
  LanguageSelectionRowState createState() => LanguageSelectionRowState();
}

class LanguageSelectionRowState extends State<LanguageSelectionRow> {
  List<String> _items = [];
  String _sourceDropDownValue = '';
  String _targetDropDownValue = '';
  final TextTranslationService _textTranslationMethods = TextTranslationService();

  @override
  void initState() {
    super.initState();
    _initializeDropDownButtons();
  }

  Future<void> _initializeDropDownButtons() async {
    final languages = await _textTranslationMethods.getLanguages();
    setState(() {
      _items = languages.map((language) => language['name'] as String).toList();
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
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  _buildDropDownButton(_sourceDropDownValue, _sourceDropDownCallBack),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.compare_arrows),
                onPressed: _switchLanguages,
                color: Colors.blue,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  _buildDropDownButton(_targetDropDownValue, _targetDropDownCallBack),
                ],
              ),
            ],
          );
        } else {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: [
              _buildDropDownButton(_sourceDropDownValue, _sourceDropDownCallBack),
              IconButton(
                icon: const Icon(Icons.compare_arrows),
                onPressed: _switchLanguages,
                color: Colors.blue,
              ),
              _buildDropDownButton(_targetDropDownValue, _targetDropDownCallBack),
            ],
          );
        }
      },
    );
  }

  Widget _buildDropDownButton(String value, ValueChanged<String?> onChanged) {
    return _items.isEmpty
        ? const CircularProgressIndicator()
        : LanguageDropDownButton(
            items: _items,
            dropDownValue: value,
            dropDownCallBack: onChanged,
          );
  }
}