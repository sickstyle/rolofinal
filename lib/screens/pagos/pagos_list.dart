import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../providers/payments_provider.dart';
import '../../providers/config.dart';

import 'pagos_item.dart';

class PagosList extends StatefulWidget {
  final floorId;

  PagosList({
    this.floorId,
  });

  @override
  _PagosListState createState() => _PagosListState();
}

class _PagosListState extends State<PagosList> {
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
    final pagosData = Provider.of<Pagos>(context);
    final selectedYear = Provider.of<Config>(context).fecha;

    final pagos = pagosData.activePagos.where((g) =>
        DateTime.parse(g.fecha).year == DateTime(int.parse(selectedYear)).year);

    final pagosFloor = filter == null || filter == ""
        ? pagos.where((x) => x.floorId == widget.floorId).toList()
        : pagos
            .where((p) => p.descripcion.toLowerCase().contains(filter))
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
                  itemCount: pagosFloor.length,
                  itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                    value: pagosFloor[i],
                    child: PagoItem(
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
