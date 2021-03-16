import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_finans/models/expense.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper.internal();
      return _databaseHelper;
    } else {
      return _databaseHelper;
    }
  }

  DatabaseHelper.internal();

  Future<Database> _getDatabase() async {
    if (_database == null) {
      _database = await _initializeDatabase();
      return _database;
    } else {
      return _database;
    }
  }

  //asset'ten db dosyası okuma
  Future<Database> _initializeDatabase() async {
    Database _db;

    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "transactions.db");

    // Check if the database exists
    var exists = await databaseExists(path);

    if (!exists) {
      // Should happen only the first time you launch your application
      print("Creating new copy from asset");

      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      ByteData data = await rootBundle.load(join("asset", "transactions.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      print("Opening existing database");
    }
    // open the database
    _db = await openDatabase(path, readOnly: false);
    return _db;
  }

  //BASIC CRUD
  //
  Future<List<Map<String, dynamic>>> getExpense() async {
    var db = await _getDatabase();
    var result = await db.rawQuery(
        "select sum(value) as 'value',category from Expense group by category");
    return result;
  }

  Future<List<Map<String, dynamic>>> getAll(String date) async {
    var db = await _getDatabase();
    print("db ye gelen tarih : $date");
    var result =
        await db.rawQuery('SELECT * FROM Expense WHERE currentDate=?', [date]);
    return result;
  }

  Future<List<Expense>> getExpenseList() async {
    var mapList = await getExpense();
    var list = List<Expense>();
    for (Map map in mapList) {
      list.add(Expense.FromMap(map));
    }
    return list;
  }

  Future<int> transactionAdd(Expense expense) async {
    var db = await _getDatabase();
    var result = await db.insert("Expense", expense.toMap());
    return result;
  }
}
