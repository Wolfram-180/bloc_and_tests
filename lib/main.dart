import 'package:flutter/material.dart';

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

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home page'),
      ),
    );
  }
}







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