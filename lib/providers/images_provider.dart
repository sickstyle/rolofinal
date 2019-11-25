import 'dart:io';
import './image.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FotosProvider with ChangeNotifier {
  List<Foto> _items = [];

  List<Foto> get items {
    return [..._items];
  }

  Future<void> addFotoFloor(Foto imagen) {
    const url = 'https://rolo-dcd13.firebaseio.com/images.json';

    return http
        .post(
      url,
      body: json.encode({
        'title': imagen.title,
        'image': imagen.image,
        'floorId': imagen.floorId,
        'inquilinoId': '',
      }),
    )
        .then((resp) {
      imagen.id = json.decode(resp.body)['name'];
      _items.add(imagen);
      notifyListeners();
    }).catchError(
      (error) => throw error,
    );
  }

  Future<void> fetchAndSetFotos() async {
    const url = 'https://rolo-dcd13.firebaseio.com/images.json';

    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    final List<Foto> loadedFotos = [];

    extractedData.forEach((fotoId, fotosData) {
      loadedFotos.add(Foto(
        id: fotoId,
        floorId: fotosData['floorId'],
        image: fotosData['image'],
        title: fotosData['title'],
        inquilinoId: fotosData['inquilinoId'],
      ));
    });

    _items = loadedFotos;

    print(_items);
    notifyListeners();
  }
}
