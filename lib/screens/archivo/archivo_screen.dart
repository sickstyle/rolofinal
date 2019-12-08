import 'package:flutter/material.dart';
import 'package:rolo/providers/inquilino.dart';
import 'package:rolo/screens/archivo/archivo_list.dart';
import 'archivo_form.dart';

class ArchivoScreen extends StatefulWidget {
  static const routeName = '/archivo-screen';

  @override
  _ArchivoScreenState createState() => _ArchivoScreenState();
}

class _ArchivoScreenState extends State<ArchivoScreen> {
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context).settings.arguments as String;
    var floorId = arguments.split(',')[0];
    var inquilinoId = arguments.split(',')[1];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Archivos',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(ArchivoForm.routeName,
                  arguments: "$floorId,$inquilinoId");
            },
          ),
        ],
      ),
      body: Center(
        child: ArchivoList(
          floorId: floorId,
          inquilinoId: inquilinoId,
        ),
      ),
    );
  }
}
