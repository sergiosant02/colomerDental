// To parse this JSON data, do
//
//     final clinicas = clinicasFromJson(jsonString);

import 'dart:convert';

Clinicas clinicasFromJson(String str) => Clinicas.fromJson(json.decode(str));

String clinicasToJson(Clinicas data) => json.encode(data.toJson());

class Clinicas {
  Clinicas({
    this.id,
    this.nombre,
    this.dirrecion,
    this.tel,
    this.latitud,
    this.longitud,
  });

  int id;
  String nombre;
  String dirrecion;
  String tel;
  String latitud;
  String longitud;

  factory Clinicas.fromJson(Map<String, dynamic> json) => Clinicas(
        id: int.tryParse(json["id"]),
        nombre: json["nombre"],
        dirrecion: json["dirrecion"],
        tel: json["tel"],
        latitud: json["latitud"],
        longitud: json["longitud"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "dirrecion": dirrecion,
        "tel": tel,
        "latitud": latitud,
        "longitud": longitud,
      };
}
