import 'package:equatable/equatable.dart';
import 'package:grocery_go/domain/entities/cart_entity.dart';

class CartState extends Equatable {
  final bool isLoading;
  final String apiErrorMessage;
  final CartEntity? cartEntity;

  const CartState({
    this.isLoading = false,
    this.apiErrorMessage = '',
    this.cartEntity,
  });

  CartState copyWith({
    bool? isLoading,
    String? apiErrorMessage,
    CartEntity? cartEntity,
  }) {
    return CartState(
      isLoading: isLoading ?? this.isLoading,
      apiErrorMessage: apiErrorMessage ?? this.apiErrorMessage,
      cartEntity: cartEntity ?? this.cartEntity,
    );
  }

  @override
  List<Object?> get props => [isLoading, apiErrorMessage, cartEntity];
}
