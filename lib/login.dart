import 'package:flutter/material.dart';
import 'package:tec_info_app/log_db.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  int _user = 0;
  int _pass = 0;
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
    return RaisedButton(
        child: Text('Aceptar'),
        color: Colors.blueGrey,
        textColor: Colors.white,
        shape: StadiumBorder(),
        onPressed: () {
          print('usuario: $_user y contraseña $_pass');
          LogDB.db.database;
          bool acceso = false;
          _mostrarMensaje(context, acceso);
        });
  }
}

void _mostrarMensaje(BuildContext context, bool acceso) {
  String mensaje = "";
  if (acceso == false) {
    mensaje = "Credenciales Incorrectas";
  } else {
    mensaje = "Usuario en Linea";
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
