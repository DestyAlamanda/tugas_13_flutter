import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tugas13_flutter/model/siswa.dart';
import 'package:tugas13_flutter/model/user.dart';

class DbHelper {
  static Future<Database> databaseHelper() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'siswa.db'),
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE siswa(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, age INT, year TEXT)',
        );
        await db.execute(
          'CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT, phone TEXT, password TEXT)',
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

  static Future<void> registerUser(User user) async {
    final db = await databaseHelper();
    await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<User?> loginSiswa(String phone, String password) async {
    final db = await databaseHelper();
    final List<Map<String, dynamic>> results = await db.query(
      'siswa',
      where: 'phone = ? AND password = ?',
      whereArgs: [phone, password],
    );

    if (results.isNotEmpty) {
      return User.fromMap(results.first);
    }
    return null;
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
