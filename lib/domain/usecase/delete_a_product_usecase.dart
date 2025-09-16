import 'package:grocery_go/domain/core/result.dart';
import 'package:grocery_go/domain/core/usecase.dart';
import 'package:grocery_go/domain/repository/product_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteAProductUsecase extends UseCaseAsync<void, int> {
  final IProductRepository _productRepository;

  DeleteAProductUsecase(this._productRepository);

  @override
  ResultFuture<void> call(int id) {
    return _productRepository.deleteAProduct(id);
  }
}
