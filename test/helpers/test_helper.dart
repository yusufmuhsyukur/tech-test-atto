import 'package:mockito/annotations.dart';
import 'package:tech_test_atto/domain/repositories/product_repositories.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  ProductRepositories,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
