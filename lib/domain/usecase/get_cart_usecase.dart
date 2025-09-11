import 'package:grocery_go/domain/core/result.dart';
import 'package:grocery_go/domain/core/usecase.dart';
import 'package:grocery_go/domain/entities/cart_entity.dart';
import 'package:grocery_go/domain/repository/cart_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCartUserCase extends UseCaseAsync<CartEntity, int> {
  final ICartRepository _cartRepository;
  GetCartUserCase(this._cartRepository);
  @override
  ResultFuture<CartEntity> call(int params) {
    return _cartRepository.getCart(params);
  }
}
