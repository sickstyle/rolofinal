import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../providers/floors_provider.dart';
import './floor_item.dart';

class ActiveInmuebles extends StatefulWidget {
  @override
  _ActiveInmueblesState createState() => _ActiveInmueblesState();
}

class _ActiveInmueblesState extends State<ActiveInmuebles> {
  var _isInit = true;
  var _isLoading = false;

  TextEditingController controller = new TextEditingController();
  String filter;

  @override
  void initState() {
    controller.addListener(() {
      setState(() {
        filter = controller.text.toLowerCase();
      });
    });
    super.initState();
  }

  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<Floors>(context).fetchAndSetFloors().then((_) {
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

  @override
  Widget build(BuildContext context) {
    final floorsData = Provider.of<Floors>(context);
    final pisos = floorsData.activeFloors;
    final floors = filter == null || filter == ""
        ? pisos
        : pisos.where((p) => p.calle.toLowerCase().contains(filter)).toList();

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
                      controller: controller,
                      onEditingComplete: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
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
                  itemCount: floors.length,
                  itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                    value: floors[i],
                    child: FloorItem(
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
