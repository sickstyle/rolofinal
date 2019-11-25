import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import './payments.dart';

class Pagos with ChangeNotifier {
  List<Pago> _items = [];

  List<Pago> get items {
    return [..._items];
  }

  List<Pago> get activePagos {
    return _items.where((i) => i.isDeleted == false).toList();
  }

  List<Pago> get deletedPagos {
    return _items.where((i) => i.isDeleted == true).toList();
  }

  Pago findById(id) {
    return _items.firstWhere((Pago) => Pago.id == id);
  }

  void toggleSoftDelete(id) {
    final url = 'https://rolo-dcd13.firebaseio.com/pagos/$id.json';
    var pago = _items.firstWhere((pago) => pago.id == id);
    pago.isDeleted = !pago.isDeleted;

    http.patch(
      url,
      body: json.encode({
        'isDeleted': pago.isDeleted,
      }),
    );

    notifyListeners();
  }

  void delete(id) {
    final url = 'https://rolo-dcd13.firebaseio.com/pagos/$id.json';
    http.delete(url);

    _items.removeWhere((pago) => pago.id == id);
    notifyListeners();
  }

  Future<void> addPago(Pago pago) {
    const url = 'https://rolo-dcd13.firebaseio.com/pagos.json';

    return http
        .post(
      url,
      body: json.encode({
        'fecha': pago.fecha,
        'floorId': pago.floorId,
        'monto': pago.monto,
        'descripcion': pago.descripcion,
        'isDeleted': false,
        'isFixed': pago.isFixed,
      }),
    )
        .then((resp) {
      pago.id = json.decode(resp.body)['name'];
      _items.add(pago);

      notifyListeners();
    }).catchError(
      (error) => throw error,
    );
  }

  Future<void> fetchAndSetPagos() async {
    const url = 'https://rolo-dcd13.firebaseio.com/pagos.json';

    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    final List<Pago> loadedPagos = [];

    extractedData.forEach((pagoId, pagoData) {
      loadedPagos.add(Pago(
        id: pagoId,
        floorId: pagoData['floorId'],
        descripcion: pagoData['descripcion'],
        fecha: pagoData['fecha'],
        monto: pagoData['monto'],
        isDeleted: pagoData['isDeleted'],
        isFixed: pagoData['isFixed'],
      ));
    });

    _items = loadedPagos;

    notifyListeners();
  }

  double pagosMensuales(floorId, year, mes) {
    var total = 0.0;
    _items
        .where((g) =>
            g.isDeleted == false &&
            g.floorId == floorId &&
            DateTime.parse(g.fecha).month == mes &&
            DateTime.parse(g.fecha).year == DateTime(int.parse(year)).year)
        .forEach((x) => total += x.monto);

    return total;
  }

  Map<String, double> pagosMeses(floorId, year) {
    var meses = {
      'enero': pagosMensuales(floorId, year, 1),
      'febrero': pagosMensuales(floorId, year, 2),
      'marzo': pagosMensuales(floorId, year, 3),
      'abril': pagosMensuales(floorId, year, 4),
      'mayo': pagosMensuales(floorId, year, 5),
      'junio': pagosMensuales(floorId, year, 6),
      'julio': pagosMensuales(floorId, year, 7),
      'agosto': pagosMensuales(floorId, year, 8),
      'septiembre': pagosMensuales(floorId, year, 9),
      'octubre': pagosMensuales(floorId, year, 10),
      'noviembre': pagosMensuales(floorId, year, 11),
      'diciembre': pagosMensuales(floorId, year, 12),
    };

    return meses;
  }
}
