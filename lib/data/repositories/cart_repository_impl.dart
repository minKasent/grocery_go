import 'package:grocery_go/data/core/guard.dart';
import 'package:grocery_go/data/datasources/remote/api_service.dart';
import 'package:grocery_go/data/mappers/cart_mapper.dart';
import 'package:grocery_go/data/mappers/favorite_products_mapper.dart';
import 'package:grocery_go/data/models/params/update_a_cart_param.dart';
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
  ResultFuture<CartEntity> getCart(int id) {
    return guardDio<CartEntity>(() async {
      final dto = await _apiService.getUserCarts(id);
      return dto.toEntity();
    });
  }

  @override
  ResultFuture<ListOfFavoriteProductsEntity> getFavoriteProducts(int id) {
    return guardDio<ListOfFavoriteProductsEntity>(() async {
      final dto = await _apiService.getFavoriteProducts(id);
      return dto.toEntity();
    });
  }

  @override
  ResultFuture<ListCartEntity> updateACart(UpdateACartParam params) {
    return guardDio<ListCartEntity>(() async {
      final dto = await _apiService.updateACart(params.schema, params.id);
      return dto.toEntity();
    });
  }
}
