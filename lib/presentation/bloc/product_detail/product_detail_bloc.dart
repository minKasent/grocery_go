import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_go/presentation/bloc/product_detail/product_detail_event.dart';
import 'package:grocery_go/presentation/bloc/product_detail/product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  ProductDetailBloc() : super(ProductDetailState()) {
    on<OnToggleFavoriteEvent>(_onToggleFavoriteEvent);
    on<OnChangeQuantityEvent>(_onChangeQuantityEvent);
    on<OnChangeImageIndexEvent>(_onChangeImageIndexEvent);
  }

  void _onToggleFavoriteEvent(
    OnToggleFavoriteEvent event,
    Emitter<ProductDetailState> emit,
  ) {
    emit(state.copyWith(isFavorite: !state.isFavorite));
  }

  void _onChangeQuantityEvent(
    OnChangeQuantityEvent event,
    Emitter<ProductDetailState> emit,
  ) {
    emit(state.copyWith(quantity: event.quantity));
  }

  void _onChangeImageIndexEvent(
    OnChangeImageIndexEvent event,
    Emitter<ProductDetailState> emit,
  ) {
    emit(state.copyWith(currentIndex: event.currentIndex));
  }
}
