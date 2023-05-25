import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants_and_headers.dart';

class TextTranslationService {

  Future<List<String>> getLanguage() async {

    var url = getURL;
    final headers = getHeader;
    var response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      final String jsonResponse = response.body;
      final responseBody = json.decode(jsonResponse);
      final languages = responseBody['data']['languages'];
      final nameList = List<String>.from(languages.map((language) => language['name']));
      return nameList;
    } else {
      throw Exception('Failed to get languages with status: ${response.statusCode}');
    }
  }

    Future<List<String>> getLanguageCodes() async {

    var url = getURL;
    final headers = getHeader;
    var response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      final String jsonResponse = response.body;
      final responseBody = json.decode(jsonResponse);
      final languages = responseBody['data']['languages'];
      final nameList = List<String>.from(languages.map((language) => language['code']));
      return nameList;
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
      if (responseBody.containsKey('data') && responseBody['data'].containsKey('translatedText')) {
        return responseBody['data']['translatedText'];
      } else {
        throw Exception('Failed to parse translation response');
      }
    } else {
      throw Exception('Failed to translate language with status: ${response.statusCode}');
    }
  }
}