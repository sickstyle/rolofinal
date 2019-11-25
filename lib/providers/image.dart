import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class Foto with ChangeNotifier {
  String id;
  String title;
  String image;
  String floorId;
  String inquilinoId;

  Foto({
    @required this.id,
    @required this.title,
    @required this.image,
    @required this.floorId,
    @required this.inquilinoId,
  });
}
