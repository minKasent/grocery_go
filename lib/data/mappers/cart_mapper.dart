import 'package:grocery_go/data/models/responses/cart_dto.dart';
import 'package:grocery_go/domain/entities/cart_entity.dart';

extension CartMapper on CartsDto {
  CartEntity toEntity() {
    return CartEntity(
      id: carts.first.id,
      products: ListCartEntity(
        listCartEntity: carts.first.products
            .map(
              (element) => CartItemEntity(
                id: element.id,
                title: element.title,
                price: element.price,
                thumbnail: element.thumbnail,
                quantity: element.quantity,
              ),
            )
            .toList(),
      ),
      total: carts.first.total,
    );
  }
}

extension SingleCartMapper on CartDto {
  ListCartEntity toEntity() {
    return ListCartEntity(
      listCartEntity: products
          .map(
            (element) => CartItemEntity(
              id: element.id,
              title: element.title,
              price: element.price,
              thumbnail: element.thumbnail,
              quantity: element.quantity,
            ),
          )
          .toList(),
    );
  }
}
