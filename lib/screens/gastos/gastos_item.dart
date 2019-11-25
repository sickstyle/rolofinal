import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/gastos_provider.dart';
import '../../providers/gasto.dart';
import 'package:intl/intl.dart';

class GastoItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final gasto = Provider.of<Gasto>(context);
    final gastos = Provider.of<Gastos>(context);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 7,
      child: ListTile(
        onTap: () {},
        title: Text(gasto.descripcion),
        leading: Text(
          DateFormat.yMMMd().format(DateTime.parse(gasto.fecha)),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(gasto.monto.toString() + '€'),
            IconButton(
              onPressed: () {
                gastos.toggleSoftDelete(gasto.id);

                Scaffold.of(context).hideCurrentSnackBar();

                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: gasto.isDeleted
                        ? Text(
                            'Gasto eliminado con exito!',
                            textAlign: TextAlign.center,
                          )
                        : Text(
                            'Gasto restaurado con exito!',
                            textAlign: TextAlign.center,
                          ),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              icon: gasto.isDeleted
                  ? Icon(
                      Icons.restore,
                      color: Colors.green,
                    )
                  : Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
            ),
            gasto.isDeleted
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
                                      gastos.delete(gasto.id);
                                      Navigator.of(context).pop();
                                      Scaffold.of(context)
                                          .hideCurrentSnackBar();

                                      Scaffold.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(
                                          'Gasto eliminado con exito!',
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
