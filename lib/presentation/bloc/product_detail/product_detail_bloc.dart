import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_go/di/injector.dart';
import 'package:grocery_go/domain/usecase/get_single_product_usecase.dart';
import 'package:grocery_go/presentation/bloc/product_detail/product_detail_event.dart';
import 'package:grocery_go/presentation/bloc/product_detail/product_detail_state.dart';
import 'package:grocery_go/presentation/error/failure_mapper.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final GetSingleProductUsecase _getSingleProductUsecase =
      getIt<GetSingleProductUsecase>();
  final FailureMapper _failureMapper;
  ProductDetailBloc(this._failureMapper) : super(ProductDetailState()) {
    on<OnToggleFavoriteEvent>(_onToggleFavoriteEvent);
    on<OnChangeQuantityEvent>(_onChangeQuantityEvent);
    on<OnChangeImageIndexEvent>(_onChangeImageIndexEvent);
    on<OnGetSingleProductEvent>(_onGetSingleProductEvent);
    on<OnClearProductDetailErrorMessageEvent>(
      _onClearProductDetailErrorMessageEvent,
    );
  }

  Future<void> _onGetSingleProductEvent(
    OnGetSingleProductEvent event,
    Emitter<ProductDetailState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      final result = await _getSingleProductUsecase.call(event.id);
      result.fold(
        (failure) {
          emit(
            state.copyWith(
              errorMessage: _failureMapper.mapFailureToMessage(failure),
            ),
          );
        },
        (data) {
          emit(state.copyWith(product: data));
        },
      );
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
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

  void _onClearProductDetailErrorMessageEvent(
    OnClearProductDetailErrorMessageEvent event,
    Emitter<ProductDetailState> emit,
  ) {
    emit(state.copyWith(errorMessage: ''));
  }
}
