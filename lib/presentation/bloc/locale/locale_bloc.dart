import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_go/core/logging/app_logger.dart';
import 'package:grocery_go/data/datasources/local/secure_storage.dart';
import 'package:grocery_go/di/injector.dart';
import 'package:grocery_go/presentation/bloc/locale/locale_event.dart';
import 'package:grocery_go/presentation/bloc/locale/locale_state.dart';

class LocaleBloc extends Bloc<LocaleEvent, LocaleState> {
  final SecureStorage secureStorage = getIt<SecureStorage>();

  LocaleBloc() : super(LocaleState()) {
    on<OnChangeLocaleEvent>(_onChangeLocaleEvent);
    on<OnInitLocaleEvent>(_onInitLocaleEvent);
    add(OnInitLocaleEvent());
  }

  Future<void> _onInitLocaleEvent(
    OnInitLocaleEvent event,
    Emitter<LocaleState> emit,
  ) async {
    try {
      final locale = await secureStorage.getLocale();
      if (locale != null) {
        emit(LocaleState(locale: locale));
      }
    } catch (e, stackTrace) {
      getIt<AppLogger>().e(
        'Error init locale',
        error: e,
        stackTrace: stackTrace,
        meta: {
          'action': "_onInitLocaleEvent",
          'error': e,
          'stackTrace': stackTrace,
        },
      );
    }
  }

  Future<void> _onChangeLocaleEvent(
    OnChangeLocaleEvent event,
    Emitter<LocaleState> emit,
  ) async {
    try {
      await secureStorage.saveLocale(event.locale);
      emit(LocaleState(locale: event.locale));
    } catch (e, stackTrace) {
      getIt<AppLogger>().e(
        'Error on change locale',
        error: e,
        stackTrace: stackTrace,
        meta: {
          'action': "_onChangeLocaleEvent",
          'error': e,
          'stackTrace': stackTrace,
        },
      );
    }
  }
}
