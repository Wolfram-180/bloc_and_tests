import 'package:bloc_example/apis/login_api.dart';
import 'package:bloc_example/apis/notes_api.dart';
import 'package:bloc_example/bloc/app_bloc.dart';
import 'package:bloc_example/bloc/app_state.dart';
import 'package:bloc_example/part_2_test_bloc/person.dart';
import 'package:bloc_example/part_2_test_bloc/persons_bloc.dart';
import 'package:bloc_example/strings.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:bloc_example/part_2_test_bloc/bloc_actions.dart';
import 'package:bloc_example/models.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:collection/collection.dart';

const Iterable<Note> mockNotes = [
  Note(title: 'Note 1'),
  Note(title: 'Note 2'),
  Note(title: 'Note 3'),
];

@immutable
class DummyNotesApi implements NotesApiProtocol {
  final LoginHandle acceptedLoginHandle;
  final Iterable<Note>? notesToReturnForAcceptedLoginHandle;

  const DummyNotesApi({
    required this.acceptedLoginHandle,
    required this.notesToReturnForAcceptedLoginHandle,
  });

  const DummyNotesApi.empty()
      : acceptedLoginHandle = const LoginHandle.fooBar(),
        notesToReturnForAcceptedLoginHandle = null;

  @override
  Future<Iterable<Note>?> getNotes({
    required LoginHandle loginHandle,
  }) async {
    if (loginHandle == acceptedLoginHandle) {
      return notesToReturnForAcceptedLoginHandle;
    } else {
      return null;
    }
  }
}

@immutable
class DummyLoginApi implements LoginApiProtocol {
  final String acceptedEmail;
  final String acceptedPassword;

  const DummyLoginApi({
    required this.acceptedEmail,
    required this.acceptedPassword,
  });

  const DummyLoginApi.empty()
      : acceptedEmail = '',
        acceptedPassword = '';

  @override
  Future<LoginHandle?> login({
    required String email,
    required String password,
  }) async {
    if (email == acceptedEmail && password == acceptedPassword) {
      return const LoginHandle.fooBar();
    } else {
      return null;
    }
  }
}

void main() {
  blocTest(
    'initial state of the bloc should be AppState.empty()',
    build: () => AppBloc(
      loginApi: const DummyLoginApi.empty(),
      notesApi: const DummyNotesApi.empty(),
    ),
    verify: (appState) => expect(
      appState.state,
      const AppState.empty(),
    ),
  );
}
