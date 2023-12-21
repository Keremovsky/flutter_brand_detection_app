import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';

class ApiService {
  final Client _client;
  final String _mainUrl = "http://10.0.2.2:8000/";

  ApiService() : _client = http.Client();

  Future<Response> get(String view) async {
    final url = Uri.parse(_mainUrl + view);
    // send get request
    final response = await _client.get(url);

    return response;
  }

  Future<void> post(
    String view,
    Map<String, String> headers,
    String? imagePath,
  ) async {
    final url = Uri.parse(_mainUrl + view);
    final request = http.MultipartRequest("POST", url);

    if (imagePath != null) {
      // get image as MultipartFile
      final multiPartFile = await http.MultipartFile.fromPath(
        "image",
        imagePath,
        contentType: MediaType("image", "png"),
      );
      // add file to request
      request.files.add(multiPartFile);
    }
    // add all other headers
    request.fields.addAll(headers);

    // send request
    await request.send();
  }

  Future<Response> delete(String view) async {
    final url = Uri.parse(_mainUrl + view);
    // send delete request
    final response = await _client.delete(url);

    return response;
  }
}
