import 'package:grocery_go/data/core/guard.dart';
import 'package:grocery_go/data/datasources/remote/api_service.dart';
import 'package:grocery_go/data/mappers/category_mapper.dart';
import 'package:grocery_go/data/mappers/product_mapper.dart';
import 'package:grocery_go/domain/core/result.dart';
import 'package:grocery_go/domain/entities/category_entity.dart';
import 'package:grocery_go/domain/entities/product_entity.dart';
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

  @override
  ResultFuture<ListOfCategoryProductsEntity> getAllProducts() {
    return guardDio<ListOfCategoryProductsEntity>(() async {
      final dto = await apiService.getAllProducts();
      return dto.toEntity();
    });
  }

  @override
  ResultFuture<List<CategoryEntity>> getProductsCategory() {
    return guardDio<List<CategoryEntity>>(() async {
      final dto = await apiService.getProductsCategory();
      return dto.map((e) => e.toEntity()).toList();
    });
  }

  @override
  ResultFuture<ListOfProductsEntity> getListOfProducts(String slug) {
    return guardDio<ListOfProductsEntity>(() async {
      final dto = await apiService.getProductsByCategory(slug);
      return dto.toListOfProductsEntity();
    });
  }

  @override
  ResultFuture<ProductEntity> getProductById(int id) {
    return guardDio<ProductEntity>(() async {
      final dto = await apiService.getProductById(id);
      return dto.toEntity();
    });
  }
}
