import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tech_test_atto/domain/entities/product.dart';
import 'package:tech_test_atto/presentation/provider/page1_notifier.dart';
import 'package:tech_test_atto/utils/failure.dart';
import 'package:tech_test_atto/utils/state_enum.dart';

import '../../dummy_data/dummy_products.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late Page1Notifier notifier;
  late MockGetProducts mockGetProducts;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetProducts = MockGetProducts();
    notifier = Page1Notifier(mockGetProducts)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  group('fetch data', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetProducts.execute())
          .thenAnswer((_) async => Right(testProductList));
      // act
      notifier.fetchProducts();
      // assert
      expect(notifier.state, RequestState.loading);
      expect(listenerCallCount, 1);
    });

    test('should change products data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetProducts.execute())
          .thenAnswer((_) async => Right(testProductList));
      // act
      await notifier.fetchProducts();
      // assert
      expect(notifier.state, RequestState.loaded);
      expect(notifier.products, testProductList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetProducts.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      // act
      await notifier.fetchProducts();
      // assert
      expect(notifier.state, RequestState.error);
      expect(notifier.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('product qty state', () {
    test('should add 1 qty of product when add qty method is called', () async {
      // arrange
      when(mockGetProducts.execute())
          .thenAnswer((_) async => Right(testProductList));
      notifier.checkoutList = {};

      // act
      await notifier.fetchProducts();
      notifier.addProductQty(0);

      // assert
      expect(notifier.products[0].qty, 1);
      expect(listenerCallCount, 3);
    });

    test('should added to checkout list when data is not in checkout list',
        () async {
      // arrange
      when(mockGetProducts.execute())
          .thenAnswer((_) async => Right(testProductList));
      notifier.checkoutList = {};

      // act
      await notifier.fetchProducts();
      notifier.addProductQty(0);

      int productId = notifier.products[0].id;
      bool isAddedToCheckoutList = notifier.checkoutList[productId] != null;

      // assert
      expect(isAddedToCheckoutList, true);
      expect(listenerCallCount, 3);
    });

    test('should update product qty in checkout list', () async {
      // arrange

      final Product testProduct = Product(
        id: 1,
        name: 'title',
      );
      final testProductList = [testProduct];

      when(mockGetProducts.execute())
          .thenAnswer((_) async => Right(testProductList));

      // act
      await notifier.fetchProducts();
      notifier.addProductQty(0);
      notifier.addProductQty(0);

      int productId = notifier.products[0].id;
      bool isAddedToCheckoutList = notifier.checkoutList[productId] != null;
      int productChekcoutQty = notifier.checkoutList[productId]?.qty ?? 0;

      // assert
      expect(isAddedToCheckoutList, true);
      expect(productChekcoutQty, 2);
    });

    test('should subtract 1 qty of product when subtract qty method is called',
        () async {
      // arrange
      final Product testProduct = Product(
        id: 1,
        name: 'title',
      );
      final testProductList = [testProduct];

      when(mockGetProducts.execute())
          .thenAnswer((_) async => Right(testProductList));

      // act
      await notifier.fetchProducts();
      notifier.addProductQty(0);
      notifier.subtractProductQty(0);

      int productQty = notifier.products[0].qty;

      // assert
      expect(productQty, 0);
      expect(listenerCallCount, 4);
    });

    test(
        'should remove from checkout list when qty product is 0 after subtracting its qty',
        () async {
      // arrange
      final Product testProduct = Product(
        id: 1,
        name: 'title',
      );
      final testProductList = [testProduct];
      when(mockGetProducts.execute())
          .thenAnswer((_) async => Right(testProductList));
      notifier.checkoutList = {};

      // act
      await notifier.fetchProducts();
      notifier.addProductQty(0);
      notifier.subtractProductQty(0);

      int productQty = notifier.products[0].qty;
      int productId = notifier.products[0].id;
      bool isAddedToCheckoutList = notifier.checkoutList[productId] != null;

      // assert
      expect(productQty, 0);
      expect(listenerCallCount, 4);
      expect(isAddedToCheckoutList, false);
    });
  });
}
