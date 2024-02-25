import 'package:bloc_example/bloc/app_bloc.dart';

class TopBloc extends AppBloc {
  TopBloc({
    Duration? waitBeforeloading,
    required Iterable<String> urls,
  }) : super(
          waitBeforeloading: waitBeforeloading,
          urls: urls,
        );
}
