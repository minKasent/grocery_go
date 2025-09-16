import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_go/di/injector.dart';
import 'package:grocery_go/domain/usecase/get_category_usecase.dart';
import 'package:grocery_go/presentation/bloc/explore/explore_event.dart';
import 'package:grocery_go/presentation/bloc/explore/explore_state.dart';
import 'package:grocery_go/presentation/error/failure_mapper.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  final GetCategoryUseCase getCategoryUseCase = getIt<GetCategoryUseCase>();
  final FailureMapper _failureMapper;

  ExploreBloc(this._failureMapper) : super(const ExploreState()) {
    on<OnGetCategoryEvent>(_onGetCategoryEvent);
    add(OnGetCategoryEvent('default-slug'));
  }

  Future<void> _onGetCategoryEvent(
    OnGetCategoryEvent event,
    Emitter<ExploreState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      final result = await getCategoryUseCase.call(event.slug);
      result.fold(
        (failure) {
          emit(
            state.copyWith(
              apiErrorMessage: _failureMapper.mapFailureToMessage(failure),
            ),
          );
        },
        (data) {
          emit(state.copyWith(categoryEntity: data));
        },
      );
    } catch (e) {
      emit(state.copyWith(apiErrorMessage: e.toString()));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }
}
