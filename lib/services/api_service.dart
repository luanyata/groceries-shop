import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://localhost:3000/api';

  // Singleton pattern para garantir uma única instância
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  // GET - Buscar todos os itens da loja
  Future<List<dynamic>> getShopItems() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/shop-items'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['data'] ?? [];
      } else {
        throw Exception('Failed to load shop items: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching shop items: $e');
    }
  }

  // GET - Buscar itens do carrinho
  Future<List<dynamic>> getCartItems() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/cart'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['data'] ?? [];
      } else {
        throw Exception('Failed to load cart items: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching cart items: $e');
    }
  }

  // POST - Adicionar item ao carrinho
  Future<bool> addItemToCart(int itemId) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/cart'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'itemId': itemId}),
      );

      return response.statusCode == 201;
    } catch (e) {
      throw Exception('Error adding item to cart: $e');
    }
  }

  // DELETE - Remover item do carrinho
  Future<bool> removeItemFromCart(int cartId) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/cart/$cartId'),
        headers: {'Content-Type': 'application/json'},
      );

      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Error removing item from cart: $e');
    }
  }

  // DELETE - Limpar carrinho
  Future<bool> clearCart() async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/cart'),
        headers: {'Content-Type': 'application/json'},
      );

      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Error clearing cart: $e');
    }
  }
}
