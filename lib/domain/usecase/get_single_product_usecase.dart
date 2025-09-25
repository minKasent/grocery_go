import 'package:grocery_go/domain/core/result.dart';
import 'package:grocery_go/domain/core/usecase.dart';
import 'package:grocery_go/domain/entities/product_entity.dart';
import 'package:grocery_go/domain/repository/product_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetSingleProductUsecase extends UseCaseAsync<ProductEntity, int> {
  final IProductRepository _productRepository;

  GetSingleProductUsecase(this._productRepository);

  @override
  ResultFuture<ProductEntity> call(int id) {
    return _productRepository.getProductById(id);
  }
}
