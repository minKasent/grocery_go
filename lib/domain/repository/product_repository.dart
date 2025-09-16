import 'package:grocery_go/domain/core/result.dart';

abstract class IProductRepository {
  ResultFuture<void> deleteAProduct(int id);
}
