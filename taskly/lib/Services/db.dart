import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:testt/Models/TaskModel.dart';

class DBService {

 Future<Database> getDatabase() async {
    // get the default databases location
    String dbPath = await getDatabasesPath();
    // If the database is already created, get an instance of it.
    // If it is not there, onCreate is executed
    Database db = await openDatabase(
      // to avoid errors in the database path use join method
      // the database name should always end with .db
      join(dbPath, 'tasks.db'),
      // executed only when the database is not there or when the version is incremented
      onCreate: (db, version) => db.execute(
        '''CREATE TABLE tasks (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            description TEXT,
            date TEXT,
            isDone INTEGER
          )''',
      ),
      // increment version number only when the database scheme changes: add/drop table, add/drop column, add/drop relation
      version: 1,
    );
    return db;
  }

  Future<List<TaskModel>> getTasks() async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query('tasks');
    return List.generate(maps.length, (i) => TaskModel.fromMap(maps[i]));
  }

  Future<void> insertTask(TaskModel task) async {
    final db = await getDatabase();
    await db.insert('tasks', task.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateTask(TaskModel task) async {
    final db = await getDatabase();
    await db.update('tasks', task.toMap(), where: 'id = ?', whereArgs: [task.id]);
  }

  Future<void> deleteTask(int id) async {
    final db = await getDatabase();
    await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }
}