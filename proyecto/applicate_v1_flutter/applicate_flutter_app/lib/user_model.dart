// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    UserModel({
        this.clave,
        this.password,
        this.nombre,
        this.idmaterias,
        this.idtareas,
        this.id,
    });

    int clave;
    String password;
    String nombre;
    String idmaterias;
    String idtareas;
    int id;

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        clave: json["clave"],
        password: json["password"],
        nombre: json["nombre"],
        idmaterias: json["idmaterias"],
        idtareas: json["idtareas"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "clave": clave,
        "password": password,
        "nombre": nombre,
        "idmaterias": idmaterias,
        "idtareas": idtareas,
        "id": id,
    };
}
