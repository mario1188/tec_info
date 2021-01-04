// To parse this JSON data, do
//
//     final completaModel = completaModelFromJson(jsonString);

import 'dart:convert';

CompletaModel completaModelFromJson(String str) => CompletaModel.fromJson(json.decode(str));

String completaModelToJson(CompletaModel data) => json.encode(data.toJson());

class CompletaModel {
    CompletaModel({
        this.clave,
        this.id,
        this.idmateria,
        this.url,
    });

    int clave;
    String id;
    int idmateria;
    String url;

    factory CompletaModel.fromJson(Map<String, dynamic> json) => CompletaModel(
        clave: json["clave"],
        id: json["id"],
        idmateria: json["idmateria"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "clave": clave,
        "id": id,
        "idmateria": idmateria,
        "url": url,
    };
}
