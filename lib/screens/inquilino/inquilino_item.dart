import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/inquilinos_provider.dart';
import '../../providers/inquilino.dart';

import './inquilino_details.dart';

class InquilinoItem extends StatelessWidget {
  // final int id;
  // final String direccion;
  // final double alquiler;

  // inquilinoItem(
  //   this.id,
  //   this.direccion,
  //   this.alquiler,
  // );

  @override
  Widget build(BuildContext context) {
    final inquilino = Provider.of<Inquilino>(context);
    final inquilinos = Provider.of<Inquilinos>(context);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 7,
      child: ListTile(
        onTap: () {
          Navigator.of(context)
              .pushNamed(InquilinoDetails.routeName, arguments: inquilino.id);
        },
        title: Text(inquilino.name),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              inquilino.lastName,
            ),
            IconButton(
              onPressed: () {
                inquilinos.toggleSoftDelete(inquilino.id);

                Scaffold.of(context).hideCurrentSnackBar();

                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: inquilino.isDeleted
                        ? Text(
                            'Inquilino eliminado con exito!',
                            textAlign: TextAlign.center,
                          )
                        : Text(
                            'Inquilino restaurado con exito!',
                            textAlign: TextAlign.center,
                          ),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              icon: inquilino.isDeleted
                  ? Icon(
                      Icons.restore,
                      color: Colors.green,
                    )
                  : Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
            ),
            inquilino.isDeleted
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
                                      inquilinos.delete(inquilino.id);
                                      Navigator.of(context).pop();
                                      Scaffold.of(context)
                                          .hideCurrentSnackBar();

                                      Scaffold.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(
                                          'Inquilino eliminado con exito!',
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
