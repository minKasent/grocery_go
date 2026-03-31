import 'package:grocery_go/data/models/responses/product_dto.dart';
import 'package:grocery_go/domain/entities/product_entity.dart';

/// Extension Mapper: ProductResponseDto -> ListOfCategoryProductsEntity
extension ProductResponseMapper on ProductResponseDto {
  ListOfCategoryProductsEntity toEntity() {
    // Group products by category
    final Map<String, List<ProductEntity>> grouped = {};

    products?.forEach((dto) {
      final category = dto.category ?? 'Other';

      final productEntity = ProductEntity(
        title: dto.title ?? '',
        price: dto.price ?? 0.0,
        thumbnail: dto.thumbnail ?? '',
        weight: dto.weight ?? 0,
        images: dto.images ?? [],
        description: dto.description ?? '',
        rating: dto.rating ?? 0.0,
      );

      if (grouped.containsKey(category)) {
        grouped[category]!.add(productEntity);
      } else {
        grouped[category] = [productEntity];
      }
    });

    // Convert Map -> List<CategoryProductsEntity>
    final listOfCategory = grouped.entries
        .map(
          (entry) => CategoryProductsEntity(
            category: entry.key,
            products: entry.value,
          ),
        )
        .toList();

    // Sort categories alphabetically, nhưng để "Other" xuống cuối
    listOfCategory.sort((a, b) {
      if (a.category == 'Other') return 1;
      if (b.category == 'Other') return -1;
      return a.category.toLowerCase().compareTo(b.category.toLowerCase());
    });

    return ListOfCategoryProductsEntity(
      listOfCategoryProductsEntity: listOfCategory,
    );
  }
}

extension ProductMapper on ProductResponseDto {
  ListOfProductsEntity toListOfProductsEntity() {
    final productsList = products?.map((dto) {
      return ProductEntity(
        title: dto.title ?? '',
        price: dto.price ?? 0.0,
        thumbnail: dto.thumbnail ?? '',
        weight: dto.weight ?? 0,
        images: dto.images ?? [],
        description: dto.description ?? '',
        rating: dto.rating ?? 0.0,
      );
    }).toList();

    return ListOfProductsEntity(listOfProductsEntity: productsList ?? []);
  }
}
