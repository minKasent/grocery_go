// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:grocery_go/core/env/app_config.dart' as _i688;
import 'package:grocery_go/core/logging/app_logger.dart' as _i584;
import 'package:grocery_go/core/logging/console_app_logger.dart' as _i375;
import 'package:grocery_go/data/core/inteterceptors.dart' as _i631;
import 'package:grocery_go/data/datasources/local/secure_storage.dart' as _i606;
import 'package:grocery_go/data/datasources/remote/api_service.dart' as _i750;
import 'package:grocery_go/data/repositories/auth_repository_impl.dart'
    as _i697;
import 'package:grocery_go/data/repositories/cart_repository_impl.dart'
    as _i981;
import 'package:grocery_go/data/repositories/product_repository_impl.dart'
    as _i568;
import 'package:grocery_go/di/env_module.dart' as _i271;
import 'package:grocery_go/di/third_party_module.dart' as _i823;
import 'package:grocery_go/domain/repository/auth_repository.dart' as _i67;
import 'package:grocery_go/domain/repository/cart_repository.dart' as _i384;
import 'package:grocery_go/domain/repository/category_repository.dart' as _i283;
import 'package:grocery_go/domain/repository/product_repository.dart' as _i676;
import 'package:grocery_go/domain/usecase/delete_a_product_usecase.dart'
    as _i720;
import 'package:grocery_go/domain/usecase/get_all_products_usecase.dart'
    as _i648;
import 'package:grocery_go/domain/usecase/get_cart_usecase.dart' as _i515;
import 'package:grocery_go/domain/usecase/get_category_usecase.dart' as _i527;
import 'package:grocery_go/domain/usecase/get_favorite_products_usecase.dart'
    as _i692;
import 'package:grocery_go/domain/usecase/get_list_products_category_usecase.dart'
    as _i695;
import 'package:grocery_go/domain/usecase/get_products_category_usecase.dart'
    as _i376;
import 'package:grocery_go/domain/usecase/get_single_product_usecase.dart'
    as _i547;
import 'package:grocery_go/domain/usecase/get_user_info_usecase.dart' as _i149;
import 'package:grocery_go/domain/usecase/login_usecase.dart' as _i878;
import 'package:grocery_go/domain/usecase/update_a_cart_usecase.dart' as _i460;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

const String _dev = 'dev';
const String _staging = 'staging';
const String _prod = 'prod';

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final thirdPartyModule = _$ThirdPartyModule();
    final appModule = _$AppModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => thirdPartyModule.sharedPrefrences(),
      preResolve: true,
    );
    gh.factory<_i558.FlutterSecureStorage>(
      () => thirdPartyModule.secureStorage(),
    );
    gh.factory<_i527.GetCategoryUseCase>(
      () => _i527.GetCategoryUseCase(gh<_i283.ICategoryRepository>()),
    );
    gh.lazySingleton<_i584.AppLogger>(() => _i375.ConsoleAppLogger());
    gh.singleton<_i688.AppConfig>(
      () => appModule.devConfig(),
      registerFor: {_dev},
    );
    gh.singleton<_i688.AppConfig>(
      () => appModule.stagingConfig(),
      registerFor: {_staging},
    );
    gh.singleton<_i606.SecureStorage>(
      () => _i606.SecureStorage(gh<_i558.FlutterSecureStorage>()),
    );
    gh.singleton<String>(
      () => appModule.stagingBaseUrl(gh<_i688.AppConfig>()),
      instanceName: 'baseUrl',
      registerFor: {_staging},
    );
    gh.singleton<String>(
      () => appModule.devBaseUrl(gh<_i688.AppConfig>()),
      instanceName: 'baseUrl',
      registerFor: {_dev},
    );
    gh.singleton<_i688.AppConfig>(
      () => appModule.prodConfig(),
      registerFor: {_prod},
    );
    gh.singleton<String>(
      () => appModule.prodBaseUrl(gh<_i688.AppConfig>()),
      instanceName: 'baseUrl',
      registerFor: {_prod},
    );
    gh.lazySingleton<_i631.NetworkInterceptor>(
      () => _i631.NetworkInterceptor(
        gh<_i606.SecureStorage>(),
        gh<_i584.AppLogger>(),
      ),
    );
    gh.lazySingleton<_i361.Dio>(
      () => thirdPartyModule.dio(
        gh<_i688.AppConfig>(),
        gh<String>(instanceName: 'baseUrl'),
        gh<_i631.NetworkInterceptor>(),
      ),
    );
    gh.lazySingleton<_i750.ApiService>(() => _i750.ApiService(gh<_i361.Dio>()));
    gh.lazySingleton<_i676.IProductRepository>(
      () => _i568.ProductRepositoryImpl(gh<_i750.ApiService>()),
    );
    gh.lazySingleton<_i384.ICartRepository>(
      () => _i981.CartRepositoryImpl(gh<_i750.ApiService>()),
    );
    gh.factory<_i648.GetAllProductsUsecase>(
      () => _i648.GetAllProductsUsecase(gh<_i676.IProductRepository>()),
    );
    gh.factory<_i695.GetListProductsCategoryUsecase>(
      () =>
          _i695.GetListProductsCategoryUsecase(gh<_i676.IProductRepository>()),
    );
    gh.factory<_i376.GetProductsCategoryUsecase>(
      () => _i376.GetProductsCategoryUsecase(gh<_i676.IProductRepository>()),
    );
    gh.factory<_i720.DeleteAProductUsecase>(
      () => _i720.DeleteAProductUsecase(gh<_i676.IProductRepository>()),
    );
    gh.factory<_i547.GetSingleProductUsecase>(
      () => _i547.GetSingleProductUsecase(gh<_i676.IProductRepository>()),
    );
    gh.factory<_i515.GetCartUserCase>(
      () => _i515.GetCartUserCase(gh<_i384.ICartRepository>()),
    );
    gh.factory<_i460.UpdateACartUsecase>(
      () => _i460.UpdateACartUsecase(gh<_i384.ICartRepository>()),
    );
    gh.factory<_i692.GetFavoriteProductsUsecase>(
      () => _i692.GetFavoriteProductsUsecase(gh<_i384.ICartRepository>()),
    );
    gh.lazySingleton<_i67.IAuthRepository>(
      () => _i697.AuthRepositoryImpl(gh<_i750.ApiService>()),
    );
    gh.factory<_i878.LoginUsecase>(
      () => _i878.LoginUsecase(gh<_i67.IAuthRepository>()),
    );
    gh.factory<_i149.GetUserInfoUsecase>(
      () => _i149.GetUserInfoUsecase(gh<_i67.IAuthRepository>()),
    );
    return this;
  }
}

class _$ThirdPartyModule extends _i823.ThirdPartyModule {}

class _$AppModule extends _i271.AppModule {}
