import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/inquilino/inquilino_details.dart';
import 'package:provider/provider.dart';

import './screens/welcome_screen.dart';

import 'screens/inmueble/inmueble_screen.dart';
// import 'screens/inquilino_screen.dart';
// import 'screens/admin_screen.dart';
import 'screens/inmueble/inmueble_details_screen.dart';
import 'screens/inquilino/inquilino_screen.dart';
import 'screens/inmueble/inmueble_form.dart';
import 'screens/inmueble/soft_deleted_inmuebles.dart';

import 'screens/inquilino/inquilino_floor.dart';
import 'screens/inquilino/soft_deleted_inquilinos.dart';
import 'screens/inquilino/inquilinos_form.dart';

import 'screens/gastos/gastos_screen.dart';
import 'screens/gastos/soft_deteled_gastos.dart';

import 'screens/muebles/muebles_form.dart';
import 'screens/muebles/soft_deteled_muebles.dart';
import 'screens/muebles/muebles_screen.dart';

import 'screens/inmueble/mb_teorico.dart';

import 'screens/pagos/soft_deteled_pagos.dart';

import 'screens/pagos/pagos_form.dart';

import 'screens/pagos/pagos_screen.dart';

import 'providers/gastos_provider.dart';

import 'providers/payments_provider.dart';
import 'providers/furnitures_provider.dart';
import 'providers/config.dart';

import 'screens/archivo/archivo_form.dart';

import 'screens/gastos/gastos_form.dart';

import 'providers/floors_provider.dart';
import 'providers/inquilinos_provider.dart';
import 'screens/config_screen.dart';

import 'screens/inmueble/profit_screen.dart';

import 'screens/auth-screen.dart';

import 'providers/auth.dart';
import 'screens/archivo/archivo_screen.dart';
import 'providers/images_provider.dart';

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Floors(),
        ),
        ChangeNotifierProvider.value(
          value: Inquilinos(),
        ),
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProvider.value(
          value: Gastos(),
        ),
        ChangeNotifierProvider.value(
          value: Pagos(),
        ),
        ChangeNotifierProvider.value(
          value: Muebles(),
        ),
        ChangeNotifierProvider.value(
          value: Config(),
        ),
        ChangeNotifierProvider.value(
          value: FotosProvider(),
        )
      ],
      child: MaterialApp(
        locale: Locale('es_Es'),
        debugShowCheckedModeBanner: false,
        title: 'ROLO',
        routes: {
          InmuebleScreen.routeName: (ctx) => InmuebleScreen(),
          InmuebleDetails.routeName: (ctx) => InmuebleDetails(),
          InquilinoScreen.routeName: (ctx) => InquilinoScreen(),
          SoftDeletedInmuebles.routeName: (ctx) => SoftDeletedInmuebles(),
          FloorForm.routeName: (ctx) => FloorForm(),
          InquilinoFloor.routeName: (ctx) => InquilinoFloor(),
          SoftDeletedInquilinos.routeName: (ctx) => SoftDeletedInquilinos(),
          InquilinoForm.routeName: (ctx) => InquilinoForm(),
          WelcomeScreen.routeName: (ctx) => WelcomeScreen(),
          ProfitScreen.routeName: (ctx) => ProfitScreen(),
          InquilinoDetails.routeName: (ctx) => InquilinoDetails(),
          AuthScreen.routeName: (ctx) => AuthScreen(),
          GastosScreen.routeName: (ctx) => GastosScreen(),
          GastosForm.routeName: (ctx) => GastosForm(),
          SoftDeletedGastos.routeName: (ctx) => SoftDeletedGastos(),
          PagosSecreen.routeName: (ctx) => PagosSecreen(),
          PagosForm.routeName: (ctx) => PagosForm(),
          SoftDeletedPagos.routeName: (ctx) => SoftDeletedPagos(),
          MueblesForm.routeName: (ctx) => MueblesForm(),
          MueblesScreen.routeName: (ctx) => MueblesScreen(),
          SoftDeletedMuebles.routeName: (ctx) => SoftDeletedMuebles(),
          MbTeorico.routeName: (ctx) => MbTeorico(),
          ConfigScreen.routeName: (ctx) => ConfigScreen(),
          ArchivoForm.routeName: (ctx) => ArchivoForm(),
          ArchivoScreen.routeName: (ctx) => ArchivoScreen(),
        },
        theme: ThemeData(
          primarySwatch: Colors.teal,
          textTheme: TextTheme(
            title: TextStyle(fontSize: 18),
            body1: TextStyle(fontSize: 18),
          ),
        ),
        home: AuthScreen(),
        /*     home: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              title: Center(
                child: Text(
                  'GrupoConstant',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              bottom: TabBar(
                tabs: <Widget>[
                  Text(
                    'Inmueble',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  Text(
                    'Inquilino',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  Text(
                    'Admin',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                InmuebleScreen(),
                InquilinoScreen(),
                AdminScreen(),
              ],
            ),
          ),
        ), */
      ),
    );
  }
}
