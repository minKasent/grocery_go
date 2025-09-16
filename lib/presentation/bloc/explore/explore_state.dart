import 'package:equatable/equatable.dart';
import 'package:grocery_go/domain/entities/category_entity.dart';

class ExploreState extends Equatable {
  final bool isLoading;
  final String apiErrorMessage;
  final CategoryEntity? categoryEntity;

  const ExploreState({
    this.isLoading = false,
    this.apiErrorMessage = '',
    this.categoryEntity,
  });

  ExploreState copyWith({
    bool? isLoading,
    String? apiErrorMessage,
    CategoryEntity? categoryEntity,
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
