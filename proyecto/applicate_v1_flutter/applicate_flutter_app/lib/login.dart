import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _nombre = "0";
  String _pass = "0";

  @override
  Widget build(BuildContext context) {
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
      maxLength: 6,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        hintText: 'Clave numérica del alumno',
        labelText: 'Usuario',
        helperText: 'Clave de 6 dígitos',
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
      maxLength: 6,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        hintText: 'Clave numérica del alumno',
        labelText: 'Contraseña',
        helperText: 'Clave de 6 dígitos',
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
              */
              
            } else {
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
                'Página donde se muestran los campos necesarios para el inicio de sesión.\nRecuerda que debes estar inscrito en la institución.'),
          );
        });
  }

  void _checarusuario(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            title: Text('Usuario en sesión'),
            content: Text('mario serna'),
          );
        });
  }
}
