import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/inmueble/inmueble_details_screen.dart';

import '../providers/floor.dart';
import '../providers/floors_provider.dart';

class FloorItem extends StatelessWidget {
  // final int id;
  // final String direccion;
  // final double alquiler;

  // FloorItem(
  //   this.id,
  //   this.direccion,
  //   this.alquiler,
  // );

  @override
  Widget build(BuildContext context) {
    final floor = Provider.of<Floor>(context);
    final floors = Provider.of<Floors>(context);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 7,
      child: ListTile(
        onTap: () {
          Navigator.of(context).pushNamed(
            InmuebleDetails.routeName,
            arguments: floor.id,
          );
        },
        title: Text(floor.calle),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              floor.alquiler.toString() + '€',
            ),
            IconButton(
              onPressed: () {
                floors.toggleSoftDelete(floor.id);

                Scaffold.of(context).hideCurrentSnackBar();

                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: floor.isDeleted
                        ? Text(
                            'Piso eliminado con exito!',
                            textAlign: TextAlign.center,
                          )
                        : Text(
                            'Piso restaurado con exito!',
                            textAlign: TextAlign.center,
                          ),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              icon: floor.isDeleted
                  ? Icon(
                      Icons.restore,
                      color: Colors.green,
                    )
                  : Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
            ),
            floor.isDeleted
                ? IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (ctx) {
                            return AlertDialog(
                              title: Text('Estas seguro?'),
                              content:
                                  Text('Seguro que quieres eliminar esto?'),
                              actions: <Widget>[
                                FlatButton(
                                    child: Text('Si'),
                                    onPressed: () {
                                      floors.delete(floor.id);
                                      Navigator.of(context).pop();
                                      Scaffold.of(context)
                                          .hideCurrentSnackBar();

                                      Scaffold.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(
                                          'Piso eliminado con exito!',
                                          textAlign: TextAlign.center,
                                        ),
                                        duration: Duration(seconds: 2),
                                      ));
                                    }),
                                FlatButton(
                                  child: Text('No'),
                                  onPressed: () => Navigator.of(context).pop(),
                                )
                              ],
                            );
                          });
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  )
                : new Container(width: 0, height: 0),
          ],
        ),
      ),
    );
  }
}
