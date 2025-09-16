import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_go/di/injector.dart';
import 'package:grocery_go/domain/entities/cart_entity.dart';
import 'package:grocery_go/domain/usecase/delete_a_product_usecase.dart';
import 'package:grocery_go/domain/usecase/get_cart_usecase.dart';
import 'package:grocery_go/domain/usecase/update_a_cart_usecase.dart';
import 'package:grocery_go/presentation/bloc/cart/cart_event.dart';
import 'package:grocery_go/presentation/bloc/cart/cart_state.dart';
import 'package:grocery_go/presentation/error/failure_mapper.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final GetCartUserCase getCartUserCase = getIt<GetCartUserCase>();
  final DeleteAProductUsecase deleteAProductUsecase =
      getIt<DeleteAProductUsecase>();
  final UpdateACartUsecase updateACartUsecase = getIt<UpdateACartUsecase>();
  final FailureMapper _failureMapper;

  CartBloc(this._failureMapper) : super(CartState()) {
    on<OnGetCartUserEvent>(_onGetCartUserEvent);
    on<OnClearCartErrorMessageEvent>(_onClearErrorMessage);
    on<OnDeleteAProductEvent>(_onDeleteAProductEvent);
    on<OnUpdateACartEvent>(_onUpdateACartEvent);
    add(OnGetCartUserEvent(15));
  }

  Future<void> _onGetCartUserEvent(
    OnGetCartUserEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      final result = await getCartUserCase.call(event.id);
      result.fold(
        (failure) {
          emit(
            state.copyWith(
              apiErrorMessage: _failureMapper.mapFailureToMessage(failure),
            ),
          );
        },
        (data) {
          emit(state.copyWith(cartEntity: data));
        },
      );
    } catch (e) {
      emit(state.copyWith(apiErrorMessage: e.toString()));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> _onUpdateACartEvent(
    OnUpdateACartEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      final result = await updateACartUsecase.call(event.params);
      result.fold(
        (failure) {
          emit(
            state.copyWith(
              apiErrorMessage: _failureMapper.mapFailureToMessage(failure),
            ),
          );
        },
        (data) {
          if (state.cartEntity != null) {
            emit(
              state.copyWith(
                cartEntity: CartEntity(
                  id: state.cartEntity!.id,
                  products: data,
                  total: state.cartEntity!.total,
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      emit(state.copyWith(apiErrorMessage: e.toString()));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> _onDeleteAProductEvent(
    OnDeleteAProductEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      final result = await deleteAProductUsecase.call(event.id);
      result.fold(
        (failure) {
          emit(
            state.copyWith(
              apiErrorMessage: _failureMapper.mapFailureToMessage(failure),
            ),
          );
        },
        (data) {
          /// remove deleted product
          if (state.cartEntity != null) {
            final newProducts = state.cartEntity!.products.listCartEntity
                .where((element) => element.id != event.id)
                .toList();

            emit(
              state.copyWith(
                cartEntity: CartEntity(
                  id: state.cartEntity!.id,
                  products: ListCartEntity(listCartEntity: newProducts),
                  total: state.cartEntity!.total,
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      emit(state.copyWith(apiErrorMessage: e.toString()));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  void _onClearErrorMessage(
    OnClearCartErrorMessageEvent event,
    Emitter<CartState> emit,
  ) {
    emit(state.copyWith(apiErrorMessage: ''));
  }
}
