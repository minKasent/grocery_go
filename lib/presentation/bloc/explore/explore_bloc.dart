import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_go/di/injector.dart';
import 'package:grocery_go/domain/core/usecase.dart';
import 'package:grocery_go/domain/entities/category_entity.dart';
import 'package:grocery_go/domain/usecase/get_products_category_usecase.dart';
import 'package:grocery_go/presentation/bloc/explore/explore_event.dart';
import 'package:grocery_go/presentation/bloc/explore/explore_state.dart';
import 'package:grocery_go/presentation/error/failure_mapper.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  final GetProductsCategoryUsecase getProductsCategoryUsecase =
      getIt<GetProductsCategoryUsecase>();
  final FailureMapper _failureMapper;
  List<CategoryEntity> _cachedCategoryEntity = [];

  ExploreBloc(this._failureMapper) : super(ExploreState()) {
    on<OnGetCategoryEvent>(_onGetCategoryEvent);
    on<OnClearExploreErrorMessageEvent>(_onClearErrorMessage);
    on<OnSearchCategoryEvent>(_onSearchCategoryEvent);
    add(OnGetCategoryEvent());
  }

  Future<void> _onGetCategoryEvent(
    OnGetCategoryEvent event,
    Emitter<ExploreState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      final result = await getProductsCategoryUsecase.call(NoParams());
      result.fold(
        (failure) {
          emit(
            state.copyWith(
              apiErrorMessage: _failureMapper.mapFailureToMessage(failure),
            ),
          );
        },
        (data) {
          _cachedCategoryEntity = data;
          emit(state.copyWith(categoryEntity: data));
        },
      );
    } catch (e) {
      emit(state.copyWith(apiErrorMessage: e.toString()));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  void _onClearErrorMessage(
    OnClearExploreErrorMessageEvent event,
    Emitter<ExploreState> emit,
  ) {
    emit(state.copyWith(apiErrorMessage: ''));
  }

  void _onSearchCategoryEvent(
    OnSearchCategoryEvent event,
    Emitter<ExploreState> emit,
  ) {
    if (event.query.trim().toLowerCase().isNotEmpty) {
      final newCategoryEntity = state.categoryEntity
          .where((e) => e.name.toLowerCase().contains(event.query))
          .toList();
      emit(state.copyWith(categoryEntity: newCategoryEntity));
    } else {
      emit(state.copyWith(categoryEntity: _cachedCategoryEntity));
    }
  }
}
