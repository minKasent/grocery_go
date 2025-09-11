import 'package:grocery_go/domain/core/result.dart';
import 'package:grocery_go/domain/entities/cart_entity.dart';

abstract class CartRepository{
  ResultFuture<CartEntity> getCart(int userId);
}