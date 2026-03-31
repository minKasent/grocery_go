import 'package:equatable/equatable.dart';
import 'package:grocery_go/domain/entities/product_entity.dart';

class ShopState extends Equatable {
  final bool isLoading;
  final String apiErrorMessage;
  final ListOfCategoryProductsEntity? listOfCategoryProductsEntity;

  const ShopState({
    this.isLoading = false,
    this.apiErrorMessage = '',
    this.listOfCategoryProductsEntity,
  });

  ShopState copyWith({
    bool? isLoading,
    String? apiErrorMessage,
    ListOfCategoryProductsEntity? listOfCategoryProductsEntity,
  }) {
    return ShopState(
      isLoading: isLoading ?? this.isLoading,
      apiErrorMessage: apiErrorMessage ?? this.apiErrorMessage,
      listOfCategoryProductsEntity:
          listOfCategoryProductsEntity ?? this.listOfCategoryProductsEntity,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    apiErrorMessage,
    listOfCategoryProductsEntity,
  ];
}
