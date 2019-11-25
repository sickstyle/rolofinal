import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';

import '../screens/inmueble/inmueble_screen.dart';

import '../providers/floors_provider.dart';
import '../providers/inquilinos_provider.dart';

import '../screens/inquilino/inquilino_floor.dart';

import '../screens/config_screen.dart';

import 'auth-screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const routeName = '/welcome';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  var _isInit = true;

  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<Inquilinos>(context).fetchAndSetInquilinos().then((_) {
        Provider.of<Floors>(context).fetchAndSetFloors();
        setState(() {
          _isLoading = false;
        });
      });
    }

    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final pisos = Provider.of<Floors>(context).activeFloors;

    final inquilinos = Provider.of<Inquilinos>(context).currentInquilinos;

    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Bievenido!',
        style: TextStyle(fontWeight: FontWeight.bold),
      )),
      body: Center(
          child: _isLoading
              ? CircularProgressIndicator()
              : Container(
                  padding: EdgeInsets.all(15),
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 80,
                        ),
                        Flexible(
                          child: Container(
                            margin: EdgeInsets.only(bottom: 20.0),
                            padding: EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 94.0),
                            transform: Matrix4.rotationZ(-8 * pi / 180)
                              ..translate(-10.0),
                            // ..translate(-10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.teal.shade900,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 8,
                                  color: Colors.black26,
                                  offset: Offset(0, 2),
                                )
                              ],
                            ),
                            child: Text(
                              'ROLO',
                              style: TextStyle(
                                color: Theme.of(context)
                                    .accentTextTheme
                                    .title
                                    .color,
                                fontSize: 50,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.teal.shade100,
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            color: Colors.teal.shade300,
                            child: ListTile(
                              title: Text(
                                'Datos Generales',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 22),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.teal.shade100,
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                title: Text('Pisos Totales'),
                                trailing: Text(pisos.length.toString()),
                              ),
                              ListTile(
                                title: Text('Inquilinos Totales'),
                                trailing: Text(inquilinos.length.toString()),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
      drawer: Drawer(
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
                child: Container(),
                decoration: BoxDecoration(
                  color: Colors.teal,
                ),
              ),
            ),
            Card(
              color: Colors.teal.shade200,
              elevation: 6,
              child: ListTile(
                title: Text('Inmuebles'),
                onTap: () {
                  Navigator.of(context).pushNamed(InmuebleScreen.routeName);
                },
              ),
            ),
            Card(
              color: Colors.teal.shade200,
              elevation: 6,
              child: ListTile(
                title: Text('Inquilinos'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.of(context)
                      .pushNamed(InquilinoFloor.routeName, arguments: null);
                },
              ),
            ),
            Card(
              color: Colors.teal.shade200,
              elevation: 6,
              child: ListTile(
                title: Text('Configuracion'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.of(context).pushNamed(ConfigScreen.routeName);
                },
              ),
            ),
            Card(
              color: Colors.teal.shade400,
              elevation: 6,
              child: ListTile(
                title: Text('LogOut'),
                onTap: () {
                  Navigator.of(context)
                      .pushReplacementNamed(AuthScreen.routeName);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
