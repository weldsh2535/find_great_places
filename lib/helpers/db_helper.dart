// ignore: import_of_legacy_library_into_null_safe
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class DbHelper {
  static Future<Database> database() async {
    final dbpath = await sql.getDatabasesPath();

    return sql.openDatabase(path.join(dbpath, 'places.db'), version: 1,
        onCreate: (db, version) {
      db.execute(
          'CREATE TABLE places(id TEXT PRIMARY KEY, title TEXT, image TEXT)');
    });
  }

  static Future<void> insert(String table, Map<String, dynamic> data) async {
    final db = await DbHelper.database();
    db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

static Future<List<Map<String,dynamic>>> fetchDb(String table)async{
  final db= await DbHelper.database();
  return db.query(table);
}

}
