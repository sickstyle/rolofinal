import 'package:flutter/material.dart';

import 'pagos_form.dart';
import 'soft_deteled_pagos.dart';

import './pagos_list.dart';

class PagosSecreen extends StatefulWidget {
  static const routeName = '/pagos-screen';

  @override
  _PagosSecreenState createState() => _PagosSecreenState();
}

class _PagosSecreenState extends State<PagosSecreen> {
  @override
  Widget build(BuildContext context) {
    final floorId = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pagos',
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
                  .pushNamed(PagosForm.routeName, arguments: floorId);
            },
          ),
          IconButton(
            icon: Icon(Icons.restore_page),
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(SoftDeletedPagos.routeName, arguments: floorId);
            },
          )
        ],
      ),
      body: Center(
        child: PagosList(
          floorId: floorId,
        ),
      ),
    );
  }
}
