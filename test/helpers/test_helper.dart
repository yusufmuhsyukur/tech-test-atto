import 'package:mockito/annotations.dart';
import 'package:tech_test_atto/data/datasources/product_remote_data_source.dart';
import 'package:tech_test_atto/domain/repositories/product_repository.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  ProductRepository,
  ProductRemoteDataSource,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
