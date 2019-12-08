import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Archivo with ChangeNotifier {
  String id;
  String idarchivo;
  String title;
  String type;
  String floorId;
  String inquilinoId;

  Archivo({
    @required this.id,
    @required this.idarchivo,
    @required this.title,
    @required this.type,
    @required this.floorId,
    @required this.inquilinoId,
  });
}
