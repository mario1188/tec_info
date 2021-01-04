// To parse this JSON data, do
//
//     final tareasModel = tareasModelFromJson(jsonString);

import 'dart:convert';

TareasModel tareasModelFromJson(String str) => TareasModel.fromJson(json.decode(str));

String tareasModelToJson(TareasModel data) => json.encode(data.toJson());

class TareasModel {
    TareasModel({
        this.contenido,
        this.fecha,
        this.id,
        this.idmateria,
        this.idnube,
        this.pendiente,
    });

    String contenido;
    String fecha;
    int id;
    int idmateria;
    String idnube;
    int pendiente;

    factory TareasModel.fromJson(Map<String, dynamic> json) => TareasModel(
        contenido: json["contenido"],
        fecha: json["fecha"],
        id: json["id"],
        idmateria: json["idmateria"],
        idnube: json["idnube"],
        pendiente: json["pendiente"],
    );

    Map<String, dynamic> toJson() => {
        "contenido": contenido,
        "fecha": fecha,
        "id": id,
        "idmateria": idmateria,
        "idnube": idnube,
        "pendiente": pendiente,
    };
}
