import 'dart:convert';

import 'package:http/http.dart' as http;

/// Exception thrown when coffee random fails.
class CoffeeRequestFailure implements Exception {}

/// Exception thrown when coffee is not found.
class CoffeeNotFoundFailure implements Exception {}

/// Dart API Client which wraps the [Coffee API](https://coffee.alexflipnote.dev).
class CoffeeApiClient {
  /// Constructor
  CoffeeApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  static const _baseUrl = 'coffee.alexflipnote.dev';
  final http.Client _httpClient;

  /// Finds a [String] `/random.json`.
  Future<String> getRandomCoffee() async {
    final coffeeRequest = Uri.https(
      _baseUrl,
      '/random.json',
    );

    final coffeeResponse = await _httpClient.get(coffeeRequest);

    if (coffeeResponse.statusCode != 200) {
      throw CoffeeRequestFailure();
    }

    final coffeeJson = jsonDecode(coffeeResponse.body) as Map;

    if (!coffeeJson.containsKey('file')) throw CoffeeNotFoundFailure();

    return coffeeJson['file'] as String;
  }
}
