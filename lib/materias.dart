
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tec_info_app/log_db.dart';
import 'dart:convert';

import 'package:tec_info_app/materia_modelo.dart';

class Materias extends StatefulWidget {
  Materias({Key key}) : super(key: key);

  @override
  _MateriasState createState() => _MateriasState();
}

class _MateriasState extends State<Materias> {
  int _id = 0;
  int _pass = 0;
  List<MateriasModelo> lista_materias = new List();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: ListView(
        children: <Widget>[
          campoIdmateria(),
          SizedBox(height: 20.0),
          campoPassword(),
          SizedBox(height: 20.0),
          botonAceptar(context),
          SizedBox(height: 20.0),
          //botonMostrar(context),
        ],
      ),
    );
  }

  Widget campoIdmateria() {
    return TextField(
      maxLength: 4,
      textCapitalization: TextCapitalization.sentences,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        hintText: 'Clave Materia',
        labelText: 'Clave',
        helperText: 'Clave Numerica',
        icon: Icon(Icons.account_circle),
      ),
      onChanged: (valor) {
        setState(() {
          _id = int.parse(valor.trim());
        });
      },
    );
  }

  Widget campoPassword() {
    return TextField(
      maxLength: 5,
      textCapitalization: TextCapitalization.sentences,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        hintText: 'Clave numerica',
        labelText: 'Contaseña',
        icon: Icon(Icons.lock_open),
      ),
      onChanged: (valor) {
        setState(() {
          _pass = int.parse(valor.trim());
        });
      },
    );
  }

  Widget botonAceptar(BuildContext context) {
    bool access = false;
    int tipo = 0;
    checarCredenciales();
    /*
    lista_materias.forEach((element) {
      print(element.nombre);
    });
    print(lista_materias.length);
    */
    return RaisedButton(
        child: Text('Aceptar'),
        color: Colors.blueGrey,
        textColor: Colors.white,
        shape: StadiumBorder(),
        onPressed: () {
          String nombre = "";
          for (var item in lista_materias) {
            if (item.idmateria == _id && item.password == _pass) {
              LogDB.db.localizaUser();
              User user = LogDB.db.regresaUser();
              /*
              print(user.id);
              print(user.clave);
              print(user.idmaterias);
              print(user.nombre);
              print(user.password); 
              */
              if (user.idmaterias == "0") {
                user.idmaterias = item.idmateria.toString();
                LogDB.db.actualizarUser(user);
                nombre = item.nombre;
                access = true;
              } else {
                bool existe = existeMateria(item.idmateria, user.idmaterias);
                if (existe == false) {
                  String nueva = "-" + item.idmateria.toString();
                  user.idmaterias = user.idmaterias + nueva;
                  LogDB.db.actualizarUser(user);
                  nombre = item.nombre;
                  access = true;
                }
                else{
                  nombre = item.nombre;
                }
              }
              //print(user.idmaterias);
              break;
            }
            else{
              nombre = "Credenciales incorrectas";
              tipo = 1;
            }
          }
          //print(access);
          _mostrarMensaje(context, access, nombre, tipo);
        });
  }

  Widget botonMostrar(BuildContext context) {
    bool access = false;
    checarCredenciales();
    /*lista_materias.forEach((element) {
      print(element.nombre);
    });
    print(lista_materias.length);*/
    return RaisedButton(
        child: Text('Materias'),
        color: Colors.blueGrey,
        textColor: Colors.white,
        shape: StadiumBorder(),
        onPressed: () {
          String nombre = "";
          for (var item in lista_materias) {
            if (item.idmateria == _id && item.password == _pass) {
              /*LogDB.db.actualizarLog();
              nombre = item.nombre;
              access = true;*/
              break;
            }
          }
          //print(access);
          //_mostrarMensaje(context, access, nombre, );
        });
  }

  void checarCredenciales() async {
    final url =
        'https://tecinfo-da2f0-default-rtdb.firebaseio.com/materias.json';
    final resp = await http.get(url);
    final Map<String, dynamic> data = json.decode(resp.body);

    if (lista_materias.isEmpty == true) {
      data.forEach((key, value) {
        final mat = MateriasModelo.fromJson(value);
        lista_materias.add(mat);
      });
    } else {
      data.forEach((key, value) {
        bool igual = false;
        final temp = MateriasModelo.fromJson(value);
        lista_materias.forEach((element) {
          if (temp.idmateria == element.idmateria) {
            igual = true;
          }
        });
        if (igual == false) {
          lista_materias.add(temp);
        }
      });
    }
  }

  bool existeMateria(int nueva, String idmaterias) {
    String materia = "";
    int cont = 0;
    for (int i = 0; i < idmaterias.length; i++) {
      if (idmaterias[i] != "-") {
        materia = materia + idmaterias[i];
        cont++;
        //print("name $materia cont $cont");
        if (cont == 4) {
          if (materia == nueva.toString()) {
            //print("verdad");
            return true;
          }
          materia = "";
          cont = 0;
        }
      }
    }
    //print("falso");
    return false;
  }
}

void _mostrarMensaje(BuildContext context, bool acceso, String nombre, int tipo) {
  String mensaje = "";
  if (acceso == true) {
    mensaje = "Materia: $nombre agregada";
  }
  else if( acceso == false && tipo == 0)
  {
    mensaje = "ERROR Materia: $nombre ya existe";
  }
  else if( acceso == false && tipo == 1){
    mensaje = "Credenciales incorrectas";
  }

  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          title: Text('Notificacion'),
          content: Text(mensaje),
        );
      });
}
