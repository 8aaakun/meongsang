import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class SaveRecord {
  static final SaveRecord instance = SaveRecord._init();

  static Database? _database;

  SaveRecord._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('entries.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE entries (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        date TEXT NOT NULL,
        subject TEXT NOT NULL,
        review TEXT NOT NULL
      )
    ''');
  }

  // 날짜, 주제, 감상글 저장
  Future<int> insertEntry(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert('entries', row);
  }

  //  저장한 감상글 리스트 불러오기
  Future<List<Map<String, dynamic>>> queryAllEntries() async {
    Database db = await instance.database;
    return await db.query('entries');
  }
}
