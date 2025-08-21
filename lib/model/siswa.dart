import 'dart:convert';

class Siswa {
  int? id;
  String name;
  int no;
  String year;
  Siswa({this.id, required this.name, required this.no, required this.year});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id, 'name': name, 'no': no, 'year': year};
  }

  factory Siswa.fromMap(Map<String, dynamic> map) {
    return Siswa(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] as String,
      no: map['no'] as int,
      year: map['year'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Siswa.fromJson(String source) =>
      Siswa.fromMap(json.decode(source) as Map<String, dynamic>);
}
