import 'dart:io';

import 'package:applicate_flutter_app/user_model.dart';
export 'package:applicate_flutter_app/user_model.dart';


import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:path/path.dart';

class CurrentUserDB {
  static Database _database;
  static final CurrentUserDB db = CurrentUserDB._();
  CurrentUserDB._();

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await initDB();
    }

    UserModel user = new UserModel();
    user.clave = 0;
    user.password = 0;
    user.nombre = "usuario inicial";
    user.idmaterias = "-";
    user.idtareas = "-";

    this.currentuser(user);

    return _database;
  }

  Future<Database> initDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, 'CurrentUser.db');
    print(path);

    return await openDatabase(path,
        version: 1, onOpen: (db) {}, onCreate: (Database db, int version) async {
          await db.execute('''
          CREATE TABLE currentUser(
            clave INTEGER,
            password INTEGER,
            nombre TEXT,
            idmaterias TEXT,
            idtareas TEXT
          )
          
          ''');
        });
  }

  Future<int> currentuser(UserModel user) async{

    final db = await database;
    final res = await db.insert('currentUser', user.toJson());
    return res;

  }
}