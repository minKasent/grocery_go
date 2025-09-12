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

import 'package:equatable/equatable.dart';

class ListOfFavoriteProductsEntity extends Equatable {
  final List<FavoriteProductEntity> listOfFavoriteProducts;

  const ListOfFavoriteProductsEntity({required this.listOfFavoriteProducts});
  @override
  List<Object?> get props => [listOfFavoriteProducts];
}

class FavoriteProductEntity extends Equatable {
  final int id;
  final String title;
  final double price;
  final String thumbnail;

  const FavoriteProductEntity({
    required this.id,
    required this.title,
    required this.price,
    required this.thumbnail,
  });

  @override
  List<Object?> get props => [id, title, price, thumbnail];
}
