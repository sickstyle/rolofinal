import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import './archivo.dart';

class Archivos with ChangeNotifier {
  List<Archivo> _items = [];

  List<Archivo> get items {
    return [..._items];
  }

  Archivo findById(id) {
    return _items.firstWhere((archivo) => archivo.id == id);
  }

  void delete(id) {
    final url = 'https://rolo-dcd13.firebaseio.com/archivos/$id.json';
    http.delete(url);

    print(id);

    _items.removeWhere((ar) => ar.id == id);
    notifyListeners();
  }

  Future<void> fetchAndSetArchivos() async {
    const url = 'https://rolo-dcd13.firebaseio.com/archivos.json';

    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    final List<Archivo> loadedArchivos = [];

    extractedData.forEach((archivoId, archivoData) {
      loadedArchivos.add(Archivo(
        id: archivoId,
        floorId: archivoData['floorId'],
        inquilinoId: archivoData['inquilinoId'],
        idarchivo: archivoData['idarchivo'],
        title: archivoData['title'],
        type: archivoData['type'],
      ));
    });

    _items = loadedArchivos;

    notifyListeners();
  }

  Future<void> addArchivo(Archivo archivo) {
    const url = 'https://rolo-dcd13.firebaseio.com/archivos.json';

    return http
        .post(
      url,
      body: json.encode({
        'floorId': archivo.floorId,
        'inquilinoId': archivo.inquilinoId,
        'idarchivo': archivo.idarchivo,
        'title': archivo.title,
        'type': archivo.type,
      }),
    )
        .then((resp) {
      archivo.id = json.decode(resp.body)['name'];
      _items.add(archivo);

      notifyListeners();
    }).catchError(
      (error) => throw error,
    );
  }
}
