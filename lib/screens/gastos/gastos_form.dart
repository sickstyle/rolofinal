import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../providers/gasto.dart';

import '../../providers/gastos_provider.dart';

class GastosForm extends StatefulWidget {
  static const routeName = '/gastosForm';

  @override
  _GastosFormState createState() => _GastosFormState();
}

class _GastosFormState extends State<GastosForm> {
  var _isInit = true;
  var _isLoading = false;
  var _isFixed = false;

  DateTime _selectedDate;

  final _fechaActual = DateFormat.yMMMd().format(DateTime.now());

  var _editedGasto = Gasto(
    id: null,
    descripcion: '',
    monto: 0,
    fecha: DateTime.now().toString(),
    floorId: null,
    isDeleted: false,
    isFixed: false,
  );

  void _presetDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((fecha) {
      if (fecha == null) {
        return;
      } else {
        setState(() {
          _editedGasto.fecha = fecha.toString();
          this._selectedDate = fecha;
        });
      }
    });
  }

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

  void _onChanged(bool value) {
    setState(() {
      _isFixed = value;
      _editedGasto.isFixed = _isFixed;
    });
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final floorId = ModalRoute.of(context).settings.arguments as String;

      _editedGasto.floorId = floorId;
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void _saveForm() {
    _formGKey.currentState.save();

    setState(() {
      _isLoading = true;
    });

    Provider.of<Gastos>(context).addGasto(_editedGasto).then((_) {
      setState(() {
        _isLoading = false;
      });

      Navigator.of(context).pop();
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Registrar Gasto'),
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
                        ListTile(
                          title: Text(
                            _selectedDate == null
                                ? _fechaActual
                                : DateFormat.yMMMMd().format(_selectedDate),
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          trailing: RaisedButton(
                            color: Colors.teal.shade200,
                            child: Text('Seleccionar Fecha'),
                            onPressed: () {
                              _presetDatePicker();
                            },
                          ),
                        ),
                        ListTile(
                          title: Text(
                              _isFixed == false
                                  ? 'Tipo: Especifico'
                                  : 'Tipo: Proyectado',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold)),
                          trailing: Switch(
                            value: _isFixed,
                            onChanged: (bool value) {
                              _onChanged(value);
                            },
                          ),
                        ),
                        TextFormField(
                          initialValue: _editedGasto.descripcion,
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
                            _editedGasto.descripcion = value;
                          },
                        ),
                        TextFormField(
                          initialValue: _editedGasto.monto.toString(),
                          focusNode: _montoFocusNode,
                          decoration: InputDecoration(
                            labelText: 'Monto',
                          ),
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (_) {
                            _saveForm();
                          },
                          onSaved: (value) {
                            _editedGasto.monto = double.parse(value);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ));
  }
}
