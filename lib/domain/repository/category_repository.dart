import 'package:grocery_go/domain/entities/category_entity.dart';
import 'package:grocery_go/domain/core/result.dart';

abstract class ICategoryRepository {
  ResultFuture<CategoryEntity> getCategory(String slug);
}

