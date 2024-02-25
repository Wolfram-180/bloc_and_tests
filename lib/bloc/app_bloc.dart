import 'package:bloc_example/bloc/app_state.dart';
import 'package:bloc_example/bloc/bloc_events.dart';
import 'package:bloc_example/secrets.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math' show Random;

typedef AppBlocRandomUrlPicker = String Function(
  Iterable<String> allUrls,
);

extension RandomElement<T> on Iterable<T> {
  T getRandomElement() => elementAt(Random().nextInt(length));
}

class AppBloc extends Bloc<AppEvent, AppState> {
  String _pickRandomUrl(Iterable<String> allUrls) => allUrls.getRandomElement();

  AppBloc({
    required Iterable<String> urls,
    Duration? waitBeforeloading,
    AppBlocRandomUrlPicker? urlPicker,
  }) : super(
          const AppState.empty(),
        ) {
    on<LoadNextUrlEvent>(
      (event, emit) async {
        // start loading
        emit(
          const AppState(
            isLoading: true,
            data: null,
            error: null,
          ),
        );
        final url = pathToImg + (urlPicker ?? _pickRandomUrl)(urls);
        try {
          // simulate loading
          await Future<void>.delayed(
              waitBeforeloading ?? const Duration(seconds: 2),);
          final bundle = NetworkAssetBundle(
            Uri.parse(
              url,
            ),
          );
          final data = (await bundle.load(
            url,
          ))
              .buffer
              .asUint8List();
          // loading done
          emit(
            AppState(
              isLoading: false,
              data: data,
              error: null,
            ),
          );
        } catch (e) {
          emit(
            AppState(
              isLoading: false,
              data: null,
              error: e,
            ),
          );
        }
      },
    );
  }
}
