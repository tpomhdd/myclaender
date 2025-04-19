import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'prayer_times.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE prayer_times(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        time TEXT
      )
    ''');
  }

  Future<void> insertPrayerTime(String name, String time) async {
    final db = await database;
    await db.insert(
      'prayer_times',
      {'name': name, 'time': time},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<String?> getPrayerTime(String name) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'prayer_times',
      where: 'name = ?',
      whereArgs: [name],
    );

    if (maps.isNotEmpty) {
      return maps.first['time'] as String?;
    }
    return null;
  }

  Future<void> updatePrayerTime(String name, String time) async {
    final db = await database;
    await db.update(
      'prayer_times',
      {'time': time},
      where: 'name = ?',
      whereArgs: [name],
    );
  }
}