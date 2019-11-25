import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/floors_provider.dart';

import 'package:intl/intl.dart';

import '../../providers/payments.dart';

import '../../providers/payments_provider.dart';

class PagosForm extends StatefulWidget {
  static const routeName = '/PagosForm';

  @override
  _PagosFormState createState() => _PagosFormState();
}

class _PagosFormState extends State<PagosForm> {
  var _isInit = true;
  var _isLoading = false;
  var _isFixed = false;

  DateTime _selectedDate;

  final _fechaActual = DateFormat.yMMMd().format(DateTime.now());

  var _editedPago = Pago(
    id: null,
    descripcion: '',
    monto: 0,
    fecha: DateTime.now().toString(),
    floorId: null,
    isDeleted: false,
    isFixed: false,
  );

  void _onChanged(bool value) {
    setState(() {
      _isFixed = value;
      _editedPago.isFixed = _isFixed;
    });
  }

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
          _editedPago.fecha = fecha.toString();
          this._selectedDate = fecha;
        });
      }
    });
  }

  @override
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
      final floor = Provider.of<Floors>(context).findById(floorId);

      _editedPago.floorId = floorId;

      _editedPago.monto = floor.alquiler;
    }
    super.didChangeDependencies();
  }

  void _saveForm() {
    _formGKey.currentState.save();

    setState(() {
      _isLoading = true;
    });

    Provider.of<Pagos>(context).addPago(_editedPago).then((_) {
      setState(() {
        _isLoading = false;
      });

      Navigator.of(context).pop();
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Registrar Pago'),
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
                                : DateFormat.yMMMd().format(_selectedDate),
                            style: TextStyle(fontSize: 15),
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
                          initialValue: _editedPago.descripcion,
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
                            _editedPago.descripcion = value;
                          },
                        ),
                        TextFormField(
                          initialValue: _editedPago.monto.toString(),
                          focusNode: _montoFocusNode,
                          decoration: InputDecoration(
                            labelText: 'Monto',
                          ),
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) {
                            _saveForm();
                          },
                          onSaved: (value) {
                            _editedPago.monto = double.parse(value);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ));
  }
}
