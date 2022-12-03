import 'package:dartz/dartz.dart';
import 'package:tech_test_atto/domain/entities/product.dart';
import 'package:tech_test_atto/utils/failure.dart';

abstract class ProductRepositories {
  Future<Either<Failure, List<Product>>> getProducts();
}
