import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';

class ArchivoForm extends StatefulWidget {
  static const routeName = '/archivo-form';
  @override
  _ArchivoFormState createState() => _ArchivoFormState();
}

class _ArchivoFormState extends State<ArchivoForm> {
  String _fileName;
  String _path;
  String _extension;

  FileType _pickingType;

  void _openFileExplorer() async {
    try {
      _path = await FilePicker.getFilePath(
          type: _pickingType, fileExtension: _extension);
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    }
    if (!mounted) return;
    setState(() {
      _fileName = _path != null ? _path.split('/').last : "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Subir Archivo"),
        ),
        body: Center(
          child: Column(
            // horizontal).
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _fileName != null
                  ? Text(
                      _path,
                      textAlign: TextAlign.center,
                    )
                  : Text("Cargar un Archivo"),
            ],
          ),
        ),
        floatingActionButton: _path == null
            ? FloatingActionButton(
                onPressed: _openFileExplorer,
                tooltip: 'Seleccionar',
                child: Icon(Icons.add),
              )
            : FloatingActionButton(
                onPressed: _openFileExplorer,
                tooltip: 'Guardar',
                child: Icon(Icons
                    .save), // This trailing comma makes auto-formatting nicer for build methods.
              ));
  }
}
