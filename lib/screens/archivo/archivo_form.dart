import 'dart:io';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;
import '../../providers/image.dart';

import '../../providers/images_provider.dart';

class ArchivoForm extends StatefulWidget {
  static const routeName = '/archivo-form';
  @override
  _ArchivoFormState createState() => _ArchivoFormState();
}

class _ArchivoFormState extends State<ArchivoForm> {
  TextEditingController _descripcionController = TextEditingController();

  File _storedImage;
  File _savedImage;

  var _editedImage = Foto(
    id: '',
    title: '',
    image: null,
    floorId: '',
    inquilinoId: null,
  );

  Future<void> _takePicture() async {
    final imageFile = await ImagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    setState(() {
      _storedImage = imageFile;
    });

    if (imageFile == null) {
      return;
    }

    final appDir = await syspaths.getApplicationDocumentsDirectory();

    final fileName = path.basename(imageFile.path);

    _savedImage = await imageFile.copy('${appDir.path}/$fileName');

    _editedImage.title = _descripcionController.text;
    _editedImage.image = _savedImage.path;
    _editedImage.floorId = '-Lu2DncSeEWezQ8E-EdD';
  }

  void _saveImage() {
    Provider.of<FotosProvider>(context, listen: false)
        .addFotoFloor(_editedImage);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cargar de archivo'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: _descripcionController,
                      decoration: InputDecoration(labelText: 'Descripcion'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 150,
                          height: 120,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                          ),
                          child: _storedImage != null
                              ? Image.file(
                                  _storedImage,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                )
                              : Text(
                                  'Seleccionar Imagen',
                                  textAlign: TextAlign.center,
                                ),
                          alignment: Alignment.center,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: FlatButton.icon(
                            icon: Icon(Icons.camera),
                            textColor: Theme.of(context).primaryColor,
                            label: Text('Tomar Foto'),
                            onPressed: _takePicture,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          RaisedButton.icon(
            color: Colors.teal.shade400,
            elevation: 0,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            icon: Icon(Icons.add),
            label: Text(
              'Cargar',
            ),
            onPressed: _saveImage,
          )
        ],
      ),
    );
  }
}
