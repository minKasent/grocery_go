import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class CartsResponse {
  final List<CartDto> carts;
  final int total;
  final int skip;
  final int limit;

  const CartsResponse({
    required this.carts,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory CartsResponse.fromJson(Map<String, dynamic> json) =>
      _$CartsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CartsResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CartDto {
  final int id;
  final List<ProductDto> products;
  final double total;
  final double discountedTotal;
  final int userId;
  final int totalProducts;
  final int totalQuantity;

  const CartDto({
    required this.id,
    required this.products,
    required this.total,
    required this.discountedTotal,
    required this.userId,
    required this.totalProducts,
    required this.totalQuantity,
  });

  factory CartDto.fromJson(Map<String, dynamic> json) =>
      _$CartDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CartDtoToJson(this);
}

@JsonSerializable()
class ProductDto {
  final int id;
  final String title;
  final double price;
  final int quantity;
  final double total;
  final double discountPercentage;
  final double discountedTotal;
  final String thumbnail;

  const ProductDto({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
    required this.total,
    required this.discountPercentage,
    required this.discountedTotal,
    required this.thumbnail,
  });

  factory ProductDto.fromJson(Map<String, dynamic> json) =>
      _$ProductDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDtoToJson(this);
}
