import 'package:equatable/equatable.dart';
import 'package:grocery_go/domain/entities/login_entity.dart';

class LoginState extends Equatable {
  final bool isLoading;
  final String apiErrorMessage;
  final LoginEntity? loginEntity;
  final bool isSuccess;
  final bool isHidePass;

  const LoginState({
    this.isLoading = false,
    this.apiErrorMessage = '',
    this.loginEntity,
    this.isSuccess = false,
    this.isHidePass = true,
  });

  copyWith({
    bool? isLoading,
    String? apiErrorMessage,
    LoginEntity? loginEntity,
    bool? isSuccess,
    bool? isHidePass,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      apiErrorMessage: apiErrorMessage ?? this.apiErrorMessage,
      loginEntity: loginEntity ?? this.loginEntity,
      isSuccess: isSuccess ?? this.isSuccess,
      isHidePass: isHidePass ?? this.isHidePass,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    apiErrorMessage,
    loginEntity,
    isSuccess,
    isHidePass,
  ];
}
