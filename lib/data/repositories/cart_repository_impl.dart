import 'package:grocery_go/data/core/guard.dart';
import 'package:grocery_go/data/datasources/remote/api_service.dart';
import 'package:grocery_go/data/mappers/favorite_products_mapper.dart';
import 'package:grocery_go/domain/core/result.dart';
import 'package:grocery_go/domain/entities/cart_entity.dart';
import 'package:grocery_go/domain/entities/favorite_products_entity.dart';
import 'package:grocery_go/domain/repository/cart_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ICartRepository)
class CartRepositoryImpl implements ICartRepository {
  final ApiService _apiService;

  CartRepositoryImpl(this._apiService);

  @override
  ResultFuture<CartEntity> getCart(int userId) {
    // TODO: implement getCart
    throw UnimplementedError();
  }

  @override
  ResultFuture<ListOfFavoriteProductsEntity> getFavoriteProducts(int id) {
    return guardDio<ListOfFavoriteProductsEntity>(() async {
      final dto = await _apiService.getFavoriteProducts(id);
      return dto.toEntity();
    });
  }
}
