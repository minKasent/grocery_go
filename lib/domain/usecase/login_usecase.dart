import 'package:grocery_go/data/models/requests/login_schema.dart';
import 'package:grocery_go/domain/core/result.dart';
import 'package:grocery_go/domain/core/usecase.dart';
import 'package:grocery_go/domain/entities/login_entity.dart';
import 'package:grocery_go/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
final class LoginUsecase extends UseCaseAsync<LoginEntity, LoginSchema> {
  final IAuthRepository _authRepository;

  LoginUsecase(this._authRepository);

  @override
  ResultFuture<LoginEntity> call(LoginSchema params) {
    return _authRepository.login(params);
  }
}
