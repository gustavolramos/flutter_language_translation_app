import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants_and_headers.dart';

class TextTranslationService {

Future<List<Map<String, String>>> getLanguages() async {
  final response = await http.get(Uri.parse(getURL), headers: getHeader);
  if (response.statusCode == 200) {
    final jsonResponse = response.body;
    final responseBody = json.decode(jsonResponse);
    final languages = List<Map<String, dynamic>>.from(responseBody['data']['languages']);
    final languageList = languages.map<Map<String, String>>((language) {
      return {
        'name': language['name'].toString(),
        'code': language['code'].toString(),
      };
    }).toList();
    return languageList;
  } else {
    throw Exception('Failed to get languages with status: ${response.statusCode}');
  }
}

  Future<String> translateLanguage(String sourceLanguage, String targetLanguage, String text) async {
    
    var url = translateURL;
    var headers = translateHeader;
    var body = {'source_language': sourceLanguage, 'target_language': targetLanguage, 'text': text};
    var response = await http.post(Uri.parse(url), headers: headers, body: body);

    if (response.statusCode == 200) {
      final String jsonResponse = response.body;
      final responseBody = json.decode(jsonResponse);
      return responseBody['data']['translatedText'];
    } else {
      throw Exception('Failed to translate language with status: ${response.statusCode}');
    }
  }
}