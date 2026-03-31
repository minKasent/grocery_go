import 'package:grocery_go/domain/core/result.dart';
import 'package:grocery_go/domain/core/usecase.dart';
import 'package:grocery_go/domain/entities/user_info_entity.dart';
import 'package:grocery_go/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
final class GetUserInfoUsecase extends UseCaseAsync<UserInfoEntity, NoParams> {
  final IAuthRepository _authRepository;

  GetUserInfoUsecase(this._authRepository);

  @override
  ResultFuture<UserInfoEntity> call(NoParams params) {
    return _authRepository.getUserInfo();
  }
}
