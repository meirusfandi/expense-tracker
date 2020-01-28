import 'package:http/http.dart' as http;
import 'dart:convert';

class CityService {
  static String cityUrl = "https://my-json-server.typicode.com/meirusfandi/api-json/cities";
  static Future<List<dynamic>> getCities() async {
    try {
      final response = await http.get(cityUrl);
      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        return result;
      } else {
        print("Failed to load cities");
      }
    } catch (e) {
      print(e.toString());
    }
  }
}