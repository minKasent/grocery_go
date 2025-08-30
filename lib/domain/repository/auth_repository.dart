import 'package:grocery_go/data/models/requests/login_schema.dart';
import 'package:grocery_go/domain/core/result.dart';
import 'package:grocery_go/domain/entities/login_entity.dart';

abstract class IAuthRepository {
  ResultFuture<LoginEntity> login(LoginSchema loginSchema);
}
