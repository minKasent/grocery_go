import 'package:grocery_go/data/models/responses/category_dto.dart';
import 'package:grocery_go/domain/entities/category_entity.dart';

extension CategoryMapper on CategoryDto {
  CategoryEntity toEntity() {
    return CategoryEntity(
      slug: slug,
      name: name,
      url: url,
    );
  }
}