// /* 2
import 'dart:convert';
import 'dart:io';
import 'package:bloc_example/bloc/bloc_actions.dart';
import 'package:bloc_example/bloc/person.dart';
import 'package:bloc_example/bloc/persons_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as devtools show log;

extension Log on Object {
  void log() => devtools.log(toString());
}

Future<Iterable<Person>> getPersons(String url) => HttpClient()
    .getUrl(Uri.parse(url))
    .then((request) => request.close())
    .then((response) => response.transform(utf8.decoder).join())
    .then((str) => json.decode(str) as List<dynamic>)
    .then(
        (list) => list.map((e) => Person.fromJson(e as Map<String, dynamic>)));

extension Subscript<T> on Iterable<T> {
  T? operator [](int index) => length > index ? elementAt(index) : null;
}

void main() {
  runApp(
    MaterialApp(
      title: 'Test app',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (_) => PersonsBloc(),
        child: const HomePage(),
      ),
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home page'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => context.read<PersonsBloc>().add(
                      const LoadPersonsAction(
                          url: persons1Url, loader: getPersons),
                    ),
                child: const Text('Load persons 1'),
              ),
              ElevatedButton(
                onPressed: () => context.read<PersonsBloc>().add(
                      const LoadPersonsAction(
                          url: persons2Url, loader: getPersons),
                    ),
                child: const Text('Load persons 2'),
              ),
            ],
          ),
          BlocBuilder<PersonsBloc, FetchResult?>(
            buildWhen: (previousResult, currentResult) {
              return previousResult?.persons != currentResult?.persons;
            },
            builder: ((context, fetchResult) {
              fetchResult?.log();
              final persons = fetchResult?.persons;
              if (persons == null) {
                return const SizedBox();
              }
              return Expanded(
                child: ListView.builder(
                  itemCount: persons.length,
                  itemBuilder: (context, index) {
                    final person = persons[index]!;
                    return ListTile(
                      title: Text(person.name),
                      subtitle: Text('Age: ${person.age}'),
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

// 2 */

/* 1 import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math' as math show Random;

const names = [
  'Hey',
  'Foo',
  'Bar',
  'Baz',
  'Qux',
  'Garply',
  'Waldo',
  'Fred',
  'Plugh',
  'Xyzzy',
  'Thud'
];

extension RandomElement<T> on Iterable<T> {
  T getRandomElement() => elementAt(math.Random().nextInt(length));
}

class NamesCubit extends Cubit<String?> {
  NamesCubit() : super(null);

  void pickRandomName() => emit(names.getRandomElement());
}

void main() {
  runApp(
    MaterialApp(
      title: 'Test app',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final NamesCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = NamesCubit();
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home page'),
      ),
      body: StreamBuilder<String?>(
        stream: cubit.stream,
        builder: (context, snapshot) {
          Widget bodyWdg = Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  snapshot.data ?? 'No name selected',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => cubit.pickRandomName(),
                  child: const Text('Pick a random name'),
                ),
              ],
            ),
          );

          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return bodyWdg;
            case ConnectionState.waiting:
              return bodyWdg;
            case ConnectionState.active:
              return bodyWdg;
            case ConnectionState.done:
              return const SizedBox(height: 16);
          }
        },
      ),
    );
  }
}
 1 */
