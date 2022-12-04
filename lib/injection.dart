import 'package:get_it/get_it.dart';
import 'package:tech_test_atto/data/datasources/product_remote_data_source.dart';
import 'package:tech_test_atto/data/repositories/product_respository_impl.dart';
import 'package:tech_test_atto/domain/repositories/product_repository.dart';
import 'package:tech_test_atto/domain/usecases/get_products.dart';
import 'package:tech_test_atto/presentation/provider/page1_notifier.dart';
import 'package:tech_test_atto/presentation/provider/page2_notifier.dart';
import 'package:tech_test_atto/utils/env_constant.dart';
import 'package:http/http.dart' as http;

final locator = GetIt.instance;

void init() {
  // provider
  locator.registerFactory(
    () => Page1Notifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => Page2Notifier(),
  );

  // use case
  locator.registerLazySingleton(
    () => GetProducts(
      locator(),
    ),
  );

  // repository
  locator.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      remoteDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(
      client: locator(),
      baseUrl: EnvConstant.baseUrl,
    ),
  );

  // external
  locator.registerLazySingleton(() => http.Client());
}
