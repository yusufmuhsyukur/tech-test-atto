import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tech_test_atto/data/models/product_response.dart';

import '../../dummy_data/dummy_products.dart';
import '../../json_reader.dart';

void main() {
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final dynamic jsonList = json.decode(readJson('dummy_data/todos.json'));
      // act
      final ProductResponse result = ProductResponse.fromJson(jsonList);
      // assert
      expect(result, testProductResponse);
    });
  });
}
