import 'package:grocery_go/data/datasources/remote/api_service.dart';
import 'package:grocery_go/domain/repository/cart_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: CartRepository)
class CartRepositoryImpl implements CartRepository{
  final ApiService _apiService;

  CartRepositoryImpl(this._apiService,);


}