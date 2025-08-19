import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tugas13_flutter/model/user.dart';

class DbHelper {
  static Future<Database> databaseHelper() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'siswa.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE siswa(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, age INT, year TEXT)',
        );
      },
      version: 1,
    );
  }

  static Future<void> registerSiswa(Siswa siswa) async {
    final db = await databaseHelper();
    await db.insert(
      'siswa',
      siswa.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Siswa>> getAllSiswa() async {
    final db = await databaseHelper();
    final List<Map<String, dynamic>> results = await db.query('siswa');
    return results.map((e) => Siswa.fromMap(e)).toList();
  }

  static Future<void> updateSiswa(Siswa siswa) async {
    final db = await databaseHelper();
    await db.update(
      'siswa',
      siswa.toMap(),
      where: 'id = ?',
      whereArgs: [siswa.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> deleteSiswa(int id) async {
    final db = await databaseHelper();
    await db.delete('siswa', where: 'id = ?', whereArgs: [id]);
  }
}
