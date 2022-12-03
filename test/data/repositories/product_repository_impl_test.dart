import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tech_test_atto/data/repositories/product_respository_impl.dart';
import 'package:tech_test_atto/utils/exception.dart';
import 'package:tech_test_atto/utils/failure.dart';

import '../../dummy_data/dummy_products.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late ProductRepositoryImpl repository;
  late MockProductRemoteDataSource mockProductRemoteDataSource;

  setUp(() {
    mockProductRemoteDataSource = MockProductRemoteDataSource();
    repository = ProductRepositoryImpl(
      remoteDataSource: mockProductRemoteDataSource,
    );
  });

  group('Now Playing Movies', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockProductRemoteDataSource.getProducts())
          .thenAnswer((_) async => testProductModelList);
      // act
      final result = await repository.getProducts();
      // assert
      verify(mockProductRemoteDataSource.getProducts());
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, testProductList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockProductRemoteDataSource.getProducts())
          .thenThrow(ServerException());
      // act
      final result = await repository.getProducts();
      // assert
      verify(mockProductRemoteDataSource.getProducts());
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockProductRemoteDataSource.getProducts())
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getProducts();
      // assert
      verify(mockProductRemoteDataSource.getProducts());
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });
}
