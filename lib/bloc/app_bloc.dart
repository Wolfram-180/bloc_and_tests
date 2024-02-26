import 'package:bloc_example/bloc/app_state.dart';
import 'package:bloc_example/bloc/bloc_events.dart';
import 'package:bloc_example/secrets.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math' show Random;

typedef AppBlocRandomUrlPicker = String Function(
  Iterable<String> allUrls,
);

typedef AppBlocUrlLoader = Future<Uint8List> Function(String url);

extension RandomElement<T> on Iterable<T> {
  T getRandomElement() => elementAt(Random().nextInt(length));
}

class AppBloc extends Bloc<AppEvent, AppState> {
  String _pickRandomUrl(Iterable<String> allUrls) => allUrls.getRandomElement();

  Future<Uint8List> _loadUrl(String url) => NetworkAssetBundle(
        Uri.parse(
          url,
        ),
      ).load(url).then(
            (byteData) => byteData.buffer.asUint8List(),
          );

  AppBloc({
    required Iterable<String> urls,
    Duration? waitBeforeloading,
    AppBlocRandomUrlPicker? urlPicker,
    AppBlocUrlLoader? urlLoader,
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
            waitBeforeloading ?? const Duration(seconds: 2),
          );

          final data = await (urlLoader ?? _loadUrl)(url);

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
