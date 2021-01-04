import 'dart:convert';

import 'package:applicate_flutter_app/completada_model.dart';
import 'package:applicate_flutter_app/current_userdb.dart';
import 'package:applicate_flutter_app/materia_model.dart';
import 'package:applicate_flutter_app/tarea_model.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'package:image_picker/image_picker.dart';
import 'package:mime_type/mime_type.dart';

class ProviderFirebase {
  final String _url = 'https://tecinfo-da2f0-default-rtdb.firebaseio.com';

  List<UserModel> listaUser = new List();
  List<MateriasModel> listaMaterias = new List();


  Future<bool> subirCompletado(CompletaModel completa) async {
    
    final dir = '$_url/completas.json';
    
    final resp = await http.post(dir, body: completaModelToJson(completa));

    final decode = json.decode(resp.body);

    print(decode);

    return true;


  }

  Future<List<UserModel>> cargarAlumnos() async {
    final dir = '$_url/usuarios.json';
    final resp = await http.get(dir);
    final Map<String, dynamic> dec = json.decode(resp.body);
    dec.forEach((key, value) {
      final temp = UserModel.fromJson(value);
      this.listaUser.add(temp);
      //print(temp.nombre);
    });
    //print(listaUser.length);
    return this.listaUser;
  }

  List<UserModel> getListaAlumnos() {
    print("getListaalumnos");
    print(this.listaUser.length);
    return this.listaUser;
  }

  Future<List<MateriasModel>> cargarMaterias() async {
    final dir = '$_url/materias.json';
    final resp = await http.get(dir);
    final Map<String, dynamic> dec = json.decode(resp.body);
    dec.forEach((key, value) {
      final temp = MateriasModel.fromJson(value);
      bool acepta = true;
      for (var item in this.listaMaterias) {
        if (item.idmateria == temp.idmateria) {
          acepta = false;
          break;
        }
      }
      if (acepta == true) {
        this.listaMaterias.add(temp);
        //print(temp.nombre);
      }
      //print(temp.nombre);
    });
    //print(listaUser.length);
    
    return this.listaMaterias;
  }

  List<MateriasModel> getListaMaterias() {
    return this.listaMaterias;
  }

  Future<List<TareasModel>> cargarTareasPendientes() async {
    final List<TareasModel> list = new List();
    final dir = '$_url/tareas_pendiente.json';
    final resp = await http.get(dir);
    final Map<String, dynamic> decode = json.decode(resp.body);

    print(decode);

    if (decode == null) return [];
    decode.forEach((key, value) {
      final temp = TareasModel.fromJson(value);
      list.add(temp);
    });

    return list;
  }

  Future<List<CompletaModel>> cargarTareasCompletas() async {
    final List<CompletaModel> list = new List();
    final dir = '$_url/completas.json';
    final resp = await http.get(dir);
    final Map<String, dynamic> decode = json.decode(resp.body);

    print(decode);

    if (decode == null) return [];
    decode.forEach((key, value) {
      final temp = CompletaModel.fromJson(value);
      list.add(temp);
    });

    return list;
  }

  Future<bool> acutalizaTarea(TareasModel tarea) async {
    tarea.pendiente = 0;
    final dir = '$_url/tareas_pendiente/${tarea.idnube}.json';
    final resp = await http.put(dir, body: tareasModelToJson(tarea));
    final decode = json.decode(resp.body);
    print(decode);
    return true;
  }

  Future<String> subirImagen(PickedFile foto) async {
    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/dzdl4ythe/image/upload?upload_preset=ucbw3rth');
    final mymetype = mime(foto.path).split('/');
    final upload = http.MultipartRequest('POST', url);

    final file = await http.MultipartFile.fromPath('file', foto.path,
        contentType: MediaType(mymetype[0], mymetype[1]));

    upload.files.add(file);

    final stream = await upload.send();

    final resp = await http.Response.fromStream(stream);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('fallo en subir imagen');
      return null;
    }

    final respuesta = json.decode(resp.body);
    print(respuesta);

    return respuesta['secure_url'];
  }
}
