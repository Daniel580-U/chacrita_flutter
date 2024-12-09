import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class RecordService {
  Future<Map<String, dynamic>?> identifyPlant(File imageFile) async {

    // Getting environment variables
    String? apiUrl = dotenv.env['PLANTNET_ENDPOINT'];
    String? apiKey = dotenv.env['PLANTNET_API_KEY'];

    // Default config
    final url = Uri.parse('$apiUrl?include-related-images=false&no-reject=false&nb-results=10&lang=es&api-key=$apiKey');

    // Creating request
    final request = http.MultipartRequest('POST', url)
      ..headers['accept'] = 'application/json'
      ..fields['organs'] = "auto"
      ..files.add(await http.MultipartFile.fromPath(
        'images',
        imageFile.path,
        contentType: MediaType('image', 'jpeg'),
      ));

    // Sending request
    final response = await request.send();

    // Request status
    if (response.statusCode == 200) {
      final body = await response.stream.bytesToString();
      return jsonDecode(body);
    } else {
      print('Error: ${response.statusCode}');
      return null;
    }
  }
}