import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../providers/archivos_provider.dart';

import './widgets/archivo_item.dart';

class ArchivoList extends StatefulWidget {
  final floorId;
  final inquilinoId;

  ArchivoList({this.floorId, this.inquilinoId});

  @override
  _ArchivoListState createState() => _ArchivoListState();
}

class _ArchivoListState extends State<ArchivoList> {
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

      Provider.of<Archivos>(context).fetchAndSetArchivos().then((_) {
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
    final archivosData = Provider.of<Archivos>(context).items;

    final archivos = archivosData
        .where((ar) =>
            ar.floorId == widget.floorId ||
            ar.inquilinoId == widget.inquilinoId)
        .toList();

    final archivosPiso = filter == null || filter == ""
        ? archivos
        : archivos
            .where((ar) =>
                ar.title.toLowerCase().contains(filter) ||
                ar.type.toLowerCase().contains(filter))
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
                  itemCount: archivosPiso.length,
                  itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                    value: archivosPiso[i],
                    child: ArchivoItem(),
                  ),
                ),
              ),
            ],
          );
  }
}
