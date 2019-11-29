import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../providers/inquilinos_provider.dart';

import './inquilino_item.dart';

class ActiveInquilinos extends StatefulWidget {
  final floorId;

  ActiveInquilinos({this.floorId});

  @override
  _ActiveInquilinosState createState() => _ActiveInquilinosState();
}

class _ActiveInquilinosState extends State<ActiveInquilinos> {
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

      Provider.of<Inquilinos>(context).fetchAndSetInquilinos().then((_) {
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
    final inquilinosData = Provider.of<Inquilinos>(context);
    final inquilinos = filter == null || filter == ""
        ? inquilinosData.currentInquilinos
        : inquilinosData.currentInquilinos
            .where((i) =>
                i.name.toLowerCase().contains(filter) ||
                i.lastName.toLowerCase().contains(filter))
            .toList();
    final inquilinosFloor = filter == null || filter == ""
        ? inquilinos.where((x) => x.floorId == widget.floorId).toList()
        : inquilinos
            .where((x) =>
                x.floorId == widget.floorId &&
                (x.name.toLowerCase().contains(filter) ||
                    x.lastName.toLowerCase().contains(filter)))
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
                  itemCount: widget.floorId == null
                      ? inquilinos.length
                      : inquilinosFloor.length,
                  itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                    value: widget.floorId == null
                        ? inquilinos[i]
                        : inquilinosFloor[i],
                    child: InquilinoItem(
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
