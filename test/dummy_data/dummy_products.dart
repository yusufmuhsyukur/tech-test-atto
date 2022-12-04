import 'dart:convert';

import 'package:tech_test_atto/data/models/product_model.dart';
import 'package:tech_test_atto/data/models/product_response.dart';
import 'package:tech_test_atto/domain/entities/product.dart';

import '../json_reader.dart';

final Product testProduct = Product(
  id: 1,
  name: 'title',
);
final testProductList = [testProduct];

const ProductModel testProductModel = ProductModel(
  userId: 1,
  id: 1,
  title: "title",
  completed: false,
);

const testProductModelList = [testProductModel];

const ProductResponse testProductResponse = ProductResponse(
  productList: [
    testProductModel,
  ],
);

final List<ProductModel> testProductModelListFromJson =
    ProductResponse.fromJson(json.decode(readJson('dummy_data/todos.json')))
        .productList;
