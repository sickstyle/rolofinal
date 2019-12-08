import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rolo/googleDrive.dart';
import 'package:path/path.dart' as p;
import '../../providers/archivo.dart';
import '../../providers/archivos_provider.dart';

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

  var _isLoading = false;
  var _isInit = true;

  var _archivo = Archivo(
    floorId: '',
    inquilinoId: '',
    idarchivo: '',
    id: '',
    title: '',
    type: '',
  );

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final arguments = ModalRoute.of(context).settings.arguments as String;

      var floorId = arguments.split(',')[0];

      var inquilinoId = arguments.split(',')[1];

      if (floorId != 'null') {
        _archivo.floorId = floorId;
      } else if (inquilinoId != 'null') {
        _archivo.inquilinoId = inquilinoId;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  var drive = GoogleDrive();

  void _upload() {
    setState(() {
      _isLoading = true;
    });

    drive.upload(_file).then((res) {
      _archivo.idarchivo = res['id'];
      _archivo.title = res['name'];
      _archivo.type = res['mimeType'];

      Provider.of<Archivos>(context).addArchivo(_archivo);

      Navigator.of(context).pop();
    });
  }

  void _openFileExplorer() async {
    try {
      _file = await FilePicker.getFile(
          type: FileType.ANY, fileExtension: _extension);
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
            ),
          ],
        ),
        body: Center(
          child: _isLoading
              ? CircularProgressIndicator()
              : Column(
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
