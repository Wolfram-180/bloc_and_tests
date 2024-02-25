import 'package:bloc_example/bloc/app_state.dart';
import 'package:bloc_example/bloc/bloc_events.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc()
      : super(
          const AppState.empty(),
        );
}
