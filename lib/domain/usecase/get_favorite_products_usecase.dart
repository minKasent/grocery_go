import 'package:grocery_go/domain/core/result.dart';
import 'package:grocery_go/domain/core/usecase.dart';
import 'package:grocery_go/domain/entities/favorite_products_entity.dart';
import 'package:grocery_go/domain/repository/cart_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
final class GetFavoriteProductsUsecase
    extends UseCaseAsync<ListOfFavoriteProductsEntity, int> {
  final ICartRepository _cartRepository;

  GetFavoriteProductsUsecase(this._cartRepository);

  @override
  ResultFuture<ListOfFavoriteProductsEntity> call(int id) {
    return _cartRepository.getFavoriteProducts(id);
  }
}
