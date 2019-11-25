import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/floors_provider.dart';

import '../../screens/inmueble/inmueble_form.dart';

class InfoScreen extends StatelessWidget {
  final floorId;

  InfoScreen({this.floorId});

  @override
  Widget build(BuildContext context) {
    final loadedFloor = Provider.of<Floors>(context).findById(floorId);
    return Container(
      child: ListView(
        children: ListTile.divideTiles(context: context, tiles: [
          Container(
            color: Colors.teal.withOpacity(0.6),
            child: ListTile(
              title: Text(
                'Info del Piso',
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
                    FloorForm.routeName,
                    arguments: floorId,
                  );
                },
              ),
            ),
          ),
          Container(
            color: Colors.teal.withOpacity(0.2),
            child: ListTile(
              leading: Text('Alquiler'),
              trailing: Text(loadedFloor.alquiler.toString() + '€'),
            ),
          ),
          ListTile(
            leading: Text('Coste de compra'),
            trailing: Text(loadedFloor.costeCompra.toString() + '€'),
          ),
          ListTile(
            leading: Text('Iva/itp'),
            trailing: Text((loadedFloor.costeCompra * loadedFloor.ivaItp / 100)
                    .toString() +
                '€'),
          ),
          ListTile(
            leading: Text('Comision'),
            trailing: Text(loadedFloor.comision.toString() + '€'),
          ),
          ListTile(
            leading: Text('Mobiliario'),
            trailing: Text(loadedFloor.mobiliario.toString() + '€'),
          ),
          ListTile(
            leading: Text('Reforma'),
            trailing: Text(loadedFloor.reformas.toString() + '€'),
          ),
          Container(
            color: Colors.teal.withOpacity(0.2),
            child: ListTile(
              leading: Text(
                'Valor real de compra',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              trailing: Text(
                  (loadedFloor.costeCompra +
                              (loadedFloor.costeCompra *
                                  loadedFloor.ivaItp /
                                  100) +
                              loadedFloor.comision +
                              loadedFloor.mobiliario +
                              loadedFloor.reformas)
                          .toString() +
                      '€',
                  style: TextStyle(fontWeight: FontWeight.w600)),
            ),
          ),
          Container(
            color: Colors.teal.withOpacity(0.6),
            child: ListTile(
              title: Text(
                'Datos del inmueble',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          ListTile(
            leading: Text('Calle'),
            trailing: Text(loadedFloor.calle),
          ),
          ListTile(
            leading: Text('Numero'),
            trailing: Text(loadedFloor.numero),
          ),
          ListTile(
            leading: Text('Planta'),
            trailing: Text(loadedFloor.planta),
          ),
          ListTile(
            leading: Text('Puerta'),
            trailing: Text(loadedFloor.puerta),
          ),
          ListTile(
            leading: Text('Codigo Postal'),
            trailing: Text(loadedFloor.zipcode),
          ),
          ListTile(
            leading: Text('Provincia'),
            trailing: Text(loadedFloor.provincia),
          ),
          Container(
            color: Colors.teal.withOpacity(0.6),
            child: ListTile(
              title: Text(
                'Presidente de la comunidad',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          ListTile(
            title: Text('Nombre'),
            trailing: Text(loadedFloor.preName),
          ),
          ListTile(
            title: Text('Apellidos'),
            trailing: Text(loadedFloor.preLastName),
          ),
          ListTile(
            title: Text('Direccion'),
            trailing: Text(loadedFloor.preDireccion),
          ),
          ListTile(
            title: Text('Telefono'),
            trailing: Text(loadedFloor.preTelefono),
          ),
          ListTile(
            title: Text('email'),
            trailing: Text(loadedFloor.preEmail),
          ),
          ListTile(
            title: Text('Observaciones'),
            trailing: Text(loadedFloor.preObservaciones),
          ),
          Container(
            color: Colors.teal.withOpacity(0.6),
            child: ListTile(
              title: Text(
                'Administrador',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          ListTile(
            title: Text('Nombre'),
            trailing: Text(loadedFloor.admName),
          ),
          ListTile(
            title: Text('Direccion'),
            trailing: Text(loadedFloor.admDireccion),
          ),
          ListTile(
            title: Text('Telefono'),
            trailing: Text(loadedFloor.admTelefono),
          ),
          ListTile(
            title: Text('Movil'),
            trailing: Text(loadedFloor.admMovil),
          ),
          ListTile(
            title: Text('Email'),
            trailing: Text(loadedFloor.admEmail),
          ),
          Container(
            color: Colors.teal.withOpacity(0.6),
            child: ListTile(
              title: Text(
                'Asegurador',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          ListTile(
            title: Text('Compañia'),
            trailing: Text(loadedFloor.aseName),
          ),
          ListTile(
            title: Text('Datos de contacto'),
            trailing: Text(loadedFloor.aseContacto),
          ),
          ListTile(
            title: Text('Telefono'),
            trailing: Text(loadedFloor.aseTelefono),
          ),
          ListTile(
            title: Text('Email'),
            trailing: Text(loadedFloor.aseEmail),
          ),
          ListTile(
            title: Text('Observaciones'),
            trailing: Text(loadedFloor.aseObservaciones),
          ),
        ]).toList(),
      ),
    );
  }
}
