import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class AppAction {
  const AppAction();
}

@immutable
class LoginAction implements AppAction {
  const LoginAction({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;
}

@immutable
class LoadNotesAction implements AppAction {
  const LoadNotesAction();
}
