// write api for sending a message to the server
// Path: lib/models/send_message.api.dart

import 'dart:convert';
import 'package:http/http.dart' as http;

Future<http.Response> createMessage(String message) {
  return http.post(
    Uri.parse('http://localhost:4000/api/messages'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'message': message,
    }),
  );
}


