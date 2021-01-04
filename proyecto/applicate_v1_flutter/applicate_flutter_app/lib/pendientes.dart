import 'package:applicate_flutter_app/completada_model.dart';
import 'package:applicate_flutter_app/materia_model.dart';
import 'package:applicate_flutter_app/provider_firebase.dart';
import 'package:applicate_flutter_app/tarea_model.dart';
import 'package:applicate_flutter_app/user_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'current_userdb.dart';

class PendientesPage extends StatelessWidget {
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
                'Página donde se muestran las tareas pendientes por realizar.\n1) Para subir la tarea pulsa la tarea a mandar y selecciona la imagen deseada.\n2) Para eliminar la tarea solo arrastra hacia la derecha la tarea completada.'),
          );
        });
  }

  Widget _mostrarpendientes() {
    return FutureBuilder(
      future: providerFirebase.cargarTareasPendientes(),
      builder:
          (BuildContext context, AsyncSnapshot<List<TareasModel>> snapshot) {
        if (this.usuarioLinea.clave != 0) {
          if (snapshot.hasData) {
            final tareas = snapshot.data;
            List<TareasModel> pendientes = new List();
            for (var item in tareas) {
              if (item.pendiente == 1) {
                pendientes.add(item);
              }
            }
            return ListView.builder(
              itemCount: pendientes.length,
              itemBuilder: (context, i) => _crearItems(pendientes[i]),
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

  Widget _crearItems(TareasModel tareasmodel) {
    String nombre = "";
    for (var item in this.listaMaterias) {
      if (item.idmateria == tareasmodel.idmateria) {
        nombre = item.nombre;
      }
    }
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (direccion) {
        providerFirebase.acutalizaTarea(tareasmodel);
      },
      child: ListTile(
        title: Text(nombre),
        subtitle: Text(
          '${tareasmodel.fecha}\n${tareasmodel.contenido}',
          style: TextStyle(color: Colors.black),
        ),
        leading: Icon(
          Icons.bookmark,
          color: Colors.blue,
        ),
        trailing: Icon(
          Icons.camera_enhance,
          color: Colors.blue,
        ),
        onTap: () {
          _seleccionarfoto(tareasmodel);
        },
      ),
    );
  }

  void _seleccionarfoto(TareasModel tareasModel) async {
    final picker = ImagePicker();
    final foto = await picker.getImage(source: ImageSource.gallery);
    bool subir = false;
    if (foto != null) {
      print(foto.path);
      String url = "";
      url = await providerFirebase.subirImagen(foto);
      CompletaModel completa = new CompletaModel();
      completa.id = tareasModel.idnube;
      completa.clave = this.usuarioLinea.clave;
      completa.idmateria = tareasModel.idmateria;
      completa.url = url;
      subir = await providerFirebase.subirCompletado(completa);
      print('subir = $subir');
    } else {
      print('subir = $subir');
    }
  }

  void cargardatos() async {
    this.usuarioLinea = await CurrentUserDB.db.getcurrent(0);

    this.listaMaterias = await providerFirebase.cargarMaterias();
    //print(this.usuarioLinea.clave);
  }
}
