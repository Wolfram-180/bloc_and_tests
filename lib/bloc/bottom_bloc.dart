import 'package:bloc_example/bloc/app_bloc.dart';

class BottomBloc extends AppBloc {
  BottomBloc({
    Duration? waitBeforeloading,
    required Iterable<String> urls,
  }) : super(
          waitBeforeloading: waitBeforeloading,
          urls: urls,
        );
}
