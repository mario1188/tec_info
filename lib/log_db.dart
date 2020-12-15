import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:tec_info_app/user_modelo.dart';
export 'package:tec_info_app/user_modelo.dart';

class LogDB {
  String _nombreLog = "";
  static Database _database;
  static final LogDB db = LogDB._();
  LogDB._();

  get database async {
    if (_database != null) {
      return _database;
    }
    _database = await iniciaDB();
    User inicial = new User();
    inicial.clave = 000000;
    inicial.idmaterias = "nada";
    inicial.nombre = "inicial";
    inicial.password = 000000;
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
              nombre TEXT,
              password INTEGER 
            )
          ''');
    });
  }

  Future<int> loguearUsuario(User usuario) async {
    final id = 1;
    final clave = usuario.clave;
    final idmaterias = usuario.idmaterias;
    final nombre = usuario.nombre;
    final password = usuario.password;

    final db = await database;
    final res = await db.rawInsert('''
      INSERT INTO Log(id, clave, idmaterias, nombre, password)
        VALUES( $id, $clave, '$idmaterias', '$nombre', $password)
    
    ''');

    return res;
  }

  void actualizaNombre () async{
    final db = await database;
    final res = await db.query('Log');

    User user = new User();
    user = User.fromJson(res.first);
    _nombreLog = user.nombre;
    //print(nombre);
  }

  String regresaNombre(){
    return this._nombreLog;
  }

  Future<int> actualizarLog(User usuario) async {
    final db = await database;
    final res = await db.update('Log', usuario.toJson());
    return res;
  }
}
