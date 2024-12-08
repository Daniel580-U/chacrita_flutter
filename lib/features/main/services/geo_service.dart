import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class GeoService {
  Future<Map<String, dynamic>?> getApiRequest(double lat, double lan, String? apiUrl) async {
    // Getting environment variables
    String? apiKey = dotenv.env['OPEN_WEATHER_API_KEY'];

    // Default config
    final url = Uri.parse('$apiUrl?lat=$lat&lon=$lan&appid=$apiKey');

    // Sending request
    final response = await http.get(url);

    // Request status
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print('Error: ${response.statusCode}');
      return null;
    }
  }
}