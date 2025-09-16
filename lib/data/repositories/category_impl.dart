import 'package:grocery_go/data/mappers/category_mapper.dart';
import 'package:injectable/injectable.dart';
import 'package:grocery_go/domain/repository/category_repository.dart';
import 'package:grocery_go/domain/entities/category_entity.dart';
import 'package:grocery_go/domain/core/result.dart';
import 'package:grocery_go/data/datasources/remote/api_service.dart';
import 'package:grocery_go/data/core/guard.dart';

@LazySingleton(as: ICategoryRepository)
class CategoryRepositoryImpl implements ICategoryRepository {
  final ApiService _apiService;

  CategoryRepositoryImpl(this._apiService);

  @override
  ResultFuture<CategoryEntity> getCategory(String slug) {
    return guardDio<CategoryEntity>(() async {
      final dto = await _apiService.getCategory(slug);
      return dto.toEntity();
    });
  }
}
