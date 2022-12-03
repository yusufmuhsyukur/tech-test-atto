import 'package:dartz/dartz.dart';
import 'package:tech_test_atto/domain/entities/product.dart';
import 'package:tech_test_atto/domain/repositories/product_repositories.dart';
import 'package:tech_test_atto/utils/failure.dart';

class GetProducts {
  GetProducts(this.productRepositories);
  final ProductRepositories productRepositories;

  Future<Either<Failure, List<Product>>> execute() {
    return productRepositories.getProducts();
  }
}
