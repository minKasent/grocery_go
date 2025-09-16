import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_go/di/injector.dart';
import 'package:grocery_go/domain/core/usecase.dart';
import 'package:grocery_go/domain/usecase/get_all_products_usecase.dart';
import 'package:grocery_go/presentation/bloc/shop/shop_event.dart';
import 'package:grocery_go/presentation/bloc/shop/shop_state.dart';
import 'package:grocery_go/presentation/error/failure_mapper.dart';

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  final GetAllProductsUsecase getAllProductsUsecase =
      getIt<GetAllProductsUsecase>();
  final FailureMapper _failureMapper;

  ShopBloc(this._failureMapper) : super(ShopState()) {
    on<OnGetAllProductsEvent>(_onGetAllProductsEvent);
    on<OnClearShopErrorMessageEvent>(_onClearErrorMessage);
    add(OnGetAllProductsEvent());
  }

  Future<void> _onGetAllProductsEvent(
    OnGetAllProductsEvent event,
    Emitter<ShopState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      final result = await getAllProductsUsecase.call(NoParams());
      result.fold(
        (failure) {
          emit(
            state.copyWith(
              apiErrorMessage: _failureMapper.mapFailureToMessage(failure),
            ),
          );
        },
        (data) {
          emit(state.copyWith(listOfCategoryProductsEntity: data));
        },
      );
    } catch (e) {
      emit(state.copyWith(apiErrorMessage: e.toString()));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  void _onClearErrorMessage(
    OnClearShopErrorMessageEvent event,
    Emitter<ShopState> emit,
  ) {
    emit(state.copyWith(apiErrorMessage: ''));
  }
}
