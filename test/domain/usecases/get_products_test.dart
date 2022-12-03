import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tech_test_atto/domain/repositories/product_repositories.dart';
import 'package:tech_test_atto/domain/usecases/get_products.dart';
import 'package:mockito/annotations.dart';

import '../../dummy_data/dummy_products.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetProducts getProducts;
  late MockProductRepositories mockProductRepositories;

  setUp(() {
    mockProductRepositories = MockProductRepositories();
    getProducts = GetProducts(mockProductRepositories);
  });

  final products = testProductList;

  test('should get product list from repositories', () async {
    // arrange
    when(mockProductRepositories.getProducts())
        .thenAnswer((_) async => Right(products));

    // act
    final result = await getProducts.execute();

    // assert
    expect(result, Right(products));
  });
}
