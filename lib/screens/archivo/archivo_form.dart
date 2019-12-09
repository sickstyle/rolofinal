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
  FileType _pickingType;
  String _extension;
  TextEditingController _controller = new TextEditingController();
  bool _hasValidMime = false;
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

  void initState() {
    super.initState();
    _controller.addListener(() => _extension = _controller.text);
  }

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
                    new Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: new DropdownButton(
                        hint: new Text('Cargar Desde'),
                        value: _pickingType,
                        items: <DropdownMenuItem>[
                          new DropdownMenuItem(
                            child: new Text('AUDIO'),
                            value: FileType.AUDIO,
                          ),
                          new DropdownMenuItem(
                            child: new Text('IMAGEN'),
                            value: FileType.IMAGE,
                          ),
                          new DropdownMenuItem(
                            child: new Text('VIDEO'),
                            value: FileType.VIDEO,
                          ),
                          new DropdownMenuItem(
                            child: new Text('CUALQUIERA'),
                            value: FileType.ANY,
                          ),
                          new DropdownMenuItem(
                            child: new Text('PERSONALIZADO'),
                            value: FileType.CUSTOM,
                          ),
                        ],
                        onChanged: (value) => setState(() {
                          _pickingType = value;
                          if (_pickingType != FileType.CUSTOM) {
                            _controller.text = _extension = '';
                          }
                        }),
                      ),
                    ),
                    new ConstrainedBox(
                      constraints: BoxConstraints.tightFor(width: 100.0),
                      child: _pickingType == FileType.CUSTOM
                          ? new TextFormField(
                              maxLength: 15,
                              autovalidate: true,
                              controller: _controller,
                              decoration: InputDecoration(
                                  labelText: 'Extension del archivo'),
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.none,
                              validator: (value) {
                                RegExp reg = new RegExp(r'[^a-zA-Z0-9]');
                                if (reg.hasMatch(value)) {
                                  _hasValidMime = false;
                                  return 'Formato invalido';
                                }
                                _hasValidMime = true;
                                return null;
                              },
                            )
                          : new Container(),
                    ),
                    _fileName != null ? Text(_fileName) : Container(),
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
