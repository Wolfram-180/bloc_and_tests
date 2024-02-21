import 'package:bloc_example/bloc/person.dart';
import 'package:bloc_example/bloc/persons_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:bloc_example/bloc/bloc_actions.dart';

const mockedPerson1 = [
  Person(
    age: 20,
    name: 'Foo1',
  ),
  Person(
    age: 30,
    name: 'Bar1',
  ),
];

const mockedPerson2 = [
  Person(
    age: 25,
    name: 'Foo2',
  ),
  Person(
    age: 35,
    name: 'Bar2',
  ),
];

Future<Iterable<Person>> mockGetPersons1(String _) =>
    Future.value(mockedPerson1);

Future<Iterable<Person>> mockGetPersons2(String _) =>
    Future.value(mockedPerson2);

void main() {
  group(
    'Testing bloc',
    () {
      late PersonsBloc bloc;

      setUp(
        () {
          bloc = PersonsBloc();
        },
      );

// test initial null state
      blocTest<PersonsBloc, FetchResult?>(
        'Test initial state',
        build: () => bloc,
        verify: (bloc) => expect(
          bloc.state,
          null,
        ),
      );

// fetch mock data (persons1) and compare it with FetchResult
      blocTest<PersonsBloc, FetchResult?>(
        'Mock retrieving persons from first iterable',
        build: () => bloc,
        act: (bloc) {
          bloc.add(
            const LoadPersonsAction(
              url: 'dummy_url_1',
              loader: mockGetPersons1,
            ),
          );
          bloc.add(
            const LoadPersonsAction(
              url: 'dummy_url_1',
              loader: mockGetPersons1,
            ),
          );
        },
        expect: () => [
          const FetchResult(
            persons: mockedPerson1,
            isRetrievedFromCache: false,
          ),
          const FetchResult(
            persons: mockedPerson1,
            isRetrievedFromCache: true,
          ),
        ],
      );

// fetch mock data (persons2) and compare it with FetchResult
      blocTest<PersonsBloc, FetchResult?>(
        'Mock retrieving persons from second iterable',
        build: () => bloc,
        act: (bloc) {
          bloc.add(
            const LoadPersonsAction(
              url: 'dummy_url_2',
              loader: mockGetPersons2,
            ),
          );
          bloc.add(
            const LoadPersonsAction(
              url: 'dummy_url_2',
              loader: mockGetPersons2,
            ),
          );
        },
        expect: () => [
          const FetchResult(
            persons: mockedPerson2,
            isRetrievedFromCache: false,
          ),
          const FetchResult(
            persons: mockedPerson2,
            isRetrievedFromCache: true,
          ),
        ],
      );
    },
  );
}
