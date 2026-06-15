import 'dart:convert';
import 'package:flutter/services.dart';

class MenuService {
  static Future<List<dynamic>> loadMenu() async {
    String jsonString =
        await rootBundle.loadString(
          'assets/data/menu.json',
        );

    return jsonDecode(jsonString);
  }
}