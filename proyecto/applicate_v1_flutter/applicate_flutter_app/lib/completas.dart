
import 'package:applicate_flutter_app/completada_model.dart';
import 'package:applicate_flutter_app/materia_model.dart';
import 'package:applicate_flutter_app/provider_firebase.dart';
import 'package:applicate_flutter_app/user_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'current_userdb.dart';

class CompletasPage extends StatelessWidget {
  ProviderFirebase providerFirebase = new ProviderFirebase();
  UserModel usuarioLinea = new UserModel();
  List<MateriasModel> listaMaterias = new List();

  @override
  Widget build(BuildContext context) {
    cargardatos();
    return Scaffold(
      body: _mostrarpendientes(),
      floatingActionButton: _crearbotones(context),
    );
  }

  Widget _crearbotones(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
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
                'Página donde se muestran las tareas completadas por el usuario.\n1) Para checar la imagen subida a la nube, pulsar el elemento de la lista.'),
          );
        });
  }

  Widget _mostrarpendientes() {
    return FutureBuilder(
      future: providerFirebase.cargarTareasCompletas(),
      builder:
          (BuildContext context, AsyncSnapshot<List<CompletaModel>> snapshot) {
        if (this.usuarioLinea.clave != 0) {
          if (snapshot.hasData) {
            final tareas = snapshot.data;
            return ListView.builder(
              itemCount: tareas.length,
              itemBuilder: (context, i) => _crearItems(tareas[i]),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _crearItems(CompletaModel tareasmodel) {
    String nombre = "";
    for (var item in this.listaMaterias) {
      if (item.idmateria == tareasmodel.idmateria) {
        nombre = item.nombre;
      }
    }
    return ListTile(
      title: Text(nombre),
      subtitle: Text(
        '${tareasmodel.clave}\n${tareasmodel.url}',
        style: TextStyle(color: Colors.black),
      ),
      leading: Icon(
        Icons.check_circle,
        color: Colors.blue,
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: Colors.blue,
      ),
      onTap: () {
        _launchURL(tareasmodel.url);
      },
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void cargardatos() async {
    this.usuarioLinea = await CurrentUserDB.db.getcurrent(0);

    this.listaMaterias = await providerFirebase.cargarMaterias();
    //print(this.usuarioLinea.clave);
  }
}
