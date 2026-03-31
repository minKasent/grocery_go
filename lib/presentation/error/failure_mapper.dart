import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery_go/data/datasources/local/secure_storage.dart';
import 'package:grocery_go/di/injector.dart';
import 'package:grocery_go/domain/core/failures.dart';
import 'package:grocery_go/l10n/app_localizations.dart';
import 'package:grocery_go/presentation/routes/route_name.dart';

/// Maps the failure to a message for the user
/// This is used to show the suer a message about the failure
/// This is used in the UI layer

class FailureMapper {
  final BuildContext context;
  const FailureMapper(this.context);

  String mapFailureToMessage(Failure failure) {
    switch (failure) {
      case NetworkFailure():
        return AppLocalizations.of(context).getStarted;
      case ServerFailure():
        return AppLocalizations.of(context).getStarted;
      case CacheFailure():
        return AppLocalizations.of(context).getStarted;
      case UnauthorizedFailure():
        _navigateToLoginScreen();
        return AppLocalizations.of(context).getStarted;
      case ForbiddenFailure():
        return AppLocalizations.of(context).getStarted;
      case NoInternetConnectionFailure():
        return AppLocalizations.of(context).getStarted;
      case UnknownFailure():
        return AppLocalizations.of(context).getStarted;
      default:
        return AppLocalizations.of(context).getStarted;
    }
  }

  void _navigateToLoginScreen() {
    getIt<SecureStorage>().saveAccessToken('');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.go(RouteName.login);
    });
  }
}
