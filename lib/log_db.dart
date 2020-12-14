import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LogDB {
  static Database _database;
  static final LogDB db = LogDB._();
  LogDB._();

  get database async {
    if (_database != null) {
      return _database;
    }
    _database = await iniciaDB();
    return _database;
  }

  Future<Database> iniciaDB() async {
    Directory logdb = await getApplicationDocumentsDirectory();
    final path = join(logdb.path, 'LogDB.db');
    print(path);

    return await openDatabase(path,
        version: 1, onOpen: (db) {}, onCreate: (Database db, int version) async{
          await db.execute('''
            CREATE TABLE Log(
              clave INTEGER,
              idmaterias TEXT,
              nombre TEXT,
              password INTEGER 
            )
          ''');
        });
  }
}
