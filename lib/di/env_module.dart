import 'package:grocery_go/core/env/app_config.dart';
import 'package:grocery_go/core/env/flavor.dart';
import 'package:injectable/injectable.dart';

const dev = Environment('dev');
const staging = Environment('staging');
const prod = Environment('prod');

@module
abstract class AppModule {
  /// App for each environment
  @dev
  @Singleton()
  AppConfig devConfig() =>
      AppConfig(flavor: Flavor.dev, baseUrl: 'https://dummyjson.com');

  @staging
  @Singleton()
  AppConfig stagingConfig() =>
      AppConfig(flavor: Flavor.dev, baseUrl: 'https://dummyjson_staging.com');

  @prod
  @Singleton()
  AppConfig prodConfig() =>
      AppConfig(flavor: Flavor.dev, baseUrl: 'https://dummyjson_prod.com');

  /// baseUrl for each environment with @Named to inject into Dio/Retrofit
  @dev
  @Singleton()
  @Named('baseUrl')
  String devBaseUrl(AppConfig appConfig) => appConfig.baseUrl;

  @staging
  @Singleton()
  @Named('baseUrl')
  String stagingBaseUrl(AppConfig appConfig) => appConfig.baseUrl;

  @prod
  @Singleton()
  @Named('baseUrl')
  String prodBaseUrl(AppConfig appConfig) => appConfig.baseUrl;
}
