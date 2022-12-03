import 'package:flutter_test/flutter_test.dart';
import 'package:tech_test_atto/domain/entities/product.dart';
import '../../dummy_data/dummy_products.dart';

void main() {
  test('should be a subclass of Product entity', () async {
    final Product result = testProductModel.toEntity();
    expect(result, testProduct);
  });
}
