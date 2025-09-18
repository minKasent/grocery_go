import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String title;
  final double price;
  final String thumbnail;
  final int weight;

  const ProductEntity({
    required this.price,
    required this.thumbnail,
    required this.title,
    required this.weight,
  });

  @override
  List<Object?> get props => [price, thumbnail, title, weight];
}

class CategoryProductsEntity extends Equatable {
  final String category;
  final List<ProductEntity> products;

  const CategoryProductsEntity({
    required this.products,
    required this.category,
  });

  @override
  List<Object?> get props => [products, category];
}

class ListOfCategoryProductsEntity extends Equatable {
  final List<CategoryProductsEntity> listOfCategoryProductsEntity;

  const ListOfCategoryProductsEntity({
    required this.listOfCategoryProductsEntity,
  });

  @override
  List<Object?> get props => [listOfCategoryProductsEntity];
}
