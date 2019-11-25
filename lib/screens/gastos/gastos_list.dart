import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../providers/gastos_provider.dart';
import '../../providers/config.dart';

import 'gastos_item.dart';

class GastosList extends StatefulWidget {
  final floorId;

  GastosList({
    this.floorId,
  });

  @override
  _GastosListState createState() => _GastosListState();
}

class _GastosListState extends State<GastosList> {
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

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<Config>(context).fetchConfig();

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
    final gastosData = Provider.of<Gastos>(context);
    final selectedYear = Provider.of<Config>(context).fecha;

    final gastos = gastosData.activeGastos.where((g) =>
        DateTime.parse(g.fecha).year == DateTime(int.parse(selectedYear)).year);

    final gastosFloor = filter == null || filter == ""
        ? gastos.where((x) => x.floorId == widget.floorId).toList()
        : gastos
            .where((x) =>
                x.floorId == widget.floorId &&
                x.descripcion.toLowerCase().contains(filter))
            .toList();

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
                      onEditingComplete: () => {
                        FocusScope.of(context).requestFocus(FocusNode()),
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
          );
  }
}
