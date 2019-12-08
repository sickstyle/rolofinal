import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import './gasto.dart';

class Gastos with ChangeNotifier {
  List<Gasto> _items = [];

  List<Gasto> get items {
    return [..._items];
  }

  List<Gasto> get activeGastos {
    return _items.where((i) => i.isDeleted == false).toList();
  }

  List<Gasto> get deletedGastos {
    return _items.where((i) => i.isDeleted == true).toList();
  }

  Gasto findById(id) {
    return _items.firstWhere((gasto) => gasto.id == id);
  }

  void toggleSoftDelete(id) {
    final url = 'https://rolo-dcd13.firebaseio.com/gastos/$id.json';
    var gasto = _items.firstWhere((gasto) => gasto.id == id);
    gasto.isDeleted = !gasto.isDeleted;

    http.patch(
      url,
      body: json.encode({
        'isDeleted': gasto.isDeleted,
      }),
    );

    notifyListeners();
  }

  double gastosFijos(floorId, year) {
    var total = 0.0;

    _items
        .where(
          (g) =>
              g.isFixed == true &&
              g.isDeleted == false &&
              g.floorId == floorId &&
              DateTime.parse(g.fecha).year == DateTime(int.parse(year)).year,
        )
        .forEach((x) => total += x.monto);

    return total;
  }

  double gastosMensuales(floorId, year, mes) {
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

  bool verify(Gasto gasto) {
    var result = _items.firstWhere(
        (i) => i.id != gasto.id && i.descripcion == gasto.descripcion);

    if (result != null) {
      return false;
    } else {
      return true;
    }
  }

  double gastosMensualesMbt(floorId, year, mes) {
    var total = 0.0;

    var gastos = _items.where((g) => verify(g)).toList();

    gastos
        .where((g) =>
            g.isDeleted == false &&
            g.floorId == floorId &&
            DateTime.parse(g.fecha).month == mes &&
            DateTime.parse(g.fecha).year == DateTime(int.parse(year)).year)
        .forEach((x) => total += x.monto);

    return total;
  }

  Map<String, double> gastosMesesMbt(floorId, year) {
    var meses = {
      'enero': gastosMensualesMbt(floorId, year, 1),
      'febrero': gastosMensualesMbt(floorId, year, 2),
      'marzo': gastosMensualesMbt(floorId, year, 3),
      'abril': gastosMensualesMbt(floorId, year, 4),
      'mayo': gastosMensualesMbt(floorId, year, 5),
      'junio': gastosMensualesMbt(floorId, year, 6),
      'julio': gastosMensualesMbt(floorId, year, 7),
      'agosto': gastosMensualesMbt(floorId, year, 8),
      'septiembre': gastosMensualesMbt(floorId, year, 9),
      'octubre': gastosMensualesMbt(floorId, year, 10),
      'noviembre': gastosMensualesMbt(floorId, year, 11),
      'diciembre': gastosMensualesMbt(floorId, year, 12),
    };

    return meses;
  }

  Map<String, double> gastosMeses(floorId, year) {
    var meses = {
      'enero': gastosMensuales(floorId, year, 1),
      'febrero': gastosMensuales(floorId, year, 2),
      'marzo': gastosMensuales(floorId, year, 3),
      'abril': gastosMensuales(floorId, year, 4),
      'mayo': gastosMensuales(floorId, year, 5),
      'junio': gastosMensuales(floorId, year, 6),
      'julio': gastosMensuales(floorId, year, 7),
      'agosto': gastosMensuales(floorId, year, 8),
      'septiembre': gastosMensuales(floorId, year, 9),
      'octubre': gastosMensuales(floorId, year, 10),
      'noviembre': gastosMensuales(floorId, year, 11),
      'diciembre': gastosMensuales(floorId, year, 12),
    };

    return meses;
  }

  void delete(id) {
    final url = 'https://rolo-dcd13.firebaseio.com/gastos/$id.json';
    http.delete(url);

    _items.removeWhere((gasto) => gasto.id == id);
    notifyListeners();
  }

  Future<void> addGasto(Gasto gasto) {
    const url = 'https://rolo-dcd13.firebaseio.com/gastos.json';

    return http
        .post(
      url,
      body: json.encode({
        'fecha': gasto.fecha,
        'floorId': gasto.floorId,
        'monto': gasto.monto,
        'descripcion': gasto.descripcion,
        'isDeleted': false,
        'isFixed': gasto.isFixed,
      }),
    )
        .then((resp) {
      gasto.id = json.decode(resp.body)['name'];
      _items.add(gasto);

      notifyListeners();
    }).catchError(
      (error) => throw error,
    );
  }

  Future<void> fetchAndSetGastos() async {
    const url = 'https://rolo-dcd13.firebaseio.com/gastos.json';

    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    final List<Gasto> loadedGastos = [];

    extractedData.forEach((gastoId, gastoData) {
      loadedGastos.add(Gasto(
        id: gastoId,
        floorId: gastoData['floorId'],
        descripcion: gastoData['descripcion'],
        fecha: gastoData['fecha'],
        monto: gastoData['monto'],
        isDeleted: gastoData['isDeleted'],
        isFixed: gastoData['isFixed'],
      ));
    });

    _items = loadedGastos;

    notifyListeners();
  }
}
