import 'package:grocery_go/data/core/guard.dart';
import 'package:grocery_go/data/datasources/remote/api_service.dart';
import 'package:grocery_go/domain/core/result.dart';
import 'package:grocery_go/domain/repository/product_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IProductRepository)
class ProductRepositoryImpl implements IProductRepository {
  final ApiService apiService;

  ProductRepositoryImpl(this.apiService);

  @override
  ResultFuture<void> deleteAProduct(int id) {
    return guardDio<void>(() async {
      await apiService.deleteAProduct(id);
    });
  }
}
