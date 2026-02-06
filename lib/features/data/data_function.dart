import 'package:sql_homework/core/database/sql_manager.dart';

import 'app_data.dart';

class DataFunction {
  final SqlManager sql = SqlManager();
  List<AppData> notes = [];

  Future<void> refreshNotes() async {
    final data = await sql.getAllNotes();
    notes = data.map((map) => AppData.fromMap(map)).toList();
  }

  Future<void> addNote(String text) async {
    if (text.isEmpty) return;
    await sql.insertNote(text);
    await refreshNotes();
  }

  Future<void> deleteNote(int id) async {
    await sql.deleteNote(id);
    await refreshNotes();
  }

  Future<void> updateCheck(AppData note, int newValue) async {
    await sql.updateCheck(note.id, newValue);
    await refreshNotes();
  }
}
