import 'package:bloc_example/bloc/app_bloc.dart';
import 'package:bloc_example/bloc/app_state.dart';
import 'package:bloc_example/bloc/bloc_events.dart';
import 'package:bloc_example/extensions/stream/start_with.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocView<T extends AppBloc> extends StatelessWidget {
  const AppBlocView({super.key});

  void startUpdatingBloc(BuildContext context) {
    Stream.periodic(
      const Duration(seconds: 10),
      (_) => const LoadNextUrlEvent(),
    )
        .startWith(
      const LoadNextUrlEvent(),
    )
        .forEach((event) {
      context.read<T>().add(
            event,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    startUpdatingBloc(context);
    return Expanded(
      child: BlocBuilder<T, AppState>(
        builder: (context, appState) {
          if (appState.error != null) {
            // error happened
            return const Text(
              'Error occured, try later!',
            );
          } else if (appState.data != null) {
            // have data
            return Image.memory(
              appState.data!,
              fit: BoxFit.fitHeight,
            );
          } else {
            // loading
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
