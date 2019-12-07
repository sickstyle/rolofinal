import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:rolo/googleDrive.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

class ArchivoForm extends StatefulWidget {
  static const routeName = '/archivo-form';
  @override
  _ArchivoFormState createState() => _ArchivoFormState();
}

class _ArchivoFormState extends State<ArchivoForm> {
  String _fileName;
  File _file;
  String _extension;

  FileType _pickingType;

  final drive = GoogleDrive();

  void _upload() {
    drive.upload(_file);
  }

  void _openFileExplorer() async {
    try {
      _file = await FilePicker.getFile(
          type: _pickingType, fileExtension: _extension);
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    }
    if (!mounted) return;
    setState(() {
      _fileName =
          _file != null ? p.basename(_file.absolute.path).split('/').last : "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Subir Archivo"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.save),
              onPressed: _upload,
            )
          ],
        ),
        body: Center(
          child: Column(
            // horizontal).
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _fileName != null
                  ? Text(
                      _fileName,
                      textAlign: TextAlign.center,
                    )
                  : Text("Cargar un Archivo"),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _openFileExplorer,
          tooltip: 'Seleccionar',
          child: Icon(Icons.add),
        ));
  }
}
