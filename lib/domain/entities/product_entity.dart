import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final int id;
  final String title;
  final double price;
  final String thumbnail;
  final int weight;
  final List<String> images;
  final String description;
  final double rating;

  const ProductEntity({
    required this.id,
    required this.price,
    required this.thumbnail,
    required this.title,
    required this.weight,
    required this.images,
    required this.description,
    required this.rating,
  });

  @override
  List<Object?> get props => [
    id,
    price,
    thumbnail,
    title,
    weight,
    images,
    description,
    rating,
  ];
}

class ListOfProductsEntity extends Equatable {
  final List<ProductEntity> listOfProductsEntity;

  const ListOfProductsEntity({required this.listOfProductsEntity});

  @override
  List<Object?> get props => [listOfProductsEntity];
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
