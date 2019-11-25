import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Pago with ChangeNotifier {
  String id;
  String descripcion;
  double monto;
  String fecha;
  String floorId;
  bool isFixed;
  bool isDeleted;

  Pago({
    @required this.id,
    @required this.descripcion,
    @required this.fecha,
    @required this.monto,
    @required this.floorId,
    @required this.isDeleted,
    @required this.isFixed,
  });
}
