import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tech_test_atto/data/datasources/product_remote_data_source.dart';
import 'package:http/http.dart' as http;
import 'package:tech_test_atto/data/models/product_model.dart';
import 'package:tech_test_atto/data/models/product_response.dart';
import 'package:tech_test_atto/utils/exception.dart';

import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  const baseUrl = 'https://jsonplaceholder.typicode.com';
  late ProductRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = ProductRemoteDataSourceImpl(
      client: mockHttpClient,
      baseUrl: baseUrl,
    );
  });

  group('get products', () {
    final List<ProductModel> testProducts =
        ProductResponse.fromJson(json.decode(readJson('dummy_data/todos.json')))
            .productList;

    test('should return list of Product Model when response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/todos'))).thenAnswer(
          (_) async => http.Response(readJson('dummy_data/todos.json'), 200));
      // act
      final result = await dataSource.getProducts();
      // assert
      expect(result, equals(testProducts));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/todos')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getProducts();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
