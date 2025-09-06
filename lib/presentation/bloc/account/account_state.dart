import 'package:equatable/equatable.dart';
import 'package:grocery_go/domain/entities/user_info_entity.dart';

class AccountState extends Equatable {
  final bool isLoading;
  final String apiErrorMessage;
  final UserInfoEntity? userInfoEntity;

  const AccountState({
    this.isLoading = false,
    this.apiErrorMessage = '',
    this.userInfoEntity,
  });

  copyWith({
    bool? isLoading,
    String? apiErrorMessage,
    UserInfoEntity? userInfoEntity,
  }) {
    return AccountState(
      isLoading: isLoading ?? this.isLoading,
      apiErrorMessage: apiErrorMessage ?? this.apiErrorMessage,
      userInfoEntity: userInfoEntity ?? this.userInfoEntity,
    );
  }

  @override
  List<Object?> get props => [isLoading, apiErrorMessage, userInfoEntity];
}
