import 'package:bloc/bloc.dart';
import 'package:bloc_example/apis/login_api.dart';
import 'package:bloc_example/apis/notes_api.dart';
import 'package:bloc_example/bloc/actions.dart';
import 'package:bloc_example/bloc/app_state.dart';
import 'package:bloc_example/models.dart';

class AppBloc extends Bloc<AppAction, AppState> {
  final LoginApiProtocol loginApi;
  final NotesApiProtocol notesApi;

  AppBloc({
    required this.loginApi,
    required this.notesApi,
  }) : super(const AppState.empty()) {
    on<LoginAction>(
      (event, emit) async {
        // start loading
        emit(
          const AppState(
            isLoading: true,
            loginError: null,
            loginHandle: null,
            fetchedNotes: null,
          ),
        );
        // log the user in
        final loginHandle = await loginApi.login(
          email: event.email,
          password: event.password,
        );
        emit(
          AppState(
            isLoading: false,
            loginError: loginHandle == null ? LoginErrors.invalidHandle : null,
            loginHandle: loginHandle,
            fetchedNotes: null,
          ),
        );
      },
    );
  }
}
