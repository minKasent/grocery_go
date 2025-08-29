// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:grocery_go/core/env/app_config.dart' as _i688;
import 'package:grocery_go/di/env_module.dart' as _i271;
import 'package:injectable/injectable.dart' as _i526;

const String _dev = 'dev';
const String _staging = 'staging';
const String _prod = 'prod';

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final appModule = _$AppModule();
    gh.singleton<_i688.AppConfig>(
      () => appModule.devConfig(),
      registerFor: {_dev},
    );
    gh.singleton<_i688.AppConfig>(
      () => appModule.stagingConfig(),
      registerFor: {_staging},
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
    return this;
  }
}

class _$AppModule extends _i271.AppModule {}
