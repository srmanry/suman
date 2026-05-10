import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../home/domain/entities/product.dart';
import '../../domain/entities/cart_item.dart';

class CartController extends GetxController {
  final items = <CartItem>[].obs;

  void add(Product product) {
    _increase(product);

    Get.snackbar(
      'কার্টে যোগ হয়েছে',
      product.title,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(12),
    );
  }

  void increase(Product product) {
    _increase(product);
  }

  void _increase(Product product) {
    final existingIndex = items.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (existingIndex == -1) {
      items.add(CartItem(product: product, quantity: 1));
    } else {
      final existing = items[existingIndex];
      items[existingIndex] = existing.copyWith(quantity: existing.quantity + 1);
    }
  }

  void decrease(String productId) {
    final index = items.indexWhere((item) => item.product.id == productId);
    if (index == -1) {
      return;
    }

    final item = items[index];
    if (item.quantity <= 1) {
      items.removeAt(index);
      return;
    }

    items[index] = item.copyWith(quantity: item.quantity - 1);
  }

  int get itemCount {
    return items.fold<int>(0, (sum, item) => sum + item.quantity);
  }

  double get totalPrice {
    return items.fold<double>(
      0,
      (sum, item) => sum + (item.product.price * item.quantity),
    );
  }
}
