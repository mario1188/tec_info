// To parse this JSON data, do
//
//     final materiasModel = materiasModelFromJson(jsonString);

import 'dart:convert';

MateriasModel materiasModelFromJson(String str) => MateriasModel.fromJson(json.decode(str));

String materiasModelToJson(MateriasModel data) => json.encode(data.toJson());

class MateriasModel {
    MateriasModel({
        this.idmateria,
        this.nombre,
        this.password,
    });

    int idmateria;
    String nombre;
    int password;

    factory MateriasModel.fromJson(Map<String, dynamic> json) => MateriasModel(
        idmateria: json["idmateria"],
        nombre: json["nombre"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "idmateria": idmateria,
        "nombre": nombre,
        "password": password,
    };
}
