import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ChatService {
  Future<String?> chat(
      String message,
      List<Map<String, String>> messages,
      String context
      ) async{
    // Getting environment variables
    String? apiKey = dotenv.env['HUGGING_FACE_API_KEY'];
    String? endpoint = dotenv.env['HUGGING_FACE_ENDPOINT'];
    String? model = dotenv.env['HUGGING_FACE_MODEL'];
    String? initialPrompt = dotenv.env['HUGGING_FACE_INITIAL_PROMPT'];
    //print(context);
    if (apiKey == null || endpoint == null || model == null || initialPrompt == null) {
      print("Error: No se encontraron las variables de entorno necesarias.");
      return null;
    }
    initialPrompt += '\n$context';
    initialPrompt += "\nSi la pregunta no está relacionada con el contexto, solo responde con 'No puedo responder a esto. Por favor, haz otra pregunta.'";

    // Default config
    final url = Uri.parse(endpoint);

    // Building the messages
    List<Map<String, String>> chatMessages = [
      if (initialPrompt.isNotEmpty)
        {'role': 'system', 'content': initialPrompt},
      ...messages.map((e) => {'role': e['sender']!, 'content': e['text']!}),
      {'role': 'user', 'content': message},
    ];
    print (chatMessages[1]);
    print (chatMessages[2]);
    // Request body
    final body = jsonEncode({
      'model': model,
      'messages': chatMessages,
      'max_tokens': 512,
      'stream': false,
    });

    // Configuring the headers
    final headers = {
      'Authorization': 'Bearer $apiKey',
      'Content-Type': 'application/json',
    };

    try {
      // Sending the request
      final response = await http.post(url, headers: headers, body: body);

      // Handling the response
      if (response.statusCode == 200) {
        final decodedBody = utf8.decode(response.bodyBytes);
        final jsonResponse = jsonDecode(decodedBody);
        String content = jsonResponse['choices'][0]['message']['content'];
        return content;
      } else {
        print("Error en la respuesta: ${response.statusCode}");
        print("Cuerpo de respuesta: ${response.body}");
        return null;
      }
    } catch (e) {
      print("Error al realizar la solicitud: $e");
      return null;
    }
  }
}

class Pair<F, S> {
  final F first;
  final S second;

  Pair(this.first, this.second);
}