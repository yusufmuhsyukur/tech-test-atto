import 'dart:io';

import 'package:tech_test_atto/data/datasources/product_remote_data_source.dart';
import 'package:tech_test_atto/domain/entities/product.dart';
import 'package:dartz/dartz.dart';
import 'package:tech_test_atto/domain/repositories/product_repository.dart';
import 'package:tech_test_atto/utils/exception.dart';
import 'package:tech_test_atto/utils/failure.dart';

class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl({
    required this.remoteDataSource,
  });
  final ProductRemoteDataSource remoteDataSource;

  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    try {
      final result = await remoteDataSource.getProducts();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
