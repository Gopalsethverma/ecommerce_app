import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String apiUrl = "https://dummyjson.com/products";

  static Future<List<dynamic>> fetchProducts(int page) async {
    final response = await http.get(Uri.parse('$apiUrl?page=$page'));

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      return json['products'];
    } else {
      throw Exception('Failed to load products');
    }
  }
}
