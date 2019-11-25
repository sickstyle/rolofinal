import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/furniture.dart';

import '../../providers/furnitures_provider.dart';

class MueblesForm extends StatefulWidget {
  static const routeName = '/MueblesForm';

  @override
  _MueblesFormState createState() => _MueblesFormState();
}

class _MueblesFormState extends State<MueblesForm> {
  var _isInit = true;
  var _isLoading = false;

  var _editedMueble = Mueble(
    id: null,
    descripcion: '',
    monto: 0,
    floorId: null,
    isDeleted: false,
  );

  final _formGKey = GlobalKey<FormState>();

//FOCUS NODES

  final _descripcionFocusNode = FocusNode();
  final _montoFocusNode = FocusNode();
  final _fechaFocusNode = FocusNode();

  @override
  void dispose() {
    _descripcionFocusNode.dispose();
    _montoFocusNode.dispose();
    _fechaFocusNode.dispose();

    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final floorId = ModalRoute.of(context).settings.arguments as String;

      _editedMueble.floorId = floorId;
    }
    super.didChangeDependencies();
  }

  void _saveForm() {
    _formGKey.currentState.save();

    setState(() {
      _isLoading = true;
    });

    Provider.of<Muebles>(context).addMueble(_editedMueble).then((_) {
      setState(() {
        _isLoading = false;
      });

      Navigator.of(context).pop();
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Registrar Mueble'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                _saveForm();
              },
            )
          ],
        ),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formGKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Container(
                          color: Colors.teal.withOpacity(0.6),
                          child: ListTile(
                            title: Text(
                              'Descripcion',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                        ),
                        TextFormField(
                          initialValue: _editedMueble.descripcion,
                          focusNode: _descripcionFocusNode,
                          decoration: InputDecoration(
                            labelText: 'Descripcion',
                          ),
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_montoFocusNode);
                          },
                          onSaved: (value) {
                            _editedMueble.descripcion = value;
                          },
                        ),
                        TextFormField(
                          initialValue: _editedMueble.monto.toString(),
                          focusNode: _montoFocusNode,
                          decoration: InputDecoration(
                            labelText: 'Monto',
                          ),
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) {
                            _saveForm();
                          },
                          onSaved: (value) {
                            _editedMueble.monto = double.parse(value);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ));
  }
}
