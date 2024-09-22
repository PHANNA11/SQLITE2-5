import 'dart:developer';

import 'package:database_app/database/core/database_user_core.dart';
import 'package:database_app/model/user_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  Future<Database> initDatabse() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'users.db');
    return openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE $userTableName ($uid INTEGER PRIMARY KEY AUTOINCREMENT, $uName TEXT, $uSalary REAL)');
    });
  }

  Future<void> insertUser({required UserModel user}) async {
    var db = await initDatabse();
    await db.insert(userTableName, user.toMap(isAdd: true));
    log('add success');
  }

  Future<List<UserModel>> getUsers() async {
    var db = await initDatabse();
    List<Map<String, dynamic>> results = await db.query(userTableName);

    return results.map((e) => UserModel.fromMap(e)).toList();
  }

  Future<void> updateUser({required int id}) async {
    var db = await initDatabse();
    await db.delete(userTableName, where: '$uid=?', whereArgs: [id]);
  }

  Future<void> deleteUser({required UserModel user}) async {
    var db = await initDatabse();
    await db.update(userTableName, user.toMap(),
        where: '$uid=?', whereArgs: [user.id]);
  }
}
