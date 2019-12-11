import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:intl/intl.dart';

import '../../providers/inquilinos_provider.dart';

import '../../screens/inquilino/inquilinos_form.dart';

class InquilinoInfo extends StatelessWidget {
  static const routeName = '/inquilino-info';

  final inquilinoId;

  InquilinoInfo({this.inquilinoId});

  @override
  Widget build(BuildContext context) {
    final loadedInquilino =
        Provider.of<Inquilinos>(context).findById(inquilinoId);
    return Container(
      child: ListView(
        children: ListTile.divideTiles(context: context, tiles: [
          Container(
            color: Colors.teal.withOpacity(0.6),
            child: ListTile(
              title: Text(
                'Datos Personales',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(
                    InquilinoForm.routeName,
                    arguments: 'null,' + inquilinoId,
                  );
                },
              ),
            ),
          ),
          ListTile(
            leading: Text('Fecha de Entrada'),
            trailing: Text(DateFormat.yMMMd()
                .format(DateTime.parse(loadedInquilino.fechaEntrada))),
          ),
          ListTile(
            leading: Text('Nombre'),
            trailing: Text(loadedInquilino.name),
          ),
          ListTile(
            leading: Text('Apellido'),
            trailing: Text(loadedInquilino.lastName),
          ),
          ListTile(
            leading: Text('DNI/NIE'),
            trailing: Text(loadedInquilino.dni),
          ),
          ListTile(
            leading: Text('Nacionalidad'),
            trailing: Text(loadedInquilino.nacionalidad),
          ),
          ListTile(
            leading: Text('Direccion'),
            trailing: Text(loadedInquilino.direccion),
          ),
          ListTile(
            leading: Text('Telefono'),
            trailing: Text(loadedInquilino.telefono),
          ),
          ListTile(
            leading: Text('Movil'),
            trailing: Text(loadedInquilino.movil),
          ),
          ListTile(
            leading: Text('Email'),
            trailing: Text(loadedInquilino.email),
          ),
          ListTile(
            leading: Text('C.C.C'),
            trailing: Text(loadedInquilino.ccc),
          ),
          Container(
            color: Colors.teal.withOpacity(0.6),
            child: ListTile(
              title: Text(
                'Trabajo',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          ListTile(
            leading: Text('Direccion'),
            trailing: Text(loadedInquilino.direccionTrabajo),
          ),
          ListTile(
            leading: Text('Importe Nomina'),
            trailing: Text(loadedInquilino.importeNomina + '€'),
          ),
          ListTile(
            leading: Text('Tipo Contrato'),
            trailing: Text(loadedInquilino.tipoContrato),
          ),
          ListTile(
            leading: Text('TGSS'),
            trailing: loadedInquilino.tgss != null
                ? Text(DateFormat.yMMMMd()
                    .format(DateTime.parse(loadedInquilino.tgss)))
                : "",
          ),
          ListTile(
            leading: Text('Observaciones'),
            trailing: Text(loadedInquilino.observaciones),
          ),
          Container(
            color: Colors.teal.withOpacity(0.6),
            child: ListTile(
              title: Text(
                'Avalista',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          ListTile(
            leading: Text('Nombre'),
            trailing: Text(loadedInquilino.avaName),
          ),
          ListTile(
            leading: Text('Apellido'),
            trailing: Text(loadedInquilino.avaLastName),
          ),
          ListTile(
            leading: Text('DNI/NIE'),
            trailing: Text(loadedInquilino.avaDni),
          ),
          ListTile(
            leading: Text('Nacionalidad'),
            trailing: Text(loadedInquilino.avaNacionalidad),
          ),
          ListTile(
            leading: Text('Direccion'),
            trailing: Text(loadedInquilino.avaDireccion),
          ),
          ListTile(
            leading: Text('Telefono'),
            trailing: Text(loadedInquilino.avaTelefono),
          ),
          ListTile(
            leading: Text('Movil'),
            trailing: Text(loadedInquilino.avaMovil),
          ),
          ListTile(
            leading: Text('Email'),
            trailing: Text(loadedInquilino.avaEmail),
          ),
          ListTile(
            leading: Text('C.C.C'),
            trailing: Text(loadedInquilino.avaCcc),
          ),
        ]).toList(),
      ),
    );
  }
}
