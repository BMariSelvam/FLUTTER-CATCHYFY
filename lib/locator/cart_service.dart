import 'dart:async';

import 'package:Catchyfive/Model/catagroy/ProductModel.dart';
import 'package:get/get.dart';

class CartService {
  List<ProductModel> _cartItems = [];

  void addToCart({required ProductModel product}) {
    // Check if the item is already in the cart
    var existingItem = _cartItems
        .firstWhereOrNull((item) => item.productCode == product.productCode);

    if (existingItem != null) {
      // If item exists, update the quantity
      existingItem.increment();
    } else {
      // If item doesn't exist, add it to the cart
      product.increment();
      _cartItems.add(product);
    }
    // Notify listeners that the cart has changed
    _cartChangeController.add(true);
  }

  void removeFromCart({required ProductModel product}) {
    // Check if the item is already in the cart
    var existingItem = _cartItems
        .firstWhereOrNull((item) => item.productCode == product.productCode);

    if (existingItem != null) {
      // If item exists, update the quantity
      existingItem.decrement();
    }

    if (product.qtycount < 1) {
      _cartItems.removeWhere((item) => item.productCode == product.productCode);
    }
    // Notify listeners that the cart has changed
    _cartChangeController.add(true);
  }

  List<ProductModel> get cartItems => _cartItems;

  final _cartChangeController = StreamController<bool>.broadcast();

  Stream<bool> get cartChangeStream => _cartChangeController.stream;

  void clearCart() {
    _cartItems.clear();
    _cartChangeController.add(true);
  }

  // Dispose the stream controller
  void dispose() {
    _cartChangeController.close();
  }
}
