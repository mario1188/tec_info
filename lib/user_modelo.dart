// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    User({
        this.clave,
        this.idmaterias,
        this.nombre,
        this.password,
    });

    int clave;
    String idmaterias;
    String nombre;
    int password;

    factory User.fromJson(Map<String, dynamic> json) => User(
        clave: json["clave"],
        idmaterias: json["idmaterias"],
        nombre: json["nombre"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "clave": clave,
        "idmaterias": idmaterias,
        "nombre": nombre,
        "password": password,
    };
}
