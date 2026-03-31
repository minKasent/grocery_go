import 'package:equatable/equatable.dart';
import 'package:grocery_go/domain/entities/favorite_products_entity.dart';

class FavoriteState extends Equatable {
  final bool isLoading;
  final String apiErrorMessage;
  final ListOfFavoriteProductsEntity? listOfFavoriteProductsEntity;

  const FavoriteState({
    this.isLoading = false,
    this.apiErrorMessage = '',
    this.listOfFavoriteProductsEntity,
  });

  FavoriteState copyWith({
    bool? isLoading,
    String? apiErrorMessage,
    ListOfFavoriteProductsEntity? listOfFavoriteProductsEntity,
  }) {
    return FavoriteState(
      isLoading: isLoading ?? this.isLoading,
      apiErrorMessage: apiErrorMessage ?? this.apiErrorMessage,
      listOfFavoriteProductsEntity:
          listOfFavoriteProductsEntity ?? this.listOfFavoriteProductsEntity,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    apiErrorMessage,
    listOfFavoriteProductsEntity,
  ];
}
