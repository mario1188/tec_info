// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    User({
        this.id,
        this.clave,
        this.idmaterias,
        this.nombre,
        this.password,
        this.idnube,
    });

    int id;
    int clave;
    String idmaterias;
    String nombre;
    int password;
    String idnube;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        clave: json["clave"],
        idmaterias: json["idmaterias"],
        nombre: json["nombre"],
        password: json["password"],
        idnube: json["idnube"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "clave": clave,
        "idmaterias": idmaterias,
        "nombre": nombre,
        "password": password,
        "idnube": idnube,
    };
}
