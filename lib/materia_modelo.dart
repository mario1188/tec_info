// To parse this JSON data, do
//
//     final materias = materiasFromJson(jsonString);

import 'dart:convert';

MateriasModelo materiasFromJson(String str) => MateriasModelo.fromJson(json.decode(str));

String materiasToJson(MateriasModelo data) => json.encode(data.toJson());

class MateriasModelo {
    MateriasModelo({
        this.idmateria,
        this.nombre,
        this.password,
    });

    int idmateria;
    String nombre;
    int password;

    factory MateriasModelo.fromJson(Map<String, dynamic> json) => MateriasModelo(
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
