import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class ApiService {
  static const String baseUrl =
      'https://crud-api-ostad-live.onrender.com/api/v1';

  // GET: sob product ana
  Future<List<Product>> getProducts() async {
    final response = await http
        .get(Uri.parse('$baseUrl/ReadProduct'))
        .timeout(const Duration(seconds: 90)); // Render server jaagte shomoy lage

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final List list = body['data'];
      return list.map((item) => Product.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load products (${response.statusCode})');
    }
  }

  // DELETE: product muche fela (ei API te GET use hoy)
  Future<void> deleteProduct(String id) async {
    final response = await http
        .get(Uri.parse('$baseUrl/DeleteProduct/$id'))
        .timeout(const Duration(seconds: 90));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete (${response.statusCode})');
    }
  }

  // POST: notun product banano
  Future<void> createProduct(Product product) async {
    final response = await http
        .post(
          Uri.parse('$baseUrl/CreateProduct'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(product.toJson()),
        )
        .timeout(const Duration(seconds: 90));

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to create (${response.statusCode})');
    }
  }
}