import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tech_test_atto/data/models/product_model.dart';
import 'package:tech_test_atto/data/models/product_response.dart';

import '../../json_reader.dart';

void main() {
  const testProduct = ProductModel(
    userId: 1,
    id: 1,
    title: 'title',
    completed: false,
  );

  const testProductResponse = ProductResponse(productList: [testProduct]);

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final dynamic jsonList = json.decode(readJson('dummy_data/todos.json'));
      // act
      final result = ProductResponse.fromJson(jsonList);
      // assert
      expect(result, testProductResponse);
    });
  });
}
