import 'package:grocery_go/data/models/responses/favorite_products_dto.dart';
import 'package:grocery_go/domain/entities/favorite_products_entity.dart';

extension ListOfFavoriteProductsMapper on FavoriteProductsDto {
  ListOfFavoriteProductsEntity toEntity() {
    return ListOfFavoriteProductsEntity(
      listOfFavoriteProducts: List.from(
        products.map(
              (product) => FavoriteProductEntity(
            id: product.id,
            title: product.title,
            price: product.price,
            thumbnail: product.thumbnail,
          ),
        ),
      ),
    );
  }
}