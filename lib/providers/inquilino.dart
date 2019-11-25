import 'package:flutter/foundation.dart';

class Inquilino with ChangeNotifier {
  String id;
  String floorId;
  String name;
  String lastName;
  String dni;
  String nacionalidad;
  String direccion;
  String telefono;
  String movil;
  String email;
  String ccc;
  String direccionTrabajo;
  String importeNomina;
  String tipoContrato;
  String tgss;
  String observaciones;
  String avaName;
  String avaLastName;
  String avaDni;
  String avaNacionalidad;
  String avaDireccion;
  String avaTelefono;
  String avaMovil;
  String avaEmail;
  String avaCcc;
  String fechaEntrada;
  bool isDeleted;

  bool isActive;

  Inquilino({
    @required this.id,
    @required this.floorId,
    @required this.name,
    @required this.lastName,
    @required this.dni,
    @required this.nacionalidad,
    @required this.direccion,
    @required this.telefono,
    @required this.movil,
    @required this.email,
    @required this.ccc,
    @required this.direccionTrabajo,
    @required this.importeNomina,
    @required this.tipoContrato,
    @required this.tgss,
    @required this.observaciones,
    @required this.isDeleted,
    @required this.isActive,
    @required this.avaName,
    @required this.avaLastName,
    @required this.avaDni,
    @required this.avaNacionalidad,
    @required this.avaDireccion,
    @required this.avaTelefono,
    @required this.avaMovil,
    @required this.avaEmail,
    @required this.avaCcc,
    @required this.fechaEntrada,
  });
}
