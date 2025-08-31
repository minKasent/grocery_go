import 'package:flutter/cupertino.dart';
import 'package:grocery_go/domain/core/failures.dart';
import 'package:grocery_go/l10n/app_localizations.dart';

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
}
