import 'package:grocery_go/domain/core/result.dart';
import 'package:grocery_go/domain/core/usecase.dart';
import 'package:grocery_go/domain/entities/category_entity.dart';
import 'package:grocery_go/domain/repository/product_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
final class GetProductsCategoryUsecase
    extends UseCaseAsync<List<CategoryEntity>, NoParams> {
  final IProductRepository _productRepository;

  GetProductsCategoryUsecase(this._productRepository);

  @override
  ResultFuture<List<CategoryEntity>> call(NoParams params) {
    return _productRepository.getProductsCategory();
  }
}
