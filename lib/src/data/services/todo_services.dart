import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:projet_final_appmobile/src/data/entities/todo_entity.dart';

class TodoService {
  Future<Database>? database;
  static const String databasePath = 'projet_final_appmobile.db';
  static const String tableTodoName = 'Todo';
  TodoService() {
    WidgetsFlutterBinding.ensureInitialized();
  }

  Future<Database> getDatabaseInstance() async {
    database ??= openDatabase(
      join(await getDatabasesPath(), databasePath),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE IF NOT EXISTS $tableTodoName(id INTEGER PRIMARY KEY, categorieId INTEGER, nom VARCHAR(50), description VARCHAR(50), isDone BOOLEAN)",
        );
      },
      version: 2,
    );

    return database!;
  }

  Future<void> insertTodo(TodoEntity todo) async {
    final Database db = await getDatabaseInstance();

    await db.insert(
      tableTodoName,
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateTodo(TodoEntity todo) async {
    final db = await getDatabaseInstance();

    await db.update(
      tableTodoName,
      todo.toMap(),
      where: "id = ?",
      whereArgs: [todo.id],
    );
  }

  Future<List<TodoEntity>> getTodo() async {
    final Database db = await getDatabaseInstance();

    final List<Map<String, dynamic>> maps = await db.query(tableTodoName);

    return List.generate(maps.length, (i) {
      return TodoEntity.FromMap(maps[i]);
    });
  }

  Future<List<TodoEntity>> getTodoByCategorieId(int categorieid) async {
    final Database db = await getDatabaseInstance();

    final List<Map<String, dynamic>> maps = await db.query(
      tableTodoName,
      where: "categorieId = ?",
      whereArgs: [categorieid],
    );

    return List.generate(maps.length, (i) {
      return TodoEntity.FromMap(maps[i]);
    });
  }

  Future<void> deleteTodo(int id) async {
    final db = await getDatabaseInstance();

    await db.delete(
      tableTodoName,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<void> deleteTodoByCategoryId(int categorieId) async {
    final db = await getDatabaseInstance();

    await db.delete(
      tableTodoName,
      where: "categorieId = ?",
      whereArgs: [categorieId],
    );
  }
}
