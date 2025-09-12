import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_go/di/injector.dart';
import 'package:grocery_go/domain/usecase/get_favorite_products_usecase.dart';
import 'package:grocery_go/presentation/bloc/favorite/favorite_event.dart';
import 'package:grocery_go/presentation/bloc/favorite/favorite_state.dart';
import 'package:grocery_go/presentation/error/failure_mapper.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final GetFavoriteProductsUsecase getFavoriteProductsUsecase =
      getIt<GetFavoriteProductsUsecase>();
  final FailureMapper _failureMapper;

  FavoriteBloc(this._failureMapper) : super(FavoriteState()) {
    on<OnGetFavoriteProductsEvent>(_onGetFavoriteProductsEvent);
    on<OnClearFavoriteErrorMessageEvent>(_onClearErrorMessage);
    add(OnGetFavoriteProductsEvent(id: 1));
  }

  Future<void> _onGetFavoriteProductsEvent(
    OnGetFavoriteProductsEvent event,
    Emitter<FavoriteState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      final result = await getFavoriteProductsUsecase.call(event.id);
      result.fold(
        (failure) {
          emit(
            state.copyWith(
              apiErrorMessage: _failureMapper.mapFailureToMessage(failure),
            ),
          );
        },
        (data) {
          emit(state.copyWith(listOfFavoriteProductsEntity: data));
        },
      );
    } catch (e) {
      emit(state.copyWith(apiErrorMessage: e.toString()));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  void _onClearErrorMessage(
    OnClearFavoriteErrorMessageEvent event,
    Emitter<FavoriteState> emit,
  ) {
    emit(state.copyWith(apiErrorMessage: ''));
  }
}
