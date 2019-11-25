import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../providers/furnitures_provider.dart';

import 'muebles_item.dart';

class MueblesList extends StatefulWidget {
  final floorId;

  MueblesList({
    this.floorId,
  });

  @override
  _MueblesListState createState() => _MueblesListState();
}

class _MueblesListState extends State<MueblesList> {
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
    final mueblesData = Provider.of<Muebles>(context);
    final muebles = mueblesData.activeMuebles;

    final mueblesFloor =
        muebles.where((x) => x.floorId == widget.floorId).toList();

    return _isLoading
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
          );
  }
}
