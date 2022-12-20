import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:projet_final_appmobile/src/data/entities/categorie_entity.dart';

class CategorieService {
  Future<Database>? database;
  static const String databasePath = 'projet_final_appmobile.db';
  static const String tableCategorieName = 'Categorie';
  ScoreService() {
    WidgetsFlutterBinding.ensureInitialized();
  }

  Future<Database> getDatabaseInstance() async {
    database ??= openDatabase(
      join(await getDatabasesPath(), databasePath),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE IF NOT EXISTS $tableCategorieName(id INTEGER PRIMARY KEY,nom VARCHAR(50))",
        );
      },
      version: 2,
    );

    return database!;
  }

  Future<void> insertCategorie(CategorieEntity categorie) async {
    // Get a reference to the database.
    final Database db = await getDatabaseInstance();

    await db.insert(
      tableCategorieName,
      categorie.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<CategorieEntity>> getCategories() async {
    final Database db = await getDatabaseInstance();

    final List<Map<String, dynamic>> maps = await db.query(tableCategorieName);

    return List.generate(maps.length, (i) {
      return CategorieEntity.FromMap(maps[i]);
    });
  }

  Future<void> deleteCategorie(int id) async {
    final db = await getDatabaseInstance();

    await db.delete(
      tableCategorieName,
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
