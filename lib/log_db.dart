import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:tec_info_app/user_modelo.dart';
export 'package:tec_info_app/user_modelo.dart';

class LogDB {
  User user = new User();
  static Database _database;
  static final LogDB db = LogDB._();
  LogDB._();

  get database async {
    if (_database != null) {
      return _database;
    }
    _database = await iniciaDB();
    User inicial = new User();
    inicial.id = 1;
    inicial.clave = 000000;
    inicial.idmaterias = "nada";
    inicial.nombre = "inicial";
    inicial.password = 000000;
    inicial.idnube = "url";
    this.loguearUsuario(inicial);
    return _database;
  }

  Future<Database> iniciaDB() async {
    Directory logdb = await getApplicationDocumentsDirectory();
    final path = join(logdb.path, 'LogDB.db');
    print(path);

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('''
            CREATE TABLE Log(
              id INTEGER,
              clave INTEGER,
              idmaterias TEXT,
              idnube TEXT,
              nombre TEXT,
              password INTEGER
            )
          ''');
    });
  }

  Future<int> loguearUsuario(User usuario) async {
    final id = usuario.id;
    final clave = usuario.clave;
    final idmaterias = usuario.idmaterias;
    final nombre = usuario.nombre;
    final password = usuario.password;
    final idnube = usuario.idnube;

    final db = await database;
    final res = await db.rawInsert('''
      INSERT INTO Log(id, clave, idmaterias, idnube, nombre, password)
        VALUES( $id, $clave, '$idmaterias', '$idnube', '$nombre', $password)
    
    ''');

    return res;
  }

  Future<User> getLogueado() async{
    final db = await database;
    final res = await db.query('Log');
    return User.fromJson(res.first);    
  }

  void localizaUser() async{
    final db = await database;
    final res = await db.query('Log');
    user = User.fromJson(res.first);
    /*print(user.clave);
    print(user.idmaterias);
    print(user.nombre);
    print(user.password);  */
  }

  User regresaUser(){
    return this.user;
  }

  Future<int> actualizarLog(User usuario) async {
    final db = await database;
    final res = await db.update('Log', usuario.toJson());
    return res;
  }

  void actualizarUser(User usuario) async {
    final db = await database;
    final res = await db.update('Log', usuario.toJson(), where: 'id = ?', whereArgs: [1]);
  }
}
