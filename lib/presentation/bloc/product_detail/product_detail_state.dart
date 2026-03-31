import 'package:equatable/equatable.dart';

class ProductDetailState extends Equatable {
  final bool isFavorite;
  final int quantity;
  final int currentIndex;

  const ProductDetailState({
    this.isFavorite = false,
    this.quantity = 1,
    this.currentIndex = 0,
  });

  ProductDetailState copyWith({
    bool? isFavorite,
    int? quantity,
    int? currentIndex,
  }) {
    return ProductDetailState(
      isFavorite: isFavorite ?? this.isFavorite,
      quantity: quantity ?? this.quantity,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }

  @override
  List<Object?> get props => [isFavorite, quantity, currentIndex];
}
