import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/furnitures_provider.dart';
import '../../providers/furniture.dart';

class MueblesItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mueble = Provider.of<Mueble>(context);
    final muebles = Provider.of<Muebles>(context);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 7,
      child: ListTile(
        onTap: () {},
        title: Text(mueble.descripcion),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(mueble.monto.toString() + '€'),
            IconButton(
              onPressed: () {
                muebles.toggleSoftDelete(mueble.id);

                Scaffold.of(context).hideCurrentSnackBar();

                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: mueble.isDeleted
                        ? Text(
                            'mueble eliminado con exito!',
                            textAlign: TextAlign.center,
                          )
                        : Text(
                            'mueble restaurado con exito!',
                            textAlign: TextAlign.center,
                          ),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              icon: mueble.isDeleted
                  ? Icon(
                      Icons.restore,
                      color: Colors.green,
                    )
                  : Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
            ),
            mueble.isDeleted
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
                                      muebles.delete(mueble.id);
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
