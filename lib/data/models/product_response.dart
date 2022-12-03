import 'package:equatable/equatable.dart';
import 'package:tech_test_atto/data/models/product_model.dart';

class ProductResponse extends Equatable {
  const ProductResponse({required this.productList});
  final List<ProductModel> productList;

  factory ProductResponse.fromJson(dynamic json) => ProductResponse(
        productList: List<ProductModel>.from(
          (json as List).map((x) => ProductModel.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
        "productList": List<dynamic>.from(productList.map((x) => x.toJson())),
      };

  @override
  List<Object> get props => [productList];
}
