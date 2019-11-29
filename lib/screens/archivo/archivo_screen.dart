import 'package:flutter/material.dart';
import '../../screens/archivo/archivo_form.dart';
import 'package:provider/provider.dart';
import '../../providers/images_provider.dart';

import 'dart:io';

class ArchivoScreen extends StatefulWidget {
  static const routeName = '/archive-screen';

  @override
  _ArchivoScreenState createState() => _ArchivoScreenState();
}

class _ArchivoScreenState extends State<ArchivoScreen> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<FotosProvider>(context).fetchAndSetFotos().then((_) {
        setState(() {
          _isLoading = false;
        });
      }).catchError((error) {
        print(error);
        setState(() {
          _isLoading = false;
        });
      });
      _isInit = false;
      super.didChangeDependencies();
    }
  }

  @override
  Widget build(BuildContext context) {
    final floorId = ModalRoute.of(context).settings.arguments;

    final fotosData = Provider.of<FotosProvider>(context);

    final fotosPiso =
        fotosData.items.where((f) => f.floorId == floorId).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Archivo'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(ArchivoForm.routeName);
            },
          )
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: fotosPiso.length <= 0
                  ? Text('No hay Archivos')
                  : ListView.builder(
                      itemCount: fotosPiso.length,
                      itemBuilder: (ctx, i) => ListTile(
                        leading: CircleAvatar(
                          backgroundImage: FileImage(File(fotosPiso[i].image)),
                        ),
                        title: Text(fotosPiso[i].title),
                        onTap: () {},
                      ),
                    ),
            ),
    );
  }
}
