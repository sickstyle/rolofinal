import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Floor with ChangeNotifier {
  String id;
  double alquiler;
  String calle;
  String numero;
  String planta;
  String puerta;
  String zipcode;
  String provincia;
  String observaciones;
  double costeCompra;
  double ivaItp;
  double comision;
  double gastoNotaria;
  double reformas;
  double mobiliario;
  String preName;
  String preLastName;
  String preDireccion;
  String preTelefono;
  String preEmail;
  String preObservaciones;
  String admName;
  String admDireccion;
  String admTelefono;
  String admMovil;
  String admEmail;
  String aseName;
  String aseContacto;
  String aseTelefono;
  String aseEmail;
  String aseObservaciones;

  bool isDeleted;

  Floor({
    @required this.id,
    @required this.alquiler,
    @required this.calle,
    @required this.numero,
    @required this.planta,
    @required this.puerta,
    @required this.zipcode,
    @required this.provincia,
    @required this.observaciones,
    @required this.costeCompra,
    @required this.ivaItp,
    @required this.comision,
    @required this.isDeleted,
    @required this.mobiliario,
    @required this.gastoNotaria,
    @required this.reformas,
    @required this.preName,
    @required this.preLastName,
    @required this.preDireccion,
    @required this.preTelefono,
    @required this.preEmail,
    @required this.preObservaciones,
    @required this.admName,
    @required this.admDireccion,
    @required this.admTelefono,
    @required this.admEmail,
    @required this.admMovil,
    @required this.aseName,
    @required this.aseContacto,
    @required this.aseTelefono,
    @required this.aseEmail,
    @required this.aseObservaciones,
  });
}
