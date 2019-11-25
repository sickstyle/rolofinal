import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../providers/payments_provider.dart';

import 'pagos_item.dart';

class SoftDeletedPagos extends StatefulWidget {
  static const routeName = '/SoftDeletedPagos';

  @override
  _SoftDeletedPagosState createState() => _SoftDeletedPagosState();
}

class _SoftDeletedPagosState extends State<SoftDeletedPagos> {
  var _isInit = true;
  var _isLoading = false;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<Pagos>(context).fetchAndSetPagos().then((_) {
        setState(() {
          _isLoading = false;
        });
      }).catchError((error) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Widget build(BuildContext context) {
    final floorId = ModalRoute.of(context).settings.arguments;
    final pagosData = Provider.of<Pagos>(context);
    final gastos = pagosData.deletedPagos;

    final gastosFloor = gastos.where((x) => x.floorId == floorId).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurar/Eliminar Pagos'),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        onEditingComplete: () => {},
                        decoration: InputDecoration(
                          icon: Icon(Icons.search),
                          labelText: 'Buscar',
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8.0),
                    itemCount: gastosFloor.length,
                    itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                      value: gastosFloor[i],
                      child: PagoItem(
                          // floors[i].id,
                          // floors[i].direccion,
                          // floors[i].alquiler,
                          ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
