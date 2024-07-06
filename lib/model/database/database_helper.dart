import 'package:schedule_app_flutter/model/data/schedule.dart';
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
    try {
      String path = join(await getDatabasesPath(), 'schedules.db');
      return await openDatabase(
        path,
        version: 1,
        onCreate: _onCreate,
      );
    } catch (e) {
      print('Error initializing database: $e');
      rethrow; // Rethrow the error to be caught by the caller
    }
  }

  Future<void> _onCreate(Database db, int version) async {
    try {
      await db.execute('''
        CREATE TABLE schedules (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          scheduleName TEXT,
          day INTEGER,
          startTime TEXT,
          endTime TEXT,
          note TEXT
        )
      ''');
    } catch (e) {
      print('Error creating table: $e');
      rethrow; // Rethrow the error to be caught by the caller
    }
  }

  Future<void> insertSchedule(Schedule schedule) async {
    try {
      final db = await database;
      await db.insert(
        'schedules',
        schedule.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print('Error inserting schedule: $e');
      rethrow; // Rethrow the error to be caught by the caller
    }
  }

  Future<void> updateSchedule(Schedule schedule) async {
    try {
      final db = await database;
      await db.update(
        'schedules',
        schedule.toMap(),
        where: 'id = ?',
        whereArgs: [schedule.id],
      );
    } catch (e) {
      print('Error updating schedule: $e');
      rethrow; // Rethrow the error to be caught by the caller
    }
  }

  Future<void> deleteSchedule(String id) async {
    try {
      final db = await database;
      await db.delete(
        'schedules',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      print('Error deleting schedule: $e');
      rethrow; // Rethrow the error to be caught by the caller
    }
  }

  Future<List<Schedule>> getAllSchedule() async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query('schedules');
      return List<Schedule>.from(maps.map((map) => Schedule.fromMap(map)));
    } catch (e) {
      print('Error retrieving schedules: $e');
      rethrow; // Rethrow the error to be caught by the caller
    }
  }
}
