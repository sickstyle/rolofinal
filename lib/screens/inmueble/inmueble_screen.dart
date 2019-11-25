import 'package:flutter/material.dart';

import '../../widgets/active_inmuebles.dart';
import '../../screens/inmueble/soft_deleted_inmuebles.dart';
import '../../screens/inmueble/inmueble_form.dart';

enum PageEnum { inmueble, inquilino }

class InmuebleScreen extends StatefulWidget {
  static const routeName = '/inmueble-screen';

  InmuebleScreen({Key key}) : super(key: key);

  @override
  _InmuebleScreenState createState() => _InmuebleScreenState();
}

class _InmuebleScreenState extends State<InmuebleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Inmuebles',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(FloorForm.routeName);
            },
          ),
          IconButton(
            icon: Icon(Icons.restore_page),
            onPressed: () {
              Navigator.of(context).pushNamed(SoftDeletedInmuebles.routeName);
            },
          )
        ],
      ),
      body: Center(
        child: ActiveInmuebles(),
      ),
    );
  }
}
