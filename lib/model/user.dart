class Siswa {
  int? id;
  String name;
  int age;
  String year;

  Siswa({this.id, required this.name, required this.age, required this.year});

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'age': age, 'year': year};
  }

  factory Siswa.fromMap(Map<String, dynamic> map) {
    return Siswa(
      id: map['id'],
      name: map['name'],
      age: map['age'],
      year: map['year'],
    );
  }
}
