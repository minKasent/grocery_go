import 'package:equatable/equatable.dart';
import 'package:grocery_go/domain/entities/product_entity.dart';

class ProductDetailState extends Equatable {
  final bool isFavorite;
  final int quantity;
  final int currentIndex;
  final ProductEntity? product;
  final bool isLoading;
  final String errorMessage;

  const ProductDetailState({
    this.isFavorite = false,
    this.quantity = 1,
    this.currentIndex = 0,
    this.product,
    this.isLoading = false,
    this.errorMessage = '',
  });

  ProductDetailState copyWith({
    bool? isFavorite,
    int? quantity,
    int? currentIndex,
    ProductEntity? product,
    bool? isLoading,
    String? errorMessage,
  }) {
    return ProductDetailState(
      isFavorite: isFavorite ?? this.isFavorite,
      quantity: quantity ?? this.quantity,
      currentIndex: currentIndex ?? this.currentIndex,
      product: product ?? this.product,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    isFavorite,
    quantity,
    currentIndex,
    product,
    isLoading,
    errorMessage,
  ];
}
