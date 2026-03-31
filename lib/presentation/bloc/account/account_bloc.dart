import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_go/di/injector.dart';
import 'package:grocery_go/domain/core/usecase.dart';
import 'package:grocery_go/domain/usecase/get_user_info_usecase.dart';
import 'package:grocery_go/presentation/bloc/account/account_event.dart';
import 'package:grocery_go/presentation/bloc/account/account_state.dart';
import 'package:grocery_go/presentation/error/failure_mapper.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final GetUserInfoUsecase getUserInfoUsecase = getIt<GetUserInfoUsecase>();
  final FailureMapper _failureMapper;

  AccountBloc(this._failureMapper) : super(AccountState()) {
    on<OnGetUserInfoEvent>(_onGetUserInfoEvent);
    on<OnClearAccountErrorEvent>(_onClearErrorMessage);
    add(OnGetUserInfoEvent());
  }

  Future<void> _onGetUserInfoEvent(
    OnGetUserInfoEvent event,
    Emitter<AccountState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      final result = await getUserInfoUsecase.call(NoParams());
      result.fold(
        (failure) {
          emit(
            state.copyWith(
              apiErrorMessage: _failureMapper.mapFailureToMessage(failure),
            ),
          );
        },
        (data) {
          emit(state.copyWith(userInfoEntity: data));
        },
      );
    } catch (e) {
      emit(state.copyWith(apiErrorMessage: e.toString()));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  void _onClearErrorMessage(
    OnClearAccountErrorEvent event,
    Emitter<AccountState> emit,
  ) {
    emit(state.copyWith(apiErrorMessage: ''));
  }
}
