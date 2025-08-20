import 'dart:convert';

class Siswa {
  int? id;
  String name;
  int age;
  String year;
  Siswa({this.id, required this.name, required this.age, required this.year});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id, 'name': name, 'age': age, 'year': year};
  }

  factory Siswa.fromMap(Map<String, dynamic> map) {
    return Siswa(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] as String,
      age: map['age'] as int,
      year: map['year'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Siswa.fromJson(String source) =>
      Siswa.fromMap(json.decode(source) as Map<String, dynamic>);
}
