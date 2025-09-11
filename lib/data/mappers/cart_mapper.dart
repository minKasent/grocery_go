import 'package:grocery_go/data/models/responses/cart_dto.dart';
import 'package:grocery_go/domain/entities/cart_entity.dart';

extension CartMapper on ProductDto {
  CartEntity toEntity() {
    return CartEntity(
      id: id,
      title: title,
      price: price,
      quantity: quantity,
      thumbnail: thumbnail,
    );
  }
}