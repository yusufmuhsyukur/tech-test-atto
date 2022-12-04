import 'package:flutter_test/flutter_test.dart';
import 'package:tech_test_atto/domain/entities/product.dart';
import 'package:tech_test_atto/presentation/provider/page2_notifier.dart';
import 'package:tech_test_atto/utils/state_enum.dart';

import '../../dummy_data/dummy_products.dart' as dummy;

void main() {
  late Page2Notifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    notifier = Page2Notifier()
      ..addListener(() {
        listenerCallCount++;
      });
  });

  group('load data', () {
    test('should change state to loading when set data', () async {
      // arrange
      List<Product> testProductList = dummy.testProductList;

      // act
      notifier.setChekoutList(testProductList);
      // assert
      expect(notifier.state, RequestState.loading);
      expect(listenerCallCount, 1);
    });

    test('should change products data when data is set successfully', () async {
      // arrange
      List<Product> testProductList = dummy.testProductList;

      // act
      await notifier.setChekoutList(testProductList);
      // assert
      expect(notifier.state, RequestState.loaded);
      expect(notifier.checkoutList, testProductList);
      expect(listenerCallCount, 2);
    });
  });
}
