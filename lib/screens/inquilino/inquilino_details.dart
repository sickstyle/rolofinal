import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/inquilinos_provider.dart';

import '../../screens/inquilino/inquilino_info.dart';

import '../../screens/inquilino/inquilino_floor.dart';

import '../../screens/welcome_screen.dart';

class InquilinoDetails extends StatefulWidget {
  static const routeName = '/inquilino-details';

  @override
  _InquilinoDetailsState createState() => _InquilinoDetailsState();
}

class _InquilinoDetailsState extends State<InquilinoDetails> {
  @override
  Widget build(BuildContext context) {
    final inquilinoId = ModalRoute.of(context).settings.arguments;
    final loadedInquilino =
        Provider.of<Inquilinos>(context).findById(inquilinoId);

    return Scaffold(
      appBar: AppBar(
        title: Text(loadedInquilino.name + ' ' + loadedInquilino.lastName),
      ),
      body: Center(
        child: InquilinoInfo(
          inquilinoId: inquilinoId,
        ),
      ),
      endDrawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 90,
              child: DrawerHeader(
                child: Container(
                  height: 100,
                  color: Colors.teal,
                ),
                decoration: BoxDecoration(
                  color: Colors.teal,
                ),
              ),
            ),
            Card(
              color: Colors.teal.shade300,
              elevation: 6,
              child: ListTile(
                title: Text('Dar de baja'),
                onTap: () {},
              ),
            ),
            Card(
              color: Colors.teal.shade100,
              elevation: 6,
              child: ListTile(
                title: Text('Archivo'),
                onTap: () {
                  Navigator.of(context).pushNamed(InquilinoFloor.routeName);
                },
              ),
            ),
            Card(
              color: Colors.teal.shade200,
              elevation: 6,
              child: ListTile(
                title: Text('Inicio'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.of(context)
                      .pushReplacementNamed(WelcomeScreen.routeName);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
