import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ecommerce_app/models/product.dart'; // Import the Product model

class ProductRepository {
  // Function to fetch products from the API
  Future<List<Product>> fetchProducts() async {
    final response =
        await http.get(Uri.parse('https://dummyjson.com/products'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<Product> products = (data['products'] as List)
          .map((productJson) => Product.fromJson(productJson))
          .toList();
      return products;
    } else {
      throw Exception('Failed to load products');
    }
  }
}
