import 'package:grocery_go/domain/core/result.dart';
import 'package:grocery_go/domain/entities/cart_entity.dart';
import 'package:grocery_go/domain/entities/favorite_products_entity.dart';

abstract class ICartRepository {
  ResultFuture<CartEntity> getCart(int userId);

  ResultFuture<ListOfFavoriteProductsEntity> getFavoriteProducts(int id);
}
