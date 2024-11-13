import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class RecordService {
  final String apiKey = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  final String apiUrl = "https://my-api.plantnet.org/v2/identify/all";

  Future<Map<String, dynamic>?> identifyPlant(File imageFile) async {

    final url = Uri.parse('$apiUrl?include-related-images=false&no-reject=false&nb-results=10&lang=en&api-key=$apiKey');

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