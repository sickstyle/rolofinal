import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../providers/config.dart';

class ConfigScreen extends StatefulWidget {
  static const routeName = "/configscreen";
  @override
  _ConfigScreenState createState() => _ConfigScreenState();
}

class _ConfigScreenState extends State<ConfigScreen> {
  DateTime _selectedDate = DateTime.now();

  final _fechaActual = DateTime.now().year;

  void _presetDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime(2010),
      firstDate: DateTime(2010),
      lastDate: DateTime(2030),
    ).then((fecha) {
      if (fecha == null) {
        return;
      } else {
        setState(() {
          this._selectedDate = fecha;
        });
      }
    });
  }

  void _save(fecha) {
    Provider.of<Config>(context).setFecha(fecha).then((_) {
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configuracion'),
      ),
      body: Card(
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        elevation: 8,
        child: Container(
          color: Colors.blue.shade100,
          padding: EdgeInsets.all(16),
          height: 150,
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text(
                  _selectedDate == null
                      ? _fechaActual.toString()
                      : _selectedDate.year.toString(),
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                trailing: RaisedButton(
                  color: Colors.teal.shade200,
                  child: Text('Seleccionar Fecha'),
                  onPressed: () {
                    _presetDatePicker();
                  },
                ),
              ),
              ListTile(
                trailing: RaisedButton(
                  color: Colors.teal.shade200,
                  child: Text('Aplicar'),
                  onPressed: () {
                    _save(_selectedDate.year.toString());
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
