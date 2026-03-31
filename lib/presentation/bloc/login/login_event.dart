abstract class LoginEvent {}

class OnLoginEvent extends LoginEvent {
  final String username;
  final String password;

  OnLoginEvent({required this.username, required this.password});
}

class OnClearLoginErrorMessageEvent extends LoginEvent {}

class OnTogglePasswordEvent extends LoginEvent {}
