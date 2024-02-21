import 'package:flutter/foundation.dart' show immutable;

@immutable
class Person {
  const Person({required this.name, required this.age});

  final String name;
  final int age;

  Person.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        age = json['age'] as int;

  @override
  String toString() => 'Person: name: $name, age: $age';
}
