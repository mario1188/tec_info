import 'package:applicate_flutter_app/current_userdb.dart';
import 'package:applicate_flutter_app/provider_firebase.dart';
import 'package:flutter/material.dart';

import 'materia_model.dart';

class MateriasPage extends StatefulWidget {
  @override
  _MateriasPage createState() => _MateriasPage();
}

class _MateriasPage extends State<MateriasPage> {
  ProviderFirebase firebase = new ProviderFirebase();
  String _nombre = "0";
  String _pass = "0";
  UserModel usuarioLinea = new UserModel();
  List<MateriasModel> listaMaterias = new List();
  @override
  Widget build(BuildContext context) {
    cargardatos();
    return Scaffold(
      body: Center(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
          children: <Widget>[
            _campousuario(),
            SizedBox(height: 20.0),
            _campopassword(),
            SizedBox(height: 20.0),
            _botonaceptar(context),
          ],
        ),
      ),
      floatingActionButton: _crearbotones(context),
    );
  }

  Widget _campousuario() {
    return TextField(
      textCapitalization: TextCapitalization.sentences,
      keyboardType: TextInputType.number,
      maxLength: 4,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        hintText: 'Clave numérica de la matería',
        labelText: 'Matería',
        helperText: 'Clave de 4 dígitos',
        icon: Icon(Icons.person),
      ),
      onChanged: (valor) {
        _nombre = valor;
      },
    );
  }

  Widget _campopassword() {
    return TextField(
      textCapitalization: TextCapitalization.sentences,
      keyboardType: TextInputType.number,
      maxLength: 5,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        hintText: 'Clave numérica de la matería',
        labelText: 'Contraseña',
        helperText: 'Clave de 5 dígitos',
        icon: Icon(Icons.lock),
      ),
      onChanged: (valor) {
        _pass = valor;
      },
    );
  }

  Widget _botonaceptar(BuildContext context) {
    return Center(
      child: RaisedButton(
          child: Text(
            'Aceptar',
            style: TextStyle(fontSize: 20.0),
          ),
          color: Colors.blue,
          textColor: Colors.white,
          shape: StadiumBorder(),
          onPressed: () {
            if (_nombre != "" &&
                _nombre != "0" &&
                _pass != "" &&
                _pass != "0") {
              /*    
              print(_nombre);
              print(_pass);
              
              print('clave: ${this.usuarioLinea.clave}');
              for (var item in this.listaMaterias) {
                print(item.idmateria);
              }
              */
              //print('campos: $_nombre - $_pass');
              if (this.usuarioLinea.clave != 0) {
                for (var item in this.listaMaterias) {
                  if (item.idmateria == int.parse(_nombre) &&
                      item.password == int.parse(_pass)) {
                    this.usuarioLinea.idmaterias = usuarioLinea.idmaterias +
                        item.idmateria.toString() +
                        "-";
                    //print(this.usuarioLinea.clave);
                    CurrentUserDB.db.actualizarcurrentlog(this.usuarioLinea);
                    //print(item.nombre);
                    _avisoExito(context);
                    break;
                  }
                }
              } else {
                //print('error 2 despues');
                _avisoerror2(context);
              }
              //print(lista.length);
            } else {
              print('error');
              _avisoerror(context);
            }
          }),
    );
  }

  void _avisoerror(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            title: Text('Error'),
            content: Text('Campos vacíos / Credenciales incorrectas'),
          );
        });
  }

  void _avisoerror2(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            title: Text('Error'),
            content: Text('Debes iniciar sesión primero'),
          );
        });
  }

  void _avisoExito(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            title: Text('Materia'),
            content: Text('Se ha agregado la materia de forma existosa'),
          );
        });
  }

  Widget _crearbotones(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        SizedBox(
          width: 30.0,
        ),
        FloatingActionButton(
          child: Icon(Icons.person),
          onPressed: () => _checarusuario(context),
        ),
        Expanded(
          child: SizedBox(),
        ),
        FloatingActionButton(
          child: Icon(Icons.priority_high),
          onPressed: () => _descripcion(context),
        ),
      ],
    );
  }

  void _descripcion(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            title: Text('Descripción'),
            content: Text(
                'Página donde se muestran los campos necesarios para agregar materias al usuario en linea.'),
          );
        });
  }

  void _checarusuario(BuildContext context) {
    //print("checando");
    String nombre = "";
    final lista = this.usuarioLinea.idmaterias.split('-');
    for (var item in lista) {
      for (var mat in this.listaMaterias) {
        if(item == mat.idmateria.toString()){
          nombre = nombre + mat.nombre + " - ";
        }
      }
    }
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            title: Text('Materias del Usuario'),
            content: Text('$nombre'),
          );
        });
  }

  void cargardatos() async {
    this.usuarioLinea = await CurrentUserDB.db.getcurrent(0);

    this.listaMaterias = await firebase.cargarMaterias();
    //print(this.usuarioLinea.clave);
  }
}
