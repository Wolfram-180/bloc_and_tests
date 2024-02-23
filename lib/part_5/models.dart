import 'package:flutter/foundation.dart' show immutable;

@immutable
class LoginHandle {
  const LoginHandle({
    required this.token,
  });

  final String token;

  const LoginHandle.fooBar() : token = 'foobar';

  @override
  bool operator ==(covariant LoginHandle other) => token == other.token;

  @override
  int get hashCode => token.hashCode;

  @override
  String toString() => 'LoginHandle (token: $token)';
}

enum LoginErrors {
  invalidHandle,
  serverError,
  unknown,
}

@immutable
class Note {
  final String title;

  const Note({required this.title});

  @override
  String toString() => 'Note (title: $title)';
}

final mockNotes = Iterable.generate(
  3,
  (i) => Note(
    title: 'Note ${i + 1}',
  ),
);
