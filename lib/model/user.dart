import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Siswa {
  final int? id;
  final String name;
  final String age;
  final String year;
  Siswa({this.id, required this.name, required this.age, required this.year});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id, 'name': name, 'age': age, 'year': year};
  }

  factory Siswa.fromMap(Map<String, dynamic> map) {
    return Siswa(
      id: map['id'] as int,
      name: map['name'] as String,
      age: map['age'] as String,
      year: map['year'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Siswa.fromJson(String source) =>
      Siswa.fromMap(json.decode(source) as Map<String, dynamic>);
}
