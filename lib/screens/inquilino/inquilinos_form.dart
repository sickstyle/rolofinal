import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../providers/inquilino.dart';
import '../../providers/inquilinos_provider.dart';

import '../../screens/inquilino/inquilino_floor.dart';

class InquilinoForm extends StatefulWidget {
  static const routeName = '/InquilinoForm';
  @override
  _InquilinoFormState createState() => _InquilinoFormState();
}

class _InquilinoFormState extends State<InquilinoForm> {
  var _isInit = true;
  var _isLoading = false;

  DateTime _selectedDate;

  DateTime _fechaEntrada;

  var fechaActual = DateFormat.yMMMMd().format(DateTime.now());

  var _editedInquilino = Inquilino(
    id: null,
    floorId: '',
    name: '',
    lastName: '',
    dni: '',
    nacionalidad: '',
    direccion: '',
    telefono: '',
    movil: '',
    email: '',
    ccc: '',
    direccionTrabajo: '   ',
    importeNomina: '',
    tipoContrato: '',
    tgss: '',
    observaciones: ' ',
    isActive: true,
    isDeleted: false,
    avaName: '',
    avaLastName: '',
    avaDni: '',
    avaNacionalidad: '',
    avaDireccion: '',
    avaTelefono: '',
    avaMovil: '',
    avaEmail: '',
    avaCcc: '',
    fechaEntrada: DateFormat.yMMMMd().format(DateTime.now()).toString(),
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
          _editedInquilino.tgss = fecha.toString();
          this._selectedDate = fecha;
        });
      }
    });
  }

  void _entradaDatePicker() {
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
          _editedInquilino.fechaEntrada = fecha.toString();
          this._fechaEntrada = fecha;
        });
      }
    });
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final arguments = ModalRoute.of(context).settings.arguments as String;

      var floorId = arguments.split(',')[0];

      var inquilinoId = arguments.split(',')[1];

      if (floorId != 'null') {
        _editedInquilino.floorId = floorId;
      } else if (inquilinoId != 'null') {
        _editedInquilino = Provider.of<Inquilinos>(context, listen: false)
            .findById(inquilinoId);
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  final _formGKey = GlobalKey<FormState>();

//DATOS PERSONALES
  final _nombreFocusNode = FocusNode();
  final _apellidosFocusNode = FocusNode();
  final _dniFocusNode = FocusNode();
  final _nacionalidadFocusNode = FocusNode();
  final _direccionFocusNode = FocusNode();
  final _telefonoFocusNode = FocusNode();
  final _movilFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _cccFocusNode = FocusNode();

//DATOS TRABAJO

  final _direccionTrabajoFocusNode = FocusNode();
  final _importeNominaFocusNode = FocusNode();
  final _tipoContratoFocusNode = FocusNode();
  final _tgssFocusNode = FocusNode();
  final _observacionesFocusNode = FocusNode();

//DATOS AVALISTA

  final _avalistaNombreFocusNode = FocusNode();
  final _avalistaApellidosFocusNode = FocusNode();
  final _avalistaDniFocusNode = FocusNode();
  final _avalistaNacionalidadFocusNode = FocusNode();
  final _avalistaDireccionFocusNode = FocusNode();
  final _avalistaTelefonoFocusNode = FocusNode();
  final _avalistaMovilFocusNode = FocusNode();
  final _avalistaEmailFocusNode = FocusNode();
  final _avalistaCccFocusNode = FocusNode();

  @override
  void dispose() {
//DATOS PERSONALES
    _nombreFocusNode.dispose();
    _apellidosFocusNode.dispose();
    _dniFocusNode.dispose();
    _nacionalidadFocusNode.dispose();
    _direccionFocusNode.dispose();
    _telefonoFocusNode.dispose();
    _movilFocusNode.dispose();
    _emailFocusNode.dispose();
    _cccFocusNode.dispose();
//DATOS TRABAJO

    _direccionTrabajoFocusNode.dispose();
    _importeNominaFocusNode.dispose();
    _tipoContratoFocusNode.dispose();
    _tgssFocusNode.dispose();
    _observacionesFocusNode.dispose();

//DATOS AVALISTA

    _avalistaNombreFocusNode.dispose();
    _avalistaApellidosFocusNode.dispose();
    _avalistaDniFocusNode.dispose();
    _avalistaNacionalidadFocusNode.dispose();
    _avalistaDireccionFocusNode.dispose();
    _avalistaTelefonoFocusNode.dispose();
    _avalistaMovilFocusNode.dispose();
    _avalistaEmailFocusNode.dispose();
    _avalistaCccFocusNode.dispose();

    super.dispose();
  }

  void _saveForm() {
    _formGKey.currentState.save();

    setState(() {
      _isLoading = true;
    });

    if (_editedInquilino.id == null) {
      Provider.of<Inquilinos>(context, listen: false)
          .addInquilino(_editedInquilino)
          .catchError((error) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Ha ocurrido un error'),
            content: Text('Asegurate que tienes conexion a internet'),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      }).then((_) {
        setState(
          () {
            _isLoading = false;
          },
        );
        Navigator.of(context).pop();
      });
    } else {
      Provider.of<Inquilinos>(context, listen: false)
          .updateInqulino(_editedInquilino)
          .then((_) {
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pop();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _editedInquilino.id == null
            ? Text('Registrar Inquilino')
            : Text('Editar Inquilino'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formGKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  color: Colors.teal.withOpacity(0.6),
                  child: ListTile(
                    title: Text(
                      'Fecha de Entrada',
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                ),
                ListTile(
                  title: Text(
                    _fechaEntrada == null
                        ? fechaActual
                        : DateFormat.yMMMMd().format(_fechaEntrada),
                    style: TextStyle(fontSize: 15),
                  ),
                  trailing: RaisedButton(
                    color: Colors.teal.shade200,
                    child: Text('Seleccionar Fecha'),
                    onPressed: () {
                      _entradaDatePicker();
                    },
                  ),
                ),
                Container(
                  color: Colors.teal.withOpacity(0.6),
                  child: ListTile(
                    title: Text(
                      'Datos Personales',
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                ),
                TextFormField(
                  initialValue: _editedInquilino.name,
                  focusNode: _nombreFocusNode,
                  decoration: InputDecoration(
                    labelText: 'Nombre',
                  ),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_apellidosFocusNode);
                  },
                  onSaved: (value) {
                    _editedInquilino.name = value;
                  },
                ),
                TextFormField(
                  initialValue: _editedInquilino.lastName,
                  focusNode: _apellidosFocusNode,
                  decoration: InputDecoration(
                    labelText: 'Apellidos',
                  ),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_dniFocusNode);
                  },
                  onSaved: (value) {
                    _editedInquilino.lastName = value;
                  },
                ),
                TextFormField(
                  initialValue: _editedInquilino.dni,
                  focusNode: _dniFocusNode,
                  decoration: InputDecoration(
                    labelText: 'DNI/NIE',
                  ),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_nacionalidadFocusNode);
                  },
                  onSaved: (value) {
                    _editedInquilino.dni = value;
                  },
                ),
                TextFormField(
                  initialValue: _editedInquilino.nacionalidad,
                  focusNode: _nacionalidadFocusNode,
                  decoration: InputDecoration(
                    labelText: 'Nacionalidad',
                  ),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_direccionFocusNode);
                  },
                  onSaved: (value) {
                    _editedInquilino.nacionalidad = value;
                  },
                ),
                TextFormField(
                  initialValue: _editedInquilino.direccion,
                  focusNode: _direccionFocusNode,
                  decoration: InputDecoration(
                    labelText: 'Direccion',
                  ),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_telefonoFocusNode);
                  },
                  onSaved: (value) {
                    _editedInquilino.direccion = value;
                  },
                ),
                TextFormField(
                  initialValue: _editedInquilino.telefono,
                  focusNode: _telefonoFocusNode,
                  decoration: InputDecoration(
                    labelText: 'Telefono',
                  ),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_movilFocusNode);
                  },
                  onSaved: (value) {
                    _editedInquilino.telefono = value;
                  },
                ),
                TextFormField(
                  initialValue: _editedInquilino.movil,
                  focusNode: _movilFocusNode,
                  decoration: InputDecoration(
                    labelText: 'Movil',
                  ),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_emailFocusNode);
                  },
                  onSaved: (value) {
                    _editedInquilino.movil = value;
                  },
                ),
                TextFormField(
                  initialValue: _editedInquilino.email,
                  focusNode: _emailFocusNode,
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_cccFocusNode);
                  },
                  onSaved: (value) {
                    _editedInquilino.email = value;
                  },
                ),
                TextFormField(
                  initialValue: _editedInquilino.ccc,
                  focusNode: _cccFocusNode,
                  decoration: InputDecoration(
                    labelText: 'C.C.C',
                  ),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context)
                        .requestFocus(_direccionTrabajoFocusNode);
                  },
                  onSaved: (value) {
                    _editedInquilino.ccc = value;
                  },
                ),
                TextFormField(
                  initialValue: _editedInquilino.observaciones,
                  focusNode: _observacionesFocusNode,
                  decoration: InputDecoration(
                    labelText: 'Observaciones',
                  ),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context)
                        .requestFocus(_direccionTrabajoFocusNode);
                  },
                  onSaved: (value) {
                    _editedInquilino.observaciones = value;
                  },
                ),
                Container(
                  color: Colors.teal.withOpacity(0.6),
                  child: ListTile(
                    title: Text(
                      'Trabajo',
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                ),
                TextFormField(
                    initialValue: _editedInquilino.direccionTrabajo,
                    focusNode: _direccionTrabajoFocusNode,
                    decoration: InputDecoration(
                      labelText: 'Direccion',
                    ),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context)
                          .requestFocus(_importeNominaFocusNode);
                    },
                    onSaved: (value) {
                      _editedInquilino.direccionTrabajo = value;
                    }),
                TextFormField(
                  initialValue: _editedInquilino.importeNomina,
                  focusNode: _importeNominaFocusNode,
                  decoration: InputDecoration(
                    labelText: 'Importe Nomina',
                  ),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_tipoContratoFocusNode);
                  },
                  onSaved: (value) {
                    _editedInquilino.importeNomina = value;
                  },
                ),
                TextFormField(
                  initialValue: _editedInquilino.tipoContrato,
                  focusNode: _tipoContratoFocusNode,
                  decoration: InputDecoration(
                    labelText: 'Tipo de contrato',
                  ),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_tgssFocusNode);
                  },
                  onSaved: (value) {
                    _editedInquilino.tipoContrato = value;
                  },
                ),
                ListTile(
                  title: Text(
                    _selectedDate == null && _editedInquilino.tgss != ''
                        ? DateFormat.yMMMMd()
                            .format(DateTime.parse(_editedInquilino.tgss))
                        : _selectedDate == null
                            ? 'TGSS'
                            : DateFormat.yMMMMd().format(_selectedDate),
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
                // TextFormField(
                //   initialValue: _editedInquilino.tgss,
                //   focusNode: _tgssFocusNode,
                //   decoration: InputDecoration(
                //     labelText: 'TGSS',
                //   ),
                //   textInputAction: TextInputAction.next,
                //   onFieldSubmitted: (_) {
                //     FocusScope.of(context)
                //         .requestFocus(_observacionesFocusNode);
                //   },
                //   onSaved: (value) {
                //     _editedInquilino.tgss = value;
                //   },
                // ),

                Container(
                  color: Colors.teal.withOpacity(0.6),
                  child: ListTile(
                    title: Text(
                      'Avalista',
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                ),
                TextFormField(
                  initialValue: _editedInquilino.avaName,
                  focusNode: _avalistaNombreFocusNode,
                  decoration: InputDecoration(
                    labelText: 'Nombre',
                  ),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context)
                        .requestFocus(_avalistaApellidosFocusNode);
                  },
                  onSaved: (value) {
                    _editedInquilino.avaName = value;
                  },
                ),
                TextFormField(
                  initialValue: _editedInquilino.avaLastName,
                  focusNode: _avalistaApellidosFocusNode,
                  decoration: InputDecoration(
                    labelText: 'Apellidos',
                  ),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_avalistaDniFocusNode);
                  },
                  onSaved: (value) {
                    _editedInquilino.avaLastName = value;
                  },
                ),
                TextFormField(
                  initialValue: _editedInquilino.avaDni,
                  focusNode: _avalistaDniFocusNode,
                  decoration: InputDecoration(
                    labelText: 'DNI/NIE',
                  ),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context)
                        .requestFocus(_avalistaNacionalidadFocusNode);
                  },
                  onSaved: (value) {
                    _editedInquilino.avaDni = value;
                  },
                ),
                TextFormField(
                  initialValue: _editedInquilino.avaNacionalidad,
                  focusNode: _avalistaNacionalidadFocusNode,
                  decoration: InputDecoration(
                    labelText: 'Nacionalidad',
                  ),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context)
                        .requestFocus(_avalistaDireccionFocusNode);
                  },
                  onSaved: (value) {
                    _editedInquilino.avaNacionalidad = value;
                  },
                ),
                TextFormField(
                  initialValue: _editedInquilino.avaDireccion,
                  focusNode: _avalistaDireccionFocusNode,
                  decoration: InputDecoration(
                    labelText: 'Direccion',
                  ),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context)
                        .requestFocus(_avalistaTelefonoFocusNode);
                  },
                  onSaved: (value) {
                    _editedInquilino.avaDireccion = value;
                  },
                ),
                TextFormField(
                  initialValue: _editedInquilino.avaTelefono,
                  focusNode: _avalistaTelefonoFocusNode,
                  decoration: InputDecoration(
                    labelText: 'Telefono',
                  ),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context)
                        .requestFocus(_avalistaMovilFocusNode);
                  },
                  onSaved: (value) {
                    _editedInquilino.avaTelefono = value;
                  },
                ),
                TextFormField(
                  initialValue: _editedInquilino.avaMovil,
                  focusNode: _avalistaMovilFocusNode,
                  decoration: InputDecoration(
                    labelText: 'Movil',
                  ),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context)
                        .requestFocus(_avalistaEmailFocusNode);
                  },
                  onSaved: (value) {
                    _editedInquilino.avaMovil = value;
                  },
                ),
                TextFormField(
                  initialValue: _editedInquilino.avaEmail,
                  focusNode: _avalistaEmailFocusNode,
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_avalistaCccFocusNode);
                  },
                  onSaved: (value) {
                    _editedInquilino.avaEmail = value;
                  },
                ),
                TextFormField(
                  initialValue: _editedInquilino.avaCcc,
                  focusNode: _avalistaCccFocusNode,
                  decoration: InputDecoration(
                    labelText: 'C.C.C',
                  ),
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) {
                    _saveForm();
                  },
                  onSaved: (value) {
                    _editedInquilino.avaCcc = value;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
