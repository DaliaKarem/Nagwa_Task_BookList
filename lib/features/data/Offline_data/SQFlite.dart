import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';

import '../../model/BookModel.dart';

class SQFlite {
  static Database? _db;
  static bool _isInitialized = false;

  Future<Database?> get db async {
    if (!_isInitialized || _db == null) {
      print("Initializing DB...");
      await _initDatabase();
      _isInitialized = true;
    }
    return _db;
  }

  Future<void> _initDatabase() async {
    try {
      if (_db != null) {
        await _db!.close();
      }

      final dir = await getDatabasesPath();
      final path = join(dir, "Books.db");
      _db = await openDatabase(
        path,
        version: 16,
        onCreate: _onCreate,
        onUpgrade: _onUpgrade,
      );
    } catch (e) {
      print("Database initialization failed: $e");
      rethrow;
    }
  }

  Future<void> close() async {
    if (_db != null) {
      await _db!.close();
      _db = null;
    }
    _isInitialized = false;
  }
  Future<void> _onCreate(Database database, int version) async {
    print("Create DB");
    await database.execute('''
    CREATE TABLE Books (
      id INTEGER PRIMARY KEY,
      title TEXT NOT NULL,
      authors TEXT NOT NULL,
      summaries TEXT,
      subjects TEXT,
      bookshelves TEXT,
      languages TEXT,
      copyright INTEGER,
      media_type TEXT,
      formats TEXT,
      download_count INTEGER
    )
  ''');
    print("Books table created successfully");

    //        created_at INTEGER DEFAULT (strftime('%s', 'now'))
  }

  Future<void> _onUpgrade(
      Database database, int oldVersion, int newVersion) async {
    print("Drop");
   //  final dir=await getDatabasesPath();
   //  final path=join(dir,"Books.db");
   //  return await deleteDatabase(path);
  }

  Future<List<Map<String, dynamic>>> read(String sql) async {
    final db = await this.db;
    return await db!.rawQuery(sql);
  }

  Future<void> insert(List<BookModel> books) async {
    print("Add $books to my DB");
    final db = await this.db;
    try {
      await db!.transaction((txn) async {
        for (var book in books) {
          await txn.insert(
            'Books',
            book.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }
      });
      print("Successfully inserted ${books.length} books");
    } catch (e) {
      print("Error inserting books: $e");
      rethrow;
    }
  }

  Future<int> update(String sql) async {
    final db = await this.db;
    return await db!.rawUpdate(sql);
  }

  Future<int> delete(String sql) async {
    final db = await this.db;
    return await db!.rawDelete(sql);
  }

  Future<List<BookModel>> getAllBooks() async {
    print("Get All Books");
    final db = await this.db;
    final List<Map<String, dynamic>> maps = await db!.query("Books");
    print("maps   $maps              ${List.generate(maps.length, (i) => BookModel.fromJson(maps[i]))}");
    return List.generate(maps.length, (i) => BookModel.fromJson(maps[i]));
  }

  Future<List<BookModel>> searchBooks(String query) async {
    if (query.isEmpty) return []; // Handle empty query

    final db = await this.db;
    try {
      final results = await db!.query(
        "Books",
        where: 'title LIKE ? OR subjects LIKE ?',
        whereArgs: ['%$query%', '%$query%'],
      );

      return results.map((map) => BookModel.fromJson(map)).toList();
    } catch (e) {
      print(e);
      return [];
    }
  }
}
