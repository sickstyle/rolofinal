import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../providers/furnitures_provider.dart';

import 'muebles_item.dart';

class SoftDeletedMuebles extends StatefulWidget {
  static const routeName = '/SoftDeletedMuebles';

  @override
  _SoftDeletedMueblesState createState() => _SoftDeletedMueblesState();
}

class _SoftDeletedMueblesState extends State<SoftDeletedMuebles> {
  var _isInit = true;
  var _isLoading = false;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<Muebles>(context).fetchAndSetMuebles().then((_) {
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
    final mueblesData = Provider.of<Muebles>(context);
    final muebles = mueblesData.deletedMuebles;

    final mueblesFloor = muebles.where((x) => x.floorId == floorId).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurar/Eliminar Muebles'),
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
                    itemCount: mueblesFloor.length,
                    itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                      value: mueblesFloor[i],
                      child: MueblesItem(
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
