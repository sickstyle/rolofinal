import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Config with ChangeNotifier {
  String _fecha;

  String get fecha {
    return _fecha;
  }

  Future<void> fetchConfig() async {
    final url =
        'https://rolo-dcd13.firebaseio.com/config/-LuCB9mHXiuu_IXrzuaG.json';
    final response = await http.get(url);
    final data = json.decode(response.body) as Map<String, dynamic>;

    _fecha = data['año'];
  }

  Future<void> setFecha(fecha) {
    const url =
        'https://rolo-dcd13.firebaseio.com/config/-LuCB9mHXiuu_IXrzuaG.json';

    return http.patch(
      url,
      body: json.encode({
        'año': fecha,
      }),
    );
  }
}
