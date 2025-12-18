import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;

class WebClient {
  const WebClient();

  String _parseError(String response) {
    dynamic message = response;

    if (response.contains('DOCTYPE html')) {
      return 'An error occurred';
    }

    try {
      final dynamic jsonResponse = json.decode(response);
      message = jsonResponse['error'] ?? jsonResponse;
      message = message['message'] ?? message;
    } catch (error) {}

    return message.toString();
  }

  Future<dynamic> get(String url) async {
    final http.Response response = await http.Client().get(Uri.parse(url));

    print(response);

    if (response.statusCode >= 400) {
      throw _parseError(response.body);
    }

    final dynamic jsonResponse = json.decode(response.body);

    return jsonResponse;
  }

  Future<dynamic> post(String url, [dynamic data]) async {
    final http.Response response = await http.Client().post(
      Uri.parse(url),
      body: data,
      headers: {
        'Content-Type': 'application/json',
      },
    ).timeout(const Duration(seconds: 10));

    if (response.statusCode >= 400) {
      throw _parseError(response.body);
    }

    try {
      final dynamic jsonResponse = json.decode(response.body);
      return jsonResponse;
    } catch (exception) {
      print(response.body);
      throw 'An error occurred';
    }
  }

  Future<dynamic> put(String url, dynamic data) async {
    final http.Response response = await http.Client().put(
      Uri.parse(url),
      body: data,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode >= 400) {
      throw _parseError(response.body);
    }

    try {
      final dynamic jsonResponse = json.decode(response.body);
      return jsonResponse;
    } catch (exception) {
      throw 'An error occurred';
    }
  }
}
