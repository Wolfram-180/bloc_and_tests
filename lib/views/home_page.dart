import 'package:bloc_example/bloc/bottom_bloc.dart';
import 'package:bloc_example/bloc/top_bloc.dart';
import 'package:bloc_example/models/constants.dart';
import 'package:bloc_example/views/app_bloc_view.dart';
import 'package:flutter/material.dart';
import 'package:bloc_example/bloc/app_bloc.dart';
import 'package:bloc_example/bloc/app_state.dart';
import 'package:bloc_example/bloc/bloc_events.dart';
import 'package:bloc_example/extensions/stream/start_with.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart' show SystemUiOverlayStyle;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: MultiBlocProvider(
          providers: [
            BlocProvider<TopBloc>(
              create: (_) => TopBloc(
                waitBeforeloading: const Duration(
                  seconds: 3,
                ),
                urls: images,
              ),
            ),
            BlocProvider<BottomBloc>(
              create: (_) => BottomBloc(
                waitBeforeloading: const Duration(
                  seconds: 3,
                ),
                urls: images,
              ),
            ),
          ],
          child: const Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              AppBlocView<TopBloc>(),
              AppBlocView<BottomBloc>(),
            ],
          ),
        ),
      ),
    );
  }
}
