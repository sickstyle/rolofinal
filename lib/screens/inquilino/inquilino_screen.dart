import 'package:flutter/material.dart';

class InquilinoScreen extends StatelessWidget {
  static const routeName = '/inquilino-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text('Inquilino'),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('Buscar'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            title: Text('Listado'),
          )
        ],
      ),
    );
  }
}
