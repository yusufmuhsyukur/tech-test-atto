import 'package:flutter/foundation.dart';
import 'package:tech_test_atto/domain/entities/product.dart';
import 'package:tech_test_atto/domain/usecases/get_products.dart';
import 'package:tech_test_atto/utils/state_enum.dart';

class Page1Notifier extends ChangeNotifier {
  final GetProducts getProducts;

  Page1Notifier(this.getProducts);

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  List<Product> _products = [];
  List<Product> get products => _products;

  Map<int, Product> _checkoutMap = <int, Product>{};
  Map<int, Product> get checkoutMap => _checkoutMap;

  String _message = '';
  String get message => _message;

  Future<void> fetchProducts() async {
    _checkoutMap = <int, Product>{};
    _state = RequestState.loading;
    notifyListeners();

    final result = await getProducts.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
        notifyListeners();
      },
      (productsData) {
        _products = productsData;
        _state = RequestState.loaded;
        notifyListeners();
      },
    );
  }

  void addProductQty(int index) {
    _products[index].qty++;

    if (isAddedToCheckoutList(_products[index])) {
      updateCheckoutList(_products[index]);
    } else {
      saveToCheckoutList(_products[index]);
    }
    notifyListeners();
  }

  void subtractProductQty(int index) {
    if (_products[index].qty > 0) {
      _products[index].qty--;

      if (_products[index].qty == 0) {
        removeFromCheckoutList(_products[index]);
      } else {
        updateCheckoutList(_products[index]);
      }
      notifyListeners();
    }
  }

  void saveToCheckoutList(Product product) {
    _checkoutMap[product.id] = product;
  }

  void removeFromCheckoutList(Product product) {
    _checkoutMap.remove(product.id);
  }

  bool isAddedToCheckoutList(Product product) {
    bool result = false;
    if (_checkoutMap[product.id] != null) {
      result = true;
    }
    return result;
  }

  void updateCheckoutList(Product product) {
    _checkoutMap[product.id] = product;
  }

  int totalQtyCheckoutList() {
    int total = 0;
    _checkoutMap.forEach((key, value) {
      total = total + value.qty;
    });
    return total;
  }
}
