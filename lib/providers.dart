import 'package:flutter_riverpod/flutter_riverpod.dart';

// These are the main values of the application, they need to be available everywhere.

final sourceLanguageProvider = StateProvider<String>((ref) {
  String sourceLanguage = '';
  return sourceLanguage;
});

final targetLanguageProvider = StateProvider<String>((ref) {
  String targetLanguage = '';
  return targetLanguage;
});

final inputTextProvider = StateProvider<String>((ref) {
  String inputText = '';
  return inputText;
});

final itemListProvider = StateProvider<List<String>>((ref) {
  return [];
});

final futureItemListProvider = FutureProvider<List<String>>((ref) async {
  List<String> futureList = ref.watch(itemListProvider);
  return futureList;
});

final translatedTextProvider = FutureProvider<String>((ref) {
  String translatedText = '';
  return translatedText;
});