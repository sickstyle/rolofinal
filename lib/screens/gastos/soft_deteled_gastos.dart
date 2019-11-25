import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../providers/gastos_provider.dart';

import 'gastos_item.dart';

class SoftDeletedGastos extends StatefulWidget {
  static const routeName = '/softDeletedGastos';

  @override
  _SoftDeletedGastosState createState() => _SoftDeletedGastosState();
}

class _SoftDeletedGastosState extends State<SoftDeletedGastos> {
  var _isInit = true;
  var _isLoading = false;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<Gastos>(context).fetchAndSetGastos().then((_) {
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
    final gastosData = Provider.of<Gastos>(context);
    final gastos = gastosData.deletedGastos;

    final gastosFloor = gastos.where((x) => x.floorId == floorId).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurar/Eliminar Gastos'),
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
                      child: GastoItem(
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
