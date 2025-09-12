import 'package:equatable/equatable.dart';

class ListOfFavoriteProductsEntity extends Equatable {
  final List<FavoriteProductEntity> listOfFavoriteProducts;
  const ListOfFavoriteProductsEntity({required this.listOfFavoriteProducts});

  @override
  // TODO: implement props
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
  // TODO: implement props
  List<Object?> get props => [id, title, price, thumbnail];
}
