// import 'package:path_provider/path_provider.dart';
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
          'CREATE TABLE penghuni(id INTEGER PRIMARY KEY, name TEXT, age TEXT, year TEXT)',
        );
      },
      version: 1,
    );
  }

  static Future<void> registerSiswa(Siswa siswa) async {
    final db = await databaseHelper();
    await db.insert(
      'penghuni',
      siswa.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // static Future<Penghuni?> loginPenghuni(String email, String password) async {
  //   final db = await databaseHelper();
  //   final List<Map<String, dynamic>> results = await db.query(
  //     'penghuni',
  //     where: 'email = ? AND password = ?',
  //     whereArgs: [email, password],
  //   );

  //   if (results.isNotEmpty) {
  //     return Penghuni.fromMap(results.first);
  //   }
  //   return null;
  // }

  static Future<List<Siswa>> getAllPenghuni() async {
    final db = await databaseHelper();
    final List<Map<String, dynamic>> results = await db.query('penghuni');
    return results.map((e) => Siswa.fromMap(e)).toList();
  }

  static Future getAllSiswa() async {}

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
