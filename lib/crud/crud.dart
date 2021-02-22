import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todolist/model/class_penangkap.dart';

class CRUD {
  
  static const todoTable = 'contact';
  static const id = 'id';
  static const name = 'name';
  static const phone = 'phone';

  AccesDatabase dbHelper = new AccesDatabase();

  Future<int> insert(ClassPenangkap todo) async {
    Database db = await dbHelper.initDb();
    final sql = '''INSERT INTO ${CRUD.todoTable}
        (
          ${CRUD.name},
          ${CRUD.phone}
        )
        VALUES (?,?)''';

    List<dynamic> params = [todo.name, todo.phone];
    final result = await db.rawInsert(sql, params);
    return result;
  }

  Future<int> update(ClassPenangkap todo) async {
    Database db = await dbHelper.initDb();

    final sql = '''UPDATE ${CRUD.todoTable}
        SET ${CRUD.name} = ?, ${CRUD.phone}
        WHERE ${CRUD.id} = ?
        ''';

    List<dynamic> params = [todo.name, todo.phone, todo.id];
    final result = await db.rawUpdate(sql, params);
    return result;
  }

  Future<int> delete(ClassPenangkap todo) async {
    Database db = await dbHelper.initDb();
    final sql = '''DELETE FROM ${CRUD.todoTable}
        WHERE ${CRUD.id} = ?
        ''';
    List<dynamic> params = [todo.id];
    final result = await db.rawDelete(sql, params);
    return result;
  }

  Future<List<ClassPenangkap>> getContactList() async {
    Database db = await dbHelper.initDb();

    final sql = '''SELECT * FROM ${CRUD.todoTable}''';
    final data = await db.rawQuery(sql);

    List<ClassPenangkap> todos = List();
    for (final node in data) {
      final todo = ClassPenangkap.fromMap(node);
      todos.add(todo);
    }
    return todos;
  }
}

class AccesDatabase {
  Future<Database> initDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'contact.db';
    var todoDatabase = openDatabase(path, version: 1, onCreate: _createDb);
    return todoDatabase;
  }

  void _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE contact (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        phone TEXT,
        date TEXT
      )
    ''');
  }
}
