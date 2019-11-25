import 'package:flutter/material.dart';
import '../../screens/pagos/pagos_screen.dart';
import 'package:provider/provider.dart';

import '../../providers/floors_provider.dart';

import '../../screens/inmueble/info_screen.dart';

import '../../screens/inquilino/inquilino_floor.dart';

import '../../screens/welcome_screen.dart';

import '../../screens/inmueble/profit_screen.dart';

import '../../screens/gastos/gastos_screen.dart';

import '../../screens/archivo/archivo_screen.dart';
import '../../screens/muebles/muebles_screen.dart';

import '../../screens/inmueble/mb_teorico.dart';

class InmuebleDetails extends StatefulWidget {
  static const routeName = '/inmueble-details';

  @override
  _InmuebleDetailsState createState() => _InmuebleDetailsState();
}

class _InmuebleDetailsState extends State<InmuebleDetails> {
  @override
  Widget build(BuildContext context) {
    final floorId = ModalRoute.of(context).settings.arguments;
    final loadedFloor = Provider.of<Floors>(context).findById(floorId);

    return Scaffold(
      appBar: AppBar(
        title: Text(loadedFloor.calle),
      ),
      body: Center(
        child: InfoScreen(
          floorId: floorId,
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
              color: Colors.teal.shade100,
              elevation: 6,
              child: ListTile(
                title: Text('Gastos'),
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(GastosScreen.routeName, arguments: floorId);
                },
              ),
            ),
            Card(
              color: Colors.teal.shade100,
              elevation: 6,
              child: ListTile(
                title: Text('Pagos'),
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(PagosSecreen.routeName, arguments: floorId);
                },
              ),
            ),
            Card(
              color: Colors.teal.shade100,
              elevation: 6,
              child: ListTile(
                title: Text('Inquilinos'),
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(InquilinoFloor.routeName, arguments: floorId);
                },
              ),
            ),
            Card(
              color: Colors.teal.shade100,
              elevation: 6,
              child: ListTile(
                title: Text('Mobiliario'),
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(MueblesScreen.routeName, arguments: floorId);
                },
              ),
            ),
            Card(
              color: Colors.teal.shade100,
              elevation: 6,
              child: ListTile(
                title: Text('BAI'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.of(context)
                      .pushNamed(ProfitScreen.routeName, arguments: floorId);
                },
              ),
            ),
            Card(
              color: Colors.teal.shade100,
              elevation: 6,
              child: ListTile(
                title: Text('Margen Bruto Teorico'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.of(context)
                      .pushNamed(MbTeorico.routeName, arguments: floorId);
                },
              ),
            ),
            Card(
              color: Colors.teal.shade100,
              elevation: 6,
              child: ListTile(
                title: Text('Archivo'),
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(ArchivoScreen.routeName, arguments: floorId);
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
