import 'package:equatable/equatable.dart';
import 'package:grocery_go/domain/entities/product_entity.dart';

class CategoryProductState extends Equatable {
  final bool isLoading;
  final String apiErrorMessage;
  final ListOfProductsEntity? listOfProductsEntity;

  const CategoryProductState({
    this.isLoading = false,
    this.apiErrorMessage = '',
    this.listOfProductsEntity,
  });

  CategoryProductState copyWith({
    bool? isLoading,
    String? apiErrorMessage,
    ListOfProductsEntity? listOfProductsEntity,
  }) {
    return CategoryProductState(
      isLoading: isLoading ?? this.isLoading,
      apiErrorMessage: apiErrorMessage ?? this.apiErrorMessage,
      listOfProductsEntity: listOfProductsEntity ?? this.listOfProductsEntity,
    );
  }

  @override
  List<Object?> get props => [isLoading, apiErrorMessage, listOfProductsEntity];
}
