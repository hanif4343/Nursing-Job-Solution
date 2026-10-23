import 'package:flutter/foundation.dart';
import 'models.dart';

/// কার্টের অবস্থা (সব স্ক্রিনে একই কার্ট)
class CartController extends ChangeNotifier {
  CartController._();
  static final CartController instance = CartController._();

  final Map<String, CartItem> _items = {};

  List<CartItem> get items => _items.values.toList();
  bool get isEmpty => _items.isEmpty;
  int get count => _items.values.fold(0, (s, e) => s + e.qty);
  int get subtotal => _items.values.fold(0, (s, e) => s + e.total);
  int qtyOf(Book b) => _items[b.id]?.qty ?? 0;

  void add(Book b) {
    final existing = _items[b.id];
    if (existing != null) {
      existing.qty++;
    } else {
      _items[b.id] = CartItem(b, 1);
    }
    notifyListeners();
  }

  void decrease(Book b) {
    final existing = _items[b.id];
    if (existing == null) return;
    if (existing.qty > 1) {
      existing.qty--;
    } else {
      _items.remove(b.id);
    }
    notifyListeners();
  }

  void remove(Book b) {
    _items.remove(b.id);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
