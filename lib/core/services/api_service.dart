import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';

class ApiService {
  final Client _client;
  final String _mainUrl = "http://10.0.2.2:8000/";

  ApiService() : _client = http.Client();

  Future<Map<String, dynamic>> get(String view) async {
    final url = Uri.parse(_mainUrl + view);
    // send get request
    final response = await _client.get(url);

    return jsonDecode(response.body) as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> post(
    String view, {
    Map<String, String>? headers,
    Uint8List? imageBytes,
  }) async {
    final url = Uri.parse(_mainUrl + view);
    final request = http.MultipartRequest("POST", url);

    if (imageBytes != null) {
      // get image as MultipartFile
      final multiPartFile = http.MultipartFile.fromBytes(
        "image",
        imageBytes,
        filename: "image.png",
        contentType: MediaType("image", "png"),
      );
      // add image to request
      request.files.add(multiPartFile);
    }
    if (headers != null) {
      // add all other headers
      request.fields.addAll(headers);
    }

    // send request
    final streamResponse = await request.send();
    // transform response to response
    final response = await http.Response.fromStream(streamResponse);

    return jsonDecode(response.body) as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> delete(String view) async {
    final url = Uri.parse(_mainUrl + view);
    // send delete request
    final response = await _client.delete(url);

    return jsonDecode(response.body) as Map<String, dynamic>;
  }
}
