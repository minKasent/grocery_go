import 'package:grocery_go/domain/core/result.dart';
import 'package:grocery_go/domain/core/usecase.dart';
import 'package:grocery_go/domain/entities/product_entity.dart';
import 'package:grocery_go/domain/repository/product_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAllProductsUsecase
    extends UseCaseAsync<ListOfCategoryProductsEntity, NoParams> {
  final IProductRepository _productRepository;

  GetAllProductsUsecase(this._productRepository);

  @override
  ResultFuture<ListOfCategoryProductsEntity> call(NoParams params) {
    return _productRepository.getAllProducts();
  }
}
