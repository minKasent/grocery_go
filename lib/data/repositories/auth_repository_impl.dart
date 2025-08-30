import 'package:grocery_go/data/core/guard.dart';
import 'package:grocery_go/data/datasources/remote/api_service.dart';
import 'package:grocery_go/data/mappers/login_mapper.dart';
import 'package:grocery_go/data/models/requests/login_schema.dart';
import 'package:grocery_go/domain/core/result.dart';
import 'package:grocery_go/domain/entities/login_entity.dart';
import 'package:grocery_go/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IAuthRepository)
class AuthRepositoryImpl implements IAuthRepository {
  final ApiService apiService;

  AuthRepositoryImpl(this.apiService);

  @override
  ResultFuture<LoginEntity> login(LoginSchema loginSchema) {
    return guardDio<LoginEntity>(() async {
      final dto = await apiService.login(loginSchema);
      return dto.toEntity();
    });
  }
}
