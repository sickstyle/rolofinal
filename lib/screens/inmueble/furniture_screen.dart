import 'package:flutter/material.dart';

class FurnitureScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: ListTile.divideTiles(context: context, tiles: [
        ListTile(
          title: Text(
            'Mobiliario',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.blue,
            ),
            onPressed: () {},
          ),
        ),
        ListTile(
          title: Text(
            'Cuarto 1',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListTile(
          title: Text('Cama'),
          trailing: Text('430.0'),
        ),
        ListTile(
          title: Text('lampara'),
          trailing: Text('100.0'),
        ),
        ListTile(
          title: Text(
            'Sala',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListTile(
          title: Text('sillon'),
          trailing: Text('120.0'),
        ),
        ListTile(
          title: Text('TV'),
          trailing: Text('80.0'),
        ),
        ListTile(
          title: Text(
            'Cocina',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListTile(
          title: Text('Cocina'),
          trailing: Text('120.0'),
        ),
        ListTile(
          title: Text('Nevera'),
          trailing: Text('80.0'),
        ),
        ListTile(
          title: Text(
            'TOTAL',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: Text(
            '930.0',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ]).toList(),
    );
  }
}
