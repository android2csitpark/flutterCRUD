import 'package:untitled2/db_helper/database_connection.dart';
import 'package:sqflite/sqflite.dart';

class Repository {
   late var DatabaseConnection_databaseConnection;
  Repository() {
    DatabaseConnection_databaseConnection= DatabaseConnection();
  }
  static Database? _database;
  Future<Database?>get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await DatabaseConnection_databaseConnection.setDatabase();
      return _database;
    }
  }
  insertData(table, data) async {
    var connection = await database;
    return await connection?.insert(table, data);
  }
  readData(table) async {
    var connection = await database;
    return await connection?.query(table);
  }
  readDataById(table, itemId) async {
    var connection = await database;
    return await connection?.query(table, where: 'id=?', whereArgs: [itemId]);
  }
  updateData(table, data) async {
    var connection = await database;
    return await connection
        ?.update(table, data, where: 'id=?', whereArgs: [data['id']]);
  }
  deleteDataById(table, itemId) async {
    var connection = await database;
    return await connection?.rawDelete("delete from $table where id=$itemId");
  }
}