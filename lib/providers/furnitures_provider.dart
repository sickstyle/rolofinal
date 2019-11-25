import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import './furniture.dart';

class Muebles with ChangeNotifier {
  List<Mueble> _items = [];

  List<Mueble> get items {
    return [..._items];
  }

  List<Mueble> get activeMuebles {
    return _items.where((i) => i.isDeleted == false).toList();
  }

  List<Mueble> get deletedMuebles {
    return _items.where((i) => i.isDeleted == true).toList();
  }

  Mueble findById(id) {
    return _items.firstWhere((mueble) => mueble.id == id);
  }

  void toggleSoftDelete(id) {
    final url = 'https://rolo-dcd13.firebaseio.com/muebles/$id.json';
    var mueble = _items.firstWhere((mueble) => mueble.id == id);
    mueble.isDeleted = !mueble.isDeleted;

    http.patch(
      url,
      body: json.encode({
        'isDeleted': mueble.isDeleted,
      }),
    );

    notifyListeners();
  }

  void delete(id) {
    final url = 'https://rolo-dcd13.firebaseio.com/muebles/$id.json';
    http.delete(url);

    _items.removeWhere((mueble) => mueble.id == id);
    notifyListeners();
  }

  Future<void> addMueble(Mueble mueble) {
    const url = 'https://rolo-dcd13.firebaseio.com/muebles.json';

    return http
        .post(
      url,
      body: json.encode({
        'floorId': mueble.floorId,
        'monto': mueble.monto,
        'descripcion': mueble.descripcion,
        'isDeleted': false,
      }),
    )
        .then((resp) {
      mueble.id = json.decode(resp.body)['name'];
      _items.add(mueble);

      notifyListeners();
    }).catchError(
      (error) => throw error,
    );
  }

  Future<void> fetchAndSetMuebles() async {
    const url = 'https://rolo-dcd13.firebaseio.com/Muebles.json';

    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    final List<Mueble> loadedMuebles = [];

    extractedData.forEach((muebleId, muebleData) {
      loadedMuebles.add(Mueble(
          id: muebleId,
          floorId: muebleData['floorId'],
          descripcion: muebleData['descripcion'],
          monto: muebleData['monto'],
          isDeleted: muebleData['isDeleted']));
    });

    _items = loadedMuebles;

    notifyListeners();
  }
}
