import 'package:equatable/equatable.dart';

class CartEntity extends Equatable {
  final int id;
  final ListCartEntity products;
  final double total;

  const CartEntity({
    required this.id,
    required this.products,
    required this.total,
  });

  @override
  List<Object?> get props => [id, products, total];
}

class ListCartEntity extends Equatable {
  final List<CartItemEntity> listCartEntity;

  const ListCartEntity({required this.listCartEntity});

  @override
  List<Object?> get props => [listCartEntity];
}

class CartItemEntity extends Equatable {
  final int id;
  final String title;
  final double price;
  final String thumbnail;
  final int quantity;

  const CartItemEntity({
    required this.id,
    required this.title,
    required this.price,
    required this.thumbnail,
    required this.quantity,
  });

  @override
  List<Object?> get props => [id, title, price, thumbnail, quantity];
}
