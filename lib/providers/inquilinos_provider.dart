import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import './inquilino.dart';

class Inquilinos with ChangeNotifier {
  List<Inquilino> _items = [];

  List<Inquilino> get items {
    return [..._items];
  }

  List<Inquilino> get currentInquilinos {
    return _items
        .where((i) => i.isActive == true && i.isDeleted == false)
        .toList();
  }

  List<Inquilino> get oldInquilinos {
    return _items
        .where((i) => i.isActive == false && i.isDeleted == false)
        .toList();
  }

  List<Inquilino> get activeInquilinos {
    return _items.where((i) => i.isDeleted == false).toList();
  }

  List<Inquilino> get inactiveInquilinos {
    return _items.where((i) => i.isDeleted == true).toList();
  }

  Inquilino findById(id) {
    return _items.firstWhere((inquilino) => inquilino.id == id);
  }

  void toggleSoftDelete(id) {
    final url = 'https://rolo-dcd13.firebaseio.com/inquilinos/$id.json';
    var inquilino = _items.firstWhere((inquilino) => inquilino.id == id);
    inquilino.isDeleted = !inquilino.isDeleted;

    http.patch(
      url,
      body: json.encode({
        'isDeleted': inquilino.isDeleted,
      }),
    );

    notifyListeners();
  }

  void delete(id) {
    final url = 'https://rolo-dcd13.firebaseio.com/inquilinos/$id.json';
    http.delete(url);

    _items.removeWhere((inquilino) => inquilino.id == id);
    notifyListeners();
  }

  Future<void> addInquilino(Inquilino inquilino) {
    const url = 'https://rolo-dcd13.firebaseio.com/inquilinos.json';

    return http
        .post(
      url,
      body: json.encode({
        'floorId': inquilino.floorId,
        'name': inquilino.name,
        'lastName': inquilino.lastName,
        'dni': inquilino.dni,
        'nacionalidad': inquilino.nacionalidad,
        'direccion': inquilino.direccion,
        'telefono': inquilino.telefono,
        'movil': inquilino.movil,
        'email': inquilino.email,
        'ccc': inquilino.ccc,
        'direccionTrabajo': inquilino.direccionTrabajo,
        'importeNomina': inquilino.importeNomina,
        'tipoContrato': inquilino.tipoContrato,
        'tgss': inquilino.tgss,
        'observaciones': inquilino.observaciones,
        'isDeleted': false,
        'isActive': true,
        'avaName': inquilino.avaName,
        'avaLastName': inquilino.avaLastName,
        'avaDni': inquilino.avaDni,
        'avaNacionalidad': inquilino.avaNacionalidad,
        'avaDireccion': inquilino.avaDireccion,
        'avaTelefono': inquilino.avaTelefono,
        'avaMovil': inquilino.avaMovil,
        'avaEmail': inquilino.avaEmail,
        'avaCcc': inquilino.avaCcc,
        'fechaEntrada': inquilino.fechaEntrada,
      }),
    )
        .then((resp) {
      inquilino.id = json.decode(resp.body)['name'];

      _items.add(inquilino);

      notifyListeners();
    }).catchError(
      (error) => throw error,
    );
  }

  Future<void> fetchAndSetInquilinos() async {
    const url = 'https://rolo-dcd13.firebaseio.com/inquilinos.json';

    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    final List<Inquilino> loadedInquilinos = [];

    extractedData.forEach((inquilinoId, inquilinoData) {
      loadedInquilinos.add(Inquilino(
        id: inquilinoId,
        floorId: inquilinoData['floorId'],
        name: inquilinoData['name'],
        lastName: inquilinoData['lastName'],
        dni: inquilinoData['dni'],
        nacionalidad: inquilinoData['nacionalidad'],
        direccion: inquilinoData['direccion'],
        telefono: inquilinoData['telefono'],
        movil: inquilinoData['movil'],
        email: inquilinoData['email'],
        ccc: inquilinoData['ccc'],
        direccionTrabajo: inquilinoData['direccionTrabajo'],
        importeNomina: inquilinoData['importeNomina'],
        tipoContrato: inquilinoData['tipoContrato'],
        tgss: inquilinoData['tgss'],
        observaciones: inquilinoData['observaciones'],
        isDeleted: inquilinoData['isDeleted'],
        isActive: inquilinoData['isActive'],
        avaName: inquilinoData['avaName'],
        avaLastName: inquilinoData['avaLastName'],
        avaDni: inquilinoData['avaDni'],
        avaNacionalidad: inquilinoData['avaNacionalidad'],
        avaDireccion: inquilinoData['avaDireccion'],
        avaTelefono: inquilinoData['avaTelefono'],
        avaMovil: inquilinoData['avaMovil'],
        avaEmail: inquilinoData['avaEmail'],
        avaCcc: inquilinoData['avaCcc'],
        fechaEntrada: inquilinoData['fechaEntrada'],
      ));
    });

    _items = loadedInquilinos;

    notifyListeners();
  }

  Future<void> updateInqulino(Inquilino inquilino) async {
    final inqulinoId = inquilino.id;

    final url = 'https://rolo-dcd13.firebaseio.com/inquilinos/$inqulinoId.json';

    await http.patch(
      url,
      body: json.encode({
        'floorId': inquilino.floorId,
        'name': inquilino.name,
        'lastName': inquilino.lastName,
        'dni': inquilino.dni,
        'nacionalidad': inquilino.nacionalidad,
        'direccion': inquilino.direccion,
        'telefono': inquilino.telefono,
        'movil': inquilino.movil,
        'email': inquilino.email,
        'ccc': inquilino.ccc,
        'direccionTrabajo': inquilino.direccionTrabajo,
        'importeNomina': inquilino.importeNomina,
        'tipoContrato': inquilino.tipoContrato,
        'tgss': inquilino.tgss,
        'observaciones': inquilino.observaciones,
        'avaName': inquilino.avaName,
        'avaLastName': inquilino.avaLastName,
        'avaDni': inquilino.avaDni,
        'avaNacionalidad': inquilino.avaNacionalidad,
        'avaDireccion': inquilino.avaDireccion,
        'avaTelefono': inquilino.avaTelefono,
        'avaMovil': inquilino.avaMovil,
        'avaEmail': inquilino.avaEmail,
        'avaCcc': inquilino.avaCcc,
        'fechaEntrada': inquilino.fechaEntrada
      }),
    );

    final currentInquilino = _items.indexWhere((i) => i.id == inquilino.id);

    _items[currentInquilino] = inquilino;

    notifyListeners();
  }
}
