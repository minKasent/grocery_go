import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_go/di/injector.dart';
import 'package:grocery_go/domain/usecase/get_list_products_category_usecase.dart';
import 'package:grocery_go/presentation/bloc/category_product/category_product_event.dart';
import 'package:grocery_go/presentation/bloc/category_product/category_product_state.dart';
import 'package:grocery_go/presentation/error/failure_mapper.dart';

class CategoryProductBloc
    extends Bloc<CategoryProductEvent, CategoryProductState> {
  final GetListProductsCategoryUsecase categoryProductUsecase =
      getIt<GetListProductsCategoryUsecase>();
  final FailureMapper _failureMapper;

  CategoryProductBloc(this._failureMapper) : super(CategoryProductState()) {
    on<OnFetchListOfProductsEvent>(_onFetchListOfProductsEvent);
    on<OnClearCategoryProductErrorMessageEvent>(_onClearErrorMessage);
  }

  Future<void> _onFetchListOfProductsEvent(
    OnFetchListOfProductsEvent event,
    Emitter<CategoryProductState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      final result = await categoryProductUsecase.call(event.slug);

      result.fold(
        (failure) {
          emit(
            state.copyWith(
              apiErrorMessage: _failureMapper.mapFailureToMessage(failure),
            ),
          );
        },
        (data) {
          emit(state.copyWith(listOfProductsEntity: data));
        },
      );
    } catch (e) {
      emit(state.copyWith(apiErrorMessage: e.toString()));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  void _onClearErrorMessage(
    OnClearCategoryProductErrorMessageEvent event,
    Emitter<CategoryProductState> emit,
  ) {
    emit(state.copyWith(apiErrorMessage: ''));
  }
}
