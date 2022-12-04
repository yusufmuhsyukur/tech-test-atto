import 'package:flutter/material.dart';
import 'package:tech_test_atto/domain/entities/product.dart';
import 'package:tech_test_atto/utils/state_enum.dart';

class Page2Notifier extends ChangeNotifier {
  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  List<Product> _checkoutList = [];
  List<Product> get checkoutList => _checkoutList;

  final String _message = '';
  String get message => _message;

  Future<void> setChekoutList(List<Product> checkoutList) async {
    _state = RequestState.loading;
    notifyListeners();
    _checkoutList = checkoutList;

    await Future.delayed(Duration.zero);
    _state = RequestState.loaded;
    notifyListeners();
  }

  int totalQtyCheckoutList() {
    int total = 0;
    for (var value in _checkoutList) {
      total = total + value.qty;
    }
    return total;
  }
}
