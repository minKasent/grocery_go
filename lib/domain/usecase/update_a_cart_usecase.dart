import 'package:grocery_go/data/models/params/update_a_cart_param.dart';
import 'package:grocery_go/domain/core/result.dart';
import 'package:grocery_go/domain/core/usecase.dart';
import 'package:grocery_go/domain/entities/cart_entity.dart';
import 'package:grocery_go/domain/repository/cart_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateACartUsecase
    extends UseCaseAsync<ListCartEntity, UpdateACartParam> {
  final ICartRepository _cartRepository;

  UpdateACartUsecase(this._cartRepository);

  @override
  ResultFuture<ListCartEntity> call(UpdateACartParam params) {
    return _cartRepository.updateACart(params);
  }
}
