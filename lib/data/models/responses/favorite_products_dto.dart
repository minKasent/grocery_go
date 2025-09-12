// {
//     "id": 1,
//     "products": [
//         {
//             "id": 168,
//             "title": "Charger SXT RWD",
//             "price": 32999.99,
//             "quantity": 3,
//             "total": 98999.97,
//             "discountPercentage": 13.39,
//             "discountedTotal": 85743.87,
//             "thumbnail": "https://cdn.dummyjson.com/products/images/vehicle/Charger%20SXT%20RWD/thumbnail.png"
//         },
//     ],
//     "total": 103774.85,
//     "discountedTotal": 89686.65,
//     "userId": 33,
//     "totalProducts": 4,
//     "totalQuantity": 15
// }

import 'package:json_annotation/json_annotation.dart';

part 'favorite_products_dto.g.dart';

@JsonSerializable()
class FavoriteProductsDto {
  final int id;
  final List<ProductDto> products;
  final double total;
  final double discountedTotal;
  final int userId;
  final int totalProducts;
  final int totalQuantity;

  FavoriteProductsDto({
    required this.id,
    required this.products,
    required this.total,
    required this.discountedTotal,
    required this.userId,
    required this.totalProducts,
    required this.totalQuantity,
  });

  factory FavoriteProductsDto.fromJson(Map<String, dynamic> json) =>
      _$FavoriteProductsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$FavoriteProductsDtoToJson(this);
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

  ProductDto({
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
