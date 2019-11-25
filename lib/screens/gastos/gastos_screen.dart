import 'package:flutter/material.dart';

import 'gastos_form.dart';
import 'soft_deteled_gastos.dart';

import './gastos_list.dart';

class GastosScreen extends StatefulWidget {
  static const routeName = '/gastos-screen';

  @override
  _GastosScreenState createState() => _GastosScreenState();
}

class _GastosScreenState extends State<GastosScreen> {
  @override
  Widget build(BuildContext context) {
    final floorId = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Gastos',
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
                  .pushNamed(GastosForm.routeName, arguments: floorId);
            },
          ),
          IconButton(
            icon: Icon(Icons.restore_page),
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(SoftDeletedGastos.routeName, arguments: floorId);
            },
          )
        ],
      ),
      body: Center(
        child: GastosList(
          floorId: floorId,
        ),
      ),
    );
  }
}
