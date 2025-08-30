import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_go/data/datasources/local/secure_storage.dart';
import 'package:grocery_go/data/models/requests/login_schema.dart';
import 'package:grocery_go/di/injector.dart';
import 'package:grocery_go/domain/usecase/login_usecase.dart';
import 'package:grocery_go/presentation/bloc/login/login_event.dart';
import 'package:grocery_go/presentation/bloc/login/login_state.dart';
import 'package:grocery_go/presentation/error/failure_mapper.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUsecase loginUsecase = getIt<LoginUsecase>();
  final SecureStorage secureStorage = getIt<SecureStorage>();
  final FailureMapper _failureMapper;

  LoginBloc(this._failureMapper) : super(LoginState()) {
    on<OnLoginEvent>(_onLoginEvent);
    on<OnClearErrorMessage>(_onClearErrorMessage);
  }

  Future<void> _onLoginEvent(
    OnLoginEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      final result = await loginUsecase.call(
        LoginSchema(username: event.username, password: event.password),
      );
      result.fold(
        (failure) {
          emit(
            state.copyWith(
              apiErrorMessage: _failureMapper.mapFailureToMessage(failure),
            ),
          );
        },
        (data) {
          /// save accesstoken and refresh token
          secureStorage.saveAccessToken(data.accessToken);
          emit(state.copyWith(isSuccess: true));
        },
      );
    } catch (e) {
      emit(state.copyWith(apiErrorMessage: e.toString()));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  void _onClearErrorMessage(
    OnClearErrorMessage event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(apiErrorMessage: ''));
  }
}
