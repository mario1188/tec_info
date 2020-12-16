import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tec_info_app/log_db.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  int _user = 0;
  int _pass = 0;
  List<User> lista_user = new List();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: ListView(
        children: <Widget>[
          campoUsuario(),
          SizedBox(height: 20.0),
          campoPassword(),
          SizedBox(height: 20.0),
          botonAceptar(context),
        ],
      ),
    );
  }

  Widget campoUsuario() {
    return TextField(
      maxLength: 6,
      textCapitalization: TextCapitalization.sentences,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        hintText: 'Clave usuario',
        labelText: 'Clave',
        helperText: 'Clave institucional',
        icon: Icon(Icons.account_circle),
      ),
      onChanged: (valor) {
        setState(() {
          _user = int.parse(valor.trim());
        });
      },
    );
  }

  Widget campoPassword() {
    return TextField(
      maxLength: 6,
      textCapitalization: TextCapitalization.sentences,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        hintText: 'Clave Institucional',
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
    checarCredenciales();
    /*lista_user.forEach((element) {
      print(element.clave);
    });
    print(lista_user.length);*/
    return RaisedButton(
        child: Text('Aceptar'),
        color: Colors.blueGrey,
        textColor: Colors.white,
        shape: StadiumBorder(),
        onPressed: () {
          String nombre = "";
          for (var item in lista_user) {
            if(item.clave == _user && item.password == _pass){
              item.id = 1;
              LogDB.db.actualizarLog(item);
              nombre = item.nombre;
              access = true;
              break;
            }
          }                    
          //print(access);
          _mostrarMensaje(context, access, nombre);
        });
  }

  void checarCredenciales() async {
    final url =
        'https://tecinfo-da2f0-default-rtdb.firebaseio.com/usuarios.json';
    final resp = await http.get(url);
    final Map<String, dynamic> data = json.decode(resp.body);
    if (lista_user.isEmpty == true) {
      data.forEach((key, value) {
        final temp = User.fromJson(value);
        lista_user.add(temp);
      });
    } else {
      data.forEach((key, value) {
        bool igual = false;
        final temp = User.fromJson(value);
        lista_user.forEach((element) {
          if (temp.clave == element.clave) {
            igual = true;
          }
        });
        if (igual == false) {
          lista_user.add(temp);
        }
      });
    }
  }
}

void _mostrarMensaje(BuildContext context, bool acceso, String nombre) {
  String mensaje = "";
  if (acceso == false) {
    mensaje = "Credenciales Incorrectas";
  } else {
    mensaje = "Usuario: $nombre en Linea";
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
