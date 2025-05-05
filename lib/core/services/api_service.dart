import 'dart:convert';
import 'package:http/http.dart' as http;

enum RequestType { get, post, put, patch, delete }

class ApiService {
  final String baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<dynamic> request({
    required String endpoint,
    required RequestType requestType,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    final uri = Uri.parse('$baseUrl$endpoint').replace(
      queryParameters: queryParameters,
    );

    final Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      ...?headers,
    };

    http.Response response;

    try {
      switch (requestType) {
        case RequestType.get:
          response = await http.get(uri, headers: requestHeaders);
          break;
        case RequestType.post:
          response = await http.post(
            uri,
            headers: requestHeaders,
            body: jsonEncode(body),
          );
          break;
        case RequestType.put:
          response = await http.put(
            uri,
            headers: requestHeaders,
            body: jsonEncode(body),
          );
          break;
        case RequestType.patch:
          response = await http.patch(
            uri,
            headers: requestHeaders,
            body: jsonEncode(body),
          );
          break;
        case RequestType.delete:
          response = await http.delete(uri, headers: requestHeaders);
          break;
      }

      return _handleResponse(response);
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) return true;
      return jsonDecode(response.body);
    } else {
      throw Exception('API Error: Status Code ${response.statusCode}');
    }
  }
}
