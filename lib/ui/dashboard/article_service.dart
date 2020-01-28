import 'package:http/http.dart' as http;
import 'dart:convert';

class ArticleService {
  static String articleUrl = "https://my-json-server.typicode.com/meirusfandi/api-json/articles";
  static Future<List<dynamic>> getArticles() async {
    try {
      final response = await http.get(articleUrl);
      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        return result;
      } else {
        print("Failed to load articles");
      }
    } catch (e) {
      print(e.toString());
    }
  }
}