import 'dart:convert';

import 'package:tech_test_atto/data/models/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:tech_test_atto/data/models/product_response.dart';
import 'package:tech_test_atto/utils/exception.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  ProductRemoteDataSourceImpl({
    required this.client,
    required this.baseUrl,
  });
  final http.Client client;
  final String baseUrl;

  @override
  Future<List<ProductModel>> getProducts() async {
    final response = await client.get(Uri.parse('$baseUrl/todos'));

    if (response.statusCode == 200) {
      return ProductResponse.fromJson(json.decode(response.body)).productList;
    } else {
      throw ServerException();
    }
  }
}
