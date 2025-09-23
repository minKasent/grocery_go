import 'package:equatable/equatable.dart';
import 'package:grocery_go/domain/entities/category_entity.dart';

class ExploreState extends Equatable {
  final bool isLoading;
  final String apiErrorMessage;
  final List<CategoryEntity> categoryEntity;

  const ExploreState({
    this.isLoading = false,
    this.apiErrorMessage = '',
    this.categoryEntity = const [],
  });

  ExploreState copyWith({
    bool? isLoading,
    String? apiErrorMessage,
    List<CategoryEntity>? categoryEntity,
  }) {
    return ExploreState(
      isLoading: isLoading ?? this.isLoading,
      apiErrorMessage: apiErrorMessage ?? this.apiErrorMessage,
      categoryEntity: categoryEntity ?? this.categoryEntity,
    );
  }

  @override
  List<Object?> get props => [isLoading, apiErrorMessage, categoryEntity];
}
