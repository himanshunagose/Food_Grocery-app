import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class SeedLoader {
  Future<List<dynamic>> loadJsonList(String assetPath) async {
    final data = await rootBundle.loadString(assetPath);
    return jsonDecode(data) as List<dynamic>;
  }

  Future<Map<String, dynamic>> loadJsonMap(String assetPath) async {
    final data = await rootBundle.loadString(assetPath);
    return jsonDecode(data) as Map<String, dynamic>;
  }
}

