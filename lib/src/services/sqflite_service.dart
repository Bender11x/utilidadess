import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:utilidades/src/models/person_model.dart';

class SqfliteService {
  static final SqfliteService _instance = SqfliteService._internal();
  factory SqfliteService() => _instance;
  SqfliteService._internal();

  static Database? _db;

  Future<Database> get database async {
    _db ??= await _initDB('app.db');
    return _db!;
  }

  Future<Database> _initDB(String name) async {
    final path = join(await getDatabasesPath(), name);
    return openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE produtos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT,
        preco REAL,
        descricao TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE pessoas (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT,
        idade INTEGER
      )
    ''');
  }

  Future<int> insertPerson(PersonModel person) async {
    final database = await this.database;
    return await database.insert('pessoas', person.toMap());
  }

  Future<List<PersonModel>> getAllPersons() async {
    final database = await this.database;
    final result = await database.query('pessoas');
    return result.map((e) => PersonModel.fromMap(e)).toList();
  }

  Future<void> deletePerson(int id) async {
    final database = await this.database;
    await database.delete(
      'pessoas',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
