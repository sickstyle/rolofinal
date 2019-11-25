import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import './floor.dart';

class Floors with ChangeNotifier {
  List<Floor> _items = [];

  List<Floor> get items {
    return [..._items];
  }

  List<Floor> get activeFloors {
    return _items.where((i) => i.isDeleted == false).toList();
  }

  List<Floor> get inactiveFloors {
    return _items.where((i) => i.isDeleted == true).toList();
  }

  Floor findById(id) {
    return _items.firstWhere((floor) => floor.id == id);
  }

  void toggleSoftDelete(id) {
    final url = 'https://rolo-dcd13.firebaseio.com/floors/$id.json';

    var floor = _items.firstWhere((floor) => floor.id == id);
    floor.isDeleted = !floor.isDeleted;

    http.patch(
      url,
      body: json.encode({
        'isDeleted': floor.isDeleted,
      }),
    );
    notifyListeners();
  }

  void delete(id) {
    final url = 'https://rolo-dcd13.firebaseio.com/floors/$id.json';

    http.delete(url);

    _items.removeWhere((floor) => floor.id == id);
    notifyListeners();
  }

  Future<void> fetchAndSetFloors() async {
    const url = 'https://rolo-dcd13.firebaseio.com/floors.json';

    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    final List<Floor> loadedFloors = [];

    extractedData.forEach((floorId, floorData) {
      loadedFloors.add(Floor(
        id: floorId,
        calle: floorData['calle'],
        numero: floorData['numero'],
        planta: floorData['planta'],
        puerta: floorData['puerta'],
        zipcode: floorData['zipcode'],
        provincia: floorData['provincia'],
        observaciones: floorData['observaciones'],
        isDeleted: floorData['isDeleted'],
        alquiler: floorData['alquiler'],
        comision: floorData['comision'],
        costeCompra: floorData['costeCompra'],
        ivaItp: floorData['ivaItp'],
        gastoNotaria: floorData['gastoNotaria'],
        mobiliario: floorData['mobiliario'],
        reformas: floorData['reformas'],
        preName: floorData['preName'],
        preLastName: floorData['preLastName'],
        preDireccion: floorData['preDireccion'],
        preTelefono: floorData['preTelefono'],
        preEmail: floorData['preEmail'],
        preObservaciones: floorData['preObservaciones'],
        admName: floorData['admName'],
        admDireccion: floorData['admDireccion'],
        admTelefono: floorData['admTelefono'],
        admMovil: floorData['admMovil'],
        admEmail: floorData['admEmail'],
        aseName: floorData['aseName'],
        aseContacto: floorData['aseContacto'],
        aseTelefono: floorData['aseTelefono'],
        aseEmail: floorData['aseEmail'],
        aseObservaciones: floorData['aseObservaciones'],
      ));
    });

    _items = loadedFloors;

    notifyListeners();
  }

  Future<void> addFloor(Floor floor) {
    const url = 'https://rolo-dcd13.firebaseio.com/floors.json';

    return http
        .post(
      url,
      body: json.encode({
        'alquiler': floor.alquiler,
        'calle': floor.calle,
        'numero': floor.numero,
        'planta': floor.planta,
        'puerta': floor.puerta,
        'zipcode': floor.zipcode,
        'provincia': floor.provincia,
        'costeCompra': floor.costeCompra,
        'ivaItp': floor.ivaItp,
        'comision': floor.comision,
        'isDeleted': false,
        'mobiliario': floor.mobiliario,
        'gastoNotaria': floor.gastoNotaria,
        'reformas': floor.reformas,
        'observaciones': floor.observaciones,
        'preName': floor.preName,
        'preLastName': floor.preLastName,
        'preDireccion': floor.preDireccion,
        'preTelefono': floor.preTelefono,
        'preEmail': floor.preEmail,
        'preObservaciones': floor.preObservaciones,
        'admName': floor.admName,
        'admDireccion': floor.admDireccion,
        'admTelefono': floor.admTelefono,
        'admMovil': floor.admMovil,
        'admEmail': floor.admEmail,
        'aseName': floor.aseName,
        'aseContacto': floor.aseContacto,
        'aseTelefono': floor.aseTelefono,
        'aseEmail': floor.aseEmail,
        'aseObservaciones': floor.aseObservaciones,
      }),
    )
        .then((resp) {
      floor.id = json.decode(resp.body)['name'];
      _items.add(floor);

      notifyListeners();
    }).catchError(
      (error) => throw error,
    );
  }

  Future<void> updateFloor(Floor floor) async {
    final floorId = floor.id;

    final url = 'https://rolo-dcd13.firebaseio.com/floors/$floorId.json';

    await http.patch(
      url,
      body: json.encode({
        'alquiler': floor.alquiler,
        'calle': floor.calle,
        'numero': floor.numero,
        'planta': floor.planta,
        'puerta': floor.puerta,
        'zipcode': floor.zipcode,
        'provincia': floor.provincia,
        'costeCompra': floor.costeCompra,
        'ivaItp': floor.ivaItp,
        'comision': floor.comision,
        'isDeleted': floor.isDeleted,
        'mobiliario': floor.mobiliario,
        'gastoNotaria': floor.gastoNotaria,
        'reformas': floor.reformas,
        'observaciones': floor.observaciones,
        'preName': floor.preName,
        'preLastName': floor.preLastName,
        'preDireccion': floor.preDireccion,
        'preTelefono': floor.preTelefono,
        'preEmail': floor.preEmail,
        'preObservaciones': floor.preObservaciones,
        'admName': floor.admName,
        'admDireccion': floor.admDireccion,
        'admTelefono': floor.admTelefono,
        'admMovil': floor.admMovil,
        'admEmail': floor.admEmail,
        'aseName': floor.aseName,
        'aseContacto': floor.aseContacto,
        'aseTelefono': floor.aseTelefono,
        'aseEmail': floor.aseEmail,
        'aseObservaciones': floor.aseObservaciones,
      }),
    );

    final currentFloor = _items.indexWhere((f) => f.id == floor.id);

    _items[currentFloor] = floor;

    notifyListeners();
  }

  double valorReal(floorId) {
    var piso = findById(floorId);

    var valorReal = piso.costeCompra +
        (piso.costeCompra * piso.ivaItp / 100) +
        piso.comision +
        piso.mobiliario +
        piso.reformas;

    return valorReal;
  }
}
