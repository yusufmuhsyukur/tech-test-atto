import 'package:flutter_test/flutter_test.dart';
import 'package:tech_test_atto/data/models/product_model.dart';
import 'package:tech_test_atto/domain/entities/product.dart';

void main() {
  ProductModel testProductModel = const ProductModel(
    userId: 1,
    id: 1,
    title: "title",
    completed: false,
  );

  Product testProduct = Product(
    id: 1,
    name: 'title',
  );

  test('should be a subclass of Product entity', () async {
    final result = testProductModel.toEntity();
    expect(result, testProduct);
  });
}
