import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlManager {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initalDb();
      return _db;
    } else {
      return _db;
    }
  }

  Future<Database> initalDb() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'note.db');
    Database mydb = await openDatabase(path, onCreate: onCreatedb, version: 1);
    return mydb;
  }

  Future onCreatedb(Database db, int version) async {
    await db.execute('''
    CREATE TABLE notes (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      note TEXT NOT NULL,
      checkStatus INTEGER DEFAULT 0
    )
  ''');
    print('================== secssfule ==================');
  }

  Future<int> insertNote(String note) async {
    final mydb = await db;

    final data = {'note': note};

    return await mydb!.insert('notes', data);
  }

  Future<int> updateCheck(int id, int checkStatus) async {
    final mydb = await db;

    return await mydb!.update(
      'notes',
      {'checkStatus': checkStatus}, // تحديث check فقط
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteNote(int id) async {
    final mydb = await db;

    return await mydb!.delete('notes', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> getAllNotes() async {
    final mydb = await db;
    return await mydb!.query('notes');
  }
}
