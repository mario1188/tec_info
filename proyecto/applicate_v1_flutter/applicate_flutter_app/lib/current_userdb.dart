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
  UserModel currentlog = new UserModel();

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();

    UserModel user = new UserModel();
    user.clave = 0;
    user.password = 0;
    user.nombre = "usuario inicial";
    user.idmaterias = "-";
    user.idtareas = "-";
    userinicial(user);

    print("no existe DB");

    return _database;
  }

  Future<Database> initDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, 'currentUser.db');
    print(path);

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('''
          CREATE TABLE currentUser(
            id INTEGER,
            clave INTEGER,
            password INTEGER,
            nombre TEXT,
            idmaterias TEXT,
            idtareas TEXT
          )
          
          ''');
    });
  }

  Future<UserModel> getcurrent(int i) async {
    final db = await database;
    final res = await db.query('currentUser', where: 'id = ?', whereArgs: [i]);
    this.currentlog = UserModel.fromJson(res.first);
    print('getcurrent:');
    print(this.currentlog.nombre);
    return this.currentlog;
  }

  UserModel logueado() {
    print(currentlog.nombre);
    return currentlog;
  }

  Future<int> userinicial(UserModel user) async {
    print('iniical login');
    int id = 0;
    int clave = user.clave;
    int password = user.password;
    String nombre = user.nombre;
    String idmaterias = user.idmaterias;
    String idtareas = user.idtareas;

    final db = await database;
    final res = await db.rawInsert(''' 
      INSERT INTO currentUser(id, clave, password, nombre, idmaterias, idtareas)
        VALUES( $id, $clave, $password, '$nombre', '$idmaterias', '$idtareas')
    ''');
    return res;
  }

  Future<int> actualizarcurrentlog(UserModel user) async {
    print('update db');
    user.id = 0;
    final db = await database;
    final res = await db
        .update('currentUser', user.toJson());
    return res;
  }
}
