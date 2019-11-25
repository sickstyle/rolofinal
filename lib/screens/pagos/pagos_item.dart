import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/payments_provider.dart';
import '../../providers/payments.dart';
import 'package:intl/intl.dart';

class PagoItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pago = Provider.of<Pago>(context);
    final pagos = Provider.of<Pagos>(context);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 7,
      child: ListTile(
        onTap: () {},
        title: Text(pago.descripcion),
        leading: Text(
          DateFormat.yMMMd().format(DateTime.parse(pago.fecha)),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(pago.monto.toString() + '€'),
            IconButton(
              onPressed: () {
                pagos.toggleSoftDelete(pago.id);

                Scaffold.of(context).hideCurrentSnackBar();

                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: pago.isDeleted
                        ? Text(
                            'Pago eliminado con exito!',
                            textAlign: TextAlign.center,
                          )
                        : Text(
                            'Pago restaurado con exito!',
                            textAlign: TextAlign.center,
                          ),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              icon: pago.isDeleted
                  ? Icon(
                      Icons.restore,
                      color: Colors.green,
                    )
                  : Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
            ),
            pago.isDeleted
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
                                      pagos.delete(pago.id);
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
