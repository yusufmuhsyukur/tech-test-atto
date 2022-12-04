import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tech_test_atto/domain/usecases/get_products.dart';

import '../../dummy_data/dummy_products.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetProducts getProducts;
  late MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    getProducts = GetProducts(mockProductRepository);
  });

  test('should get product list from repositories', () async {
    // arrange
    when(mockProductRepository.getProducts())
        .thenAnswer((_) async => Right(testProductList));

    // act
    final result = await getProducts.execute();

    // assert
    expect(result, Right(testProductList));
  });
}
