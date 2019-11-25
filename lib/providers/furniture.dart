import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Mueble with ChangeNotifier {
  String id;
  String descripcion;
  double monto;

  String floorId;
  bool isDeleted;

  Mueble({
    @required this.id,
    @required this.descripcion,
    @required this.monto,
    @required this.floorId,
    @required this.isDeleted,
  });
}
