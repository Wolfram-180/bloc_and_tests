import 'package:bloc_example/bloc/app_bloc.dart';
import 'package:bloc_example/bloc/app_state.dart';
import 'package:bloc_example/bloc/bloc_events.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'dart:typed_data' show Uint8List;

extension ToList on String {
  Uint8List toUint8List() => Uint8List.fromList(
        codeUnits,
      );
}

final text1Data = 'text1'.toUint8List();
final text2Data = 'text2'.toUint8List();

void main() {
  blocTest<AppBloc, AppState>(
    'Initial state should be empty',
    build: () => AppBloc(
      urls: [],
    ),
    verify: (appBloc) => expect(
      appBloc.state,
      const AppState.empty(),
    ),
  );

  // load valid data and compare states
  blocTest<AppBloc, AppState>(
    'Initial state should be empty',
    build: () => AppBloc(
      urls: [],
      urlPicker: (_) => '',
      urlLoader: (_) => Future.value(text1Data),
    ),
    act: (appBloc) => appBloc.add(
      const LoadNextUrlEvent(),
    ),
    expect: () => [
      const AppState(
        isLoading: true,
        data: null,
        error: null,
      ),
      AppState(
        isLoading: false,
        data: text1Data,
        error: null,
      ),
    ],
  );

// test throwing an error from url loader
  blocTest<AppBloc, AppState>(
    'Initial state should be empty',
    build: () => AppBloc(
      urls: [],
      urlPicker: (_) => '',
      urlLoader: (_) => Future.value(text1Data),
    ),
    act: (appBloc) => appBloc.add(
      const LoadNextUrlEvent(),
    ),
    expect: () => [
      const AppState(
        isLoading: true,
        data: null,
        error: null,
      ),
      AppState(
        isLoading: false,
        data: text1Data,
        error: null,
      ),
    ],
  );
}
