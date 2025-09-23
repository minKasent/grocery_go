import 'package:grocery_go/data/models/params/update_a_cart_param.dart';
import 'package:grocery_go/domain/core/result.dart';
import 'package:grocery_go/domain/entities/cart_entity.dart';
import 'package:grocery_go/domain/entities/favorite_products_entity.dart';

abstract class ICartRepository {
  ResultFuture<CartEntity> getCart(int id);

  ResultFuture<ListOfFavoriteProductsEntity> getFavoriteProducts(int id);

  ResultFuture<ListCartEntity> updateACart(UpdateACartParam params);
}
