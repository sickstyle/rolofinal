import 'package:flutter/material.dart';

import 'muebles_form.dart';
import 'soft_deteled_muebles.dart';

import './muebles_list.dart';

class MueblesScreen extends StatefulWidget {
  static const routeName = '/muebles-screen';

  @override
  _MueblesScreenState createState() => _MueblesScreenState();
}

class _MueblesScreenState extends State<MueblesScreen> {
  @override
  Widget build(BuildContext context) {
    final floorId = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Muebles',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(MueblesForm.routeName, arguments: floorId);
            },
          ),
          IconButton(
            icon: Icon(Icons.restore_page),
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(SoftDeletedMuebles.routeName, arguments: floorId);
            },
          )
        ],
      ),
      body: Center(
        child: MueblesList(
          floorId: floorId,
        ),
      ),
    );
  }
}
