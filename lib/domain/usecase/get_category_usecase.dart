import 'package:grocery_go/domain/core/result.dart';
import 'package:grocery_go/domain/core/usecase.dart';
import 'package:grocery_go/domain/entities/category_entity.dart';
import 'package:grocery_go/domain/repository/category_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCategoryUseCase extends UseCaseAsync<CategoryEntity, String> {
  final ICategoryRepository _categoryRepository;

  GetCategoryUseCase(this._categoryRepository);

  @override
  ResultFuture<CategoryEntity> call(String slug) {
    return _categoryRepository.getCategory(slug);
  }
}
