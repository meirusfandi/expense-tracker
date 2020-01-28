import 'dart:io';

import 'package:money_tracker/core/model_db.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Future<Database> database;
  static final Future<Directory> directory = getExternalStorageDirectory();
  static final dbName = "money_tracker.db";
  static final transactionTable = "transaction_table";
  static final transaction_id = "transaction_id";
  static final transaction_type = "transaction_type";
  static final transaction_title = "transaction_title";
  static final transaction_description = "transaction_description";
  static final transaction_mount = "transaction_mount";
  static final transaction_ref_user = "transaction_ref_user";
  static final transaction_created_at = "transaction_created_at";

  static void createDB() async {
    database = openDatabase(
      join((await directory).path, dbName),
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE $transactionTable ("
          "$transaction_id INTEGER PRIMARY KEY AUTOINCREMENT, "
          "$transaction_type TEXT, "
          "$transaction_title TEXT, "
          "$transaction_description TEXT, "
          "$transaction_mount INTEGER, "
          "$transaction_ref_user TEXT, "
          "$transaction_created_at TEXT"
          ")",
        );
      },
      version: 1
    );
  }

  static Future<void> insertData(ModelDB model) async {
    Database db = await database;
    await db.insert(
      transactionTable,
      model.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore
    );
  }

  static Future<List<ModelDB>> getAll() async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(transactionTable, where: "$transaction_type <> ?", whereArgs: ["planning"], orderBy: "$transaction_created_at DESC");
    if (maps.length > 0) {
      return List.generate(
        maps.length,
        (int index) {
          return ModelDB(
            transactionId: maps[index][transaction_id],
            typeTransaction: maps[index][transaction_type],
            title: maps[index][transaction_title],
            description: maps[index][transaction_description],
            totalMount: maps[index][transaction_mount],
            refUser: maps[index][transaction_ref_user],
            createdAt: maps[index][transaction_created_at]
          );
        }
      );
    } else {
      return null;
    }
  }

  static Future<List<ModelDB>> getPlanning() async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(transactionTable, where: "$transaction_type = ?", whereArgs: ["planning"], orderBy: "$transaction_created_at DESC");
    if (maps.length > 0) {
      return List.generate(
        maps.length,
        (int index) {
          return ModelDB(
            transactionId: maps[index][transaction_id],
            typeTransaction: maps[index][transaction_type],
            title: maps[index][transaction_title],
            description: maps[index][transaction_description],
            totalMount: maps[index][transaction_mount],
            refUser: maps[index][transaction_ref_user],
            createdAt: maps[index][transaction_created_at]
          );
        }
      );
    } else {
      return null;
    }
  }

  static Future<ModelDB> get(int id) async{
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      transactionTable,
      where: "$transaction_id = ?",
      whereArgs: [id]
    );
    if (maps.length == 1) {
      return ModelDB(
        transactionId: maps[0][transaction_id],
        typeTransaction: maps[0][transaction_type],
        title: maps[0][transaction_title],
        description: maps[0][transaction_description],
        totalMount: maps[0][transaction_mount],
        refUser: maps[0][transaction_ref_user],
        createdAt: maps[0][transaction_created_at]
      );
    } else {
      return null;
    }
  }

  static Future<void> update(ModelDB model) async {
    Database db = await database;
    await db.update(
      transactionTable, 
      model.toMap(),
      where: "$transaction_id = ?",
      whereArgs: [model.transactionId]
    );
  }

  static Future<void> delete(int id) async {
    Database db = await database;
    await db.delete(
      transactionTable,
      where: "$transaction_id = ?",
      whereArgs: [id]
    );
  }
}