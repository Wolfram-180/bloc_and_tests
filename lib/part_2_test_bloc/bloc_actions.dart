import 'package:bloc_example/part_2_test_bloc/person.dart';
import 'package:flutter/foundation.dart' show immutable;

const persons1Url = 'http://127.0.0.1:5500/api/persons1.json';
const persons2Url = 'http://127.0.0.1:5500/api/persons2.json';

typedef PersonsLoader = Future<Iterable<Person>> Function(String url);

enum PersonUrl {
  persons1,
  persons2,
}

extension UrlString on PersonUrl {
  String get urlString {
    switch (this) {
      case PersonUrl.persons1:
        return 'http://127.0.0.1:5500/api/persons1.json';
      case PersonUrl.persons2:
        return 'http://127.0.0.1:5500/api/persons2.json';
    }
  }
}

@immutable
abstract class LoadAction {
  const LoadAction();
}

@immutable
class LoadPersonsAction extends LoadAction {
  const LoadPersonsAction({
    required this.url,
    required this.loader,
  }) : super();

  final String url;
  final PersonsLoader loader;
}
