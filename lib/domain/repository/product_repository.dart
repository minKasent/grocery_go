import 'package:grocery_go/domain/core/result.dart';
import 'package:grocery_go/domain/entities/category_entity.dart';
import 'package:grocery_go/domain/entities/product_entity.dart';

abstract class IProductRepository {
  ResultFuture<void> deleteAProduct(int id);

  ResultFuture<ListOfCategoryProductsEntity> getAllProducts();

  ResultFuture<List<CategoryEntity>> getProductsCategory();
}
