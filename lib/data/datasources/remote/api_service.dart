import 'package:dio/dio.dart';
import 'package:grocery_go/data/models/requests/login_schema.dart';
import 'package:grocery_go/data/models/responses/cart_dto.dart';
import 'package:grocery_go/data/models/responses/favorite_products_dto.dart';
import 'package:grocery_go/data/models/responses/login_dto.dart';
import 'package:grocery_go/data/models/responses/user_info_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi()
@lazySingleton
abstract class ApiService {
  @factoryMethod
  factory ApiService(Dio dio) = _ApiService;

  @POST('/auth/login')
  Future<LoginDto> login(@Body() LoginSchema loginSchema);

  @GET('/auth/me')
  Future<UserInfoDto> getUserInfo();

  // @GET('/carts/{id}')
  // Future<void> getASingleCart(@Path('id') int cartId);

// @GET('/carts')
//   Future<List> getAllCarts();
  @GET('/cart/{id}')
  Future<FavoriteProductsDto> getFavoriteProducts(@Path('id') int cartId);

  @GET('/carts/user/{userId}')
  Future<CartsResponse> getUserCarts(@Path('userId') int userId);
}
