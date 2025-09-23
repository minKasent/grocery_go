import 'package:grocery_go/domain/core/result.dart';
import 'package:grocery_go/domain/core/usecase.dart';
import 'package:grocery_go/domain/entities/product_entity.dart';
import 'package:grocery_go/domain/repository/product_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
final class GetListProductsCategoryUsecase
    extends UseCaseAsync<ListOfProductsEntity, String> {
  final IProductRepository _productRepository;

  GetListProductsCategoryUsecase(this._productRepository);

  @override
  ResultFuture<ListOfProductsEntity> call(String slug) {
    return _productRepository.getListOfProducts(slug);
  }
}
