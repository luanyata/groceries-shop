import 'package:flutter/material.dart';
import 'package:hello/services/api_service.dart';

class CartModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<dynamic> _shopItems = [];
  List<dynamic> _cartItems = [];
  bool _isLoading = false;
  String? _error;

  // Getters
  List<dynamic> get shopItems => _shopItems;
  List<dynamic> get cartItems => _cartItems;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Carregar itens da loja da API
  Future<void> loadShopItems() async {
    _setLoading(true);
    try {
      _shopItems = await _apiService.getShopItems();
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  // Carregar itens do carrinho da API
  Future<void> loadCartItems() async {
    _setLoading(true);
    try {
      _cartItems = await _apiService.getCartItems();
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  // Adicionar item ao carrinho
  Future<void> addToCart(int shopItemIndex) async {
    try {
      final shopItem = _shopItems[shopItemIndex];
      final success = await _apiService.addItemToCart(shopItem['id']);

      if (success) {
        // Recarrega os itens do carrinho para manter sincronia
        await loadCartItems();
      } else {
        _error = 'Failed to add item to cart';
        notifyListeners();
      }
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  // Remover item do carrinho
  Future<void> removeFromCart(int cartItemIndex) async {
    try {
      final cartItem = _cartItems[cartItemIndex];

      // Verifica se cartId existe e não é null
      final cartId = cartItem['cartId'];
      if (cartId == null) {
        _error = 'Cart item ID is missing';
        notifyListeners();
        return;
      }

      final success = await _apiService.removeItemFromCart(cartId);

      if (success) {
        // Remove localmente e depois recarrega para garantir sincronia
        _cartItems.removeAt(cartItemIndex);
        notifyListeners();
        await loadCartItems();
      } else {
        _error = 'Failed to remove item from cart';
        notifyListeners();
      }
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  // Calcular preço total
  double getTotalPrice() {
    return _cartItems.fold(0, (total, item) {
      final priceString = item['itemPrice'];
      if (priceString == null) return total;

      try {
        return total + double.parse(priceString);
      } catch (e) {
        // Se não conseguir fazer parse do preço, ignora este item
        return total;
      }
    });
  }

  // Método helper para obter o preço total como string formatada
  String getTotalPriceString() {
    return getTotalPrice().toStringAsFixed(2);
  }

  // Limpar carrinho
  Future<void> clearCart() async {
    try {
      final success = await _apiService.clearCart();
      if (success) {
        _cartItems.clear();
        notifyListeners();
      }
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  // Método privado para controlar loading
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}
