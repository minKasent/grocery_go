import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final String slug;
  final String name;
  final String thumbnail;

  const CategoryEntity({
    required this.slug,
    required this.name,
    required this.thumbnail,
  });

  @override
  List<Object?> get props => [slug, name, thumbnail];
}

// class ListOfCategoryEntity extends Equatable {
//   final List<CategoryEntity> listOfCategoryEntity;

//   const ListOfCategoryEntity({required this.listOfCategoryEntity});

//   @override
//   List<Object?> get props => [listOfCategoryEntity];
// }
